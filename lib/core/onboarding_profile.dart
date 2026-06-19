import 'package:flutter/material.dart';

@immutable
class OnboardingProfile {
  const OnboardingProfile({
    this.name,
    this.birthDate,
    this.birthTime,
    this.birthLocation,
    this.username,
  });

  final String? name;
  final DateTime? birthDate;
  final TimeOfDay? birthTime;
  final String? birthLocation;
  final String? username;

  OnboardingProfile copyWith({
    String? name,
    DateTime? birthDate,
    TimeOfDay? birthTime,
    String? birthLocation,
    String? username,
  }) {
    return OnboardingProfile(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthLocation: birthLocation ?? this.birthLocation,
      username: username ?? this.username,
    );
  }
}
