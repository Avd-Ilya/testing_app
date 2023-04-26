import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:core/web_client.dart';
import 'package:testing_app/main/service/main_service.dart';
import 'package:testing_app/main/service/model/chapter_dto.dart';
import 'package:testing_app/main/service/model/class_dto.dart';
import 'package:testing_app/main/service/model/subject_dto.dart';
import 'package:testing_app/main/service/model/test_dto.dart';
import 'package:testing_app/profile/service/model/user_profile_dto.dart';
import 'package:fpdart/src/either.dart';
import 'package:testing_app/profile/service/profile_service.dart';

class MainServiceImpl implements MainService {
  @override
  Future<Either<FormatException, List<ClassDto>?>> getClasses() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/classes');
      var classes = classesDtoFromJson(response);
      return Right(classes);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  } 

    @override
  Future<Either<FormatException, List<SubjectDto>?>> getSubjects() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/subjects');
      var subjects = subjectsDtoFromJson(response);
      return Right(subjects);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  }

  @override
  Future<Either<FormatException, List<ChapterDto>?>> getChapters() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/chapters');
      var chapters = chaptersDtoFromJson(response);
      return Right(chapters);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  } 

    @override
  Future<Either<FormatException, List<TestDto>?>> getTests() async {
    var webClient = WebClient();

    try {
      var response = await webClient.get('/tests');
      var tests = testsDtoFromJson(response);
      return Right(tests);
    } catch (error) {
      return Left(FormatException(error.toString()));
    }
  } 
}