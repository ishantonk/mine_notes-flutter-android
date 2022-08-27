import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AccountCubit() : super(AccountInitial());

//--------------------------------Sign with google account--------------------------------//

  // Sign up with google account or create a new account
  void signUpWithGoogle() async {
    emit(AccountLoading());
    try {
      // Get google account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Get google authentication
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Get credential(token)
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Sign in with credential(token)
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      // Store user
      final User? user = authResult.user;

      if (user != null) {
        // Store token and userCredential in secure storage for later use or to stay logged in
        storeToken(authResult);
        emit(AccountSuccess(user));
      } else {
        emit(AccountError(const {'error': 'User is null'}));
      }
      emit(AccountSuccess(user));
    } catch (error) {
      emit(AccountError({'error': error.toString()}));
    }
  }

  // Sign in with google account or login
  void signInWithGoogle() async {
    emit(AccountLoading());
    try {
      // Get google account email
      final String? googleUserEmail = GoogleSignIn().currentUser?.email;
      // Check if email is in database
      final QuerySnapshot querySnapshot = await _firestore
          .collection('Users')
          .where('email', isEqualTo: googleUserEmail)
          .get();
      // If email is in database, sign in with email and password
      if (querySnapshot.docs.isNotEmpty) {
        // Get google account
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        // Get google authentication
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        // Get credential(token)
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        // Sign in with credential(token)
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        // Store user
        final User? user = authResult.user;
        if (user != null) {
          // Store token and userCredential in secure storage for later use or to stay logged in
          storeToken(authResult);
          emit(AccountSuccess(user));
        } else {
          emit(AccountError(const {'error': 'User is null'}));
        }
      } else {
        // If email is not in database, show error
        emit(AccountError(const {'email': 'Email is not registered'}));
      }
    } catch (error) {
      log(error.toString());
      emit(AccountError({'error': error.toString()}));
    }
  }

//--------------------------------Sign with email and password--------------------------------//

  // Sign up with email and password
  void signUpWithEmailAndPassword(
      String email, String password, String confirmPassword) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      if (email.isEmpty) {
        emit(AccountError(const {'email': 'Email is required'}));
      } else if (password.isEmpty) {
        emit(AccountError(const {'password': 'Password is required'}));
      } else if (confirmPassword.isEmpty) {
        emit(AccountError(
            const {'confirmPassword': 'Confirm password is required'}));
      }
      return;
    } else if (EmailValidator.validate(email) == false) {
      emit(AccountError(const {'email': 'Email is invalid'}));
      return;
    } else if (password != confirmPassword) {
      emit(AccountError(const {'confirmPassword': 'Passwords do not match'}));
      return;
    } else if (password.length < 6) {
      emit(AccountError(
          const {'password': 'Password must be at least 6 characters'}));
      return;
    } else {
      emit(AccountLoading());
      try {
        // Create user with email and password
        final UserCredential authResult = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        // Store user
        final User? user = authResult.user;
        if (user != null) {
          // Store token and userCredential in secure storage for later use or to stay logged in
          storeToken(authResult);
          emit(AccountSuccess(user));
        } else {
          emit(AccountError(const {'error': 'User is null'}));
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          emit(AccountError(const {'password': 'Password is too weak'}));
        } else if (error.code == 'email-already-in-use') {
          emit(AccountError(const {'email': 'Email is already in use'}));
        } else {
          emit(AccountError(const {'unknown': 'Unknown error'}));
        }
      } catch (error) {
        emit(AccountError({'error': error.toString()}));
      }
    }
  }

  // Sign in with email and password
  void signInWithEmailAndPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) {
        emit(AccountError(const {'email': 'Email is required'}));
      } else if (password.isEmpty) {
        emit(AccountError(const {'password': 'Password is required'}));
      }
      return;
    } else if (EmailValidator.validate(email) == false) {
      emit(AccountError(const {'email': 'Email is invalid'}));
      return;
    } else {
      emit(AccountLoading());
      try {
        // Sign in with email and password
        final UserCredential authResult = await _auth
            .signInWithEmailAndPassword(email: email, password: password);
        // Store user
        final User? user = authResult.user;
        if (user != null) {
          // Store token and userCredential in secure storage for later use or to stay logged in
          storeToken(authResult);
          emit(AccountSuccess(user));
        } else {
          emit(AccountError(const {'error': 'User is null'}));
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'wrong-password') {
          emit(AccountError(const {'password': 'Password is incorrect'}));
        } else if (error.code == 'user-not-found') {
          emit(AccountError(const {'email': 'Email is not registered'}));
        } else {
          emit(AccountError(const {'unknown': 'Unknown error'}));
        }
      } catch (error) {
        emit(AccountError({'error': error.toString()}));
      }
    }
  }

  // Function to store token and userCredential in secure storage for later use or to stay logged in
  void storeToken(UserCredential userCredential) async {
    await _secureStorage.write(
      key: 'token',
      value: userCredential.credential?.token.toString(),
    );
  }

  // Function to get token from secure storage
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  //--------------------------------Create user details in 'User'--------------------------------//

  // Create user details in 'User'
  void createUserDetails(User user, String name, File? profileImage) async {
    if (name.isEmpty) {
      emit(AccountError(const {'name': 'Name is required'}));
      return;
    } else {
      emit(AccountLoading());
      try {
        // Create user details in 'User' collection
        final String userId = user.uid;

        // Create a document with 'document ID' = userId(user.uid)
        final DocumentReference documentReference =
            _firestore.collection('Users').doc(userId);

        if (profileImage != null) {
          // Get image url
          final String profileImageUrl =
              await _uploadProfileImage(profileImage);

          // Set data in document with profileImageUrl
          await documentReference.set({
            'name': name,
            'email': user.email,
            'profileImage': profileImageUrl,
            'createdAt': FieldValue.serverTimestamp(),
          });
        } else {
          // Set data in document without profileImageUrl
          await documentReference.set({
            'name': name,
            'email': user.email,
            'profileImage': '',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
        emit(AccountSuccess(user));
      } catch (error) {
        emit(AccountError({'error': error.toString()}));
      }
    }
  }

  // Helper function for choosing profile image
  void chooseProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(AccountLoading());
    try {
      if (image != null) {
        File profilePic = File(image.path);
        emit(AccountChangeProfile(profilePic));
      } else {
        emit(AccountError(const {'error': 'Image is null'}));
      }
    } catch (error) {
      emit(AccountError({'error': error.toString()}));
    }
  }

  // Helper function for uploading profile image and getting url
  Future<String> _uploadProfileImage(File profileImage) async {
    UploadTask uploadTask = _storage
        .ref()
        .child('profile_images')
        .child(const Uuid().v1())
        .putFile(profileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
