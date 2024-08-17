import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> _userWishList = [];
  String _profileImageUrl = '';
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserWishList();
    _loadUserProfile();
  }

  Future<void> _loadUserWishList() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final _uid = user.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (doc.exists && doc.data() != null && doc.data()!['userWish'] != null) {
        setState(() {
          _userWishList =
              List<Map<String, dynamic>>.from(doc.data()!['userWish']);
        });
      }
    }
  }

  Future<void> _loadUserProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final _uid = user.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (doc.exists &&
          doc.data() != null &&
          doc.data()!['profilePicture'] != null) {
        setState(() {
          _profileImageUrl = doc.data()!['profilePicture'];
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      await _uploadProfileImage(imageFile);
    }
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final _uid = user.uid;
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$_uid.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the user's profile picture URL in both FirebaseAuth and Firestore
      await user.updatePhotoURL(downloadUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .update({'profilePicture': downloadUrl});

      setState(() {
        _profileImageUrl = downloadUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'User';
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: const Color.fromARGB(
            255, 9, 88, 148), // Couleur similaire à celle de l'image
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splashbg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl.isNotEmpty
                    ? NetworkImage(_profileImageUrl)
                    : null,
                child: _profileImageUrl.isEmpty
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Change Profile Picture',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _userWishList.isEmpty
                    ? const Center(
                        child: Text('Your wishlist is empty',
                            style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                        itemCount: _userWishList.length,
                        itemBuilder: (context, index) {
                          final wishItem = _userWishList[index];
                          return Card(
                            color: Colors.white70,
                            child: ListTile(
                              title: Text(wishItem['itemName'],
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text(
                                  'Page Number: ${wishItem['itemNumber']}',
                                  style:
                                      const TextStyle(color: Colors.black54)),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await _removeFromWishlist(wishItem);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _removeFromWishlist(Map<String, dynamic> wishItem) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final _uid = user.uid;
      final docRef = FirebaseFirestore.instance.collection('users').doc(_uid);
      await docRef.update({
        'userWish': FieldValue.arrayRemove([wishItem])
      });

      setState(() {
        _userWishList.remove(wishItem);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from your wishes')),
      );
    }
  }
}
