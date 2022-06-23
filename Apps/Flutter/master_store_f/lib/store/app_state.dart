import 'package:flutter/material.dart';

@immutable
class AppState {
  //AdReducer
  final List<dynamic> _allItems;
  final bool isUploading;
  final double uploadStatus;
  List get allItems => _allItems;
  final String? ownerId;
  final String imageUrl;
  final String? contactEmail;

  //LoginReducer
  final String token;
  final String userId;
  final String email;
  final bool signupStatus;

  const AppState(
      this._allItems,
      this.isUploading,
      this.uploadStatus,
      this.ownerId,
      this.imageUrl,
      this.contactEmail,
      this.token,
      this.userId,
      this.email,
      this.signupStatus);

  AppState.initialState()
      : _allItems = [],
        isUploading = false,
        uploadStatus = 0.0,
        ownerId = null,
        imageUrl = "",
        contactEmail = "",
        token = "",
        userId = "",
        email = "",
        signupStatus = false;

  AppState copyWith(
      {List<dynamic>? allItems,
      bool? isUploading,
      double? uploadStatus,
      List<dynamic>? userChats,
      String? ownerId,
      String? currentChatId,
      bool? initialChatState,
      String? imageUrl,
      String? contactEmail,
      String? token,
      String? userId,
      String? email,
      bool? signupStatus}) {
    allItems = allItems ?? _allItems;
    isUploading = isUploading ?? this.isUploading;
    uploadStatus = uploadStatus ?? this.uploadStatus;

    ownerId = ownerId ?? this.ownerId;

    imageUrl = imageUrl ?? this.imageUrl;
    contactEmail = contactEmail ?? this.contactEmail;
    token = token ?? this.token;
    userId = userId ?? this.userId;
    email = email ?? this.email;
    signupStatus = signupStatus ?? this.signupStatus;

    return AppState(allItems, isUploading, uploadStatus, currentChatId,
        imageUrl, contactEmail, token, userId, email, signupStatus);
  }
}
