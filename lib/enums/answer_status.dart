// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeeni/pages/dashboard/test/test_page.dart';
import 'package:jeeni/utils/app_colour.dart';

enum AnswerStatus {
  NOT_VISITED,
  NOT_ANSWERED,
  ANSWERED,
  MARK_FOR_REVIEW,
  ANSWERED_AND_MARK_FOR_REVIEW;

  static AnswerStatus getAnswerStatus(int status) {
    switch (status) {
      case 0:
        return AnswerStatus.NOT_ANSWERED;
      case 1:
        return AnswerStatus.ANSWERED;
      case 2:
        return AnswerStatus.MARK_FOR_REVIEW;
      case 3:
        return AnswerStatus.ANSWERED_AND_MARK_FOR_REVIEW;
    }
    return AnswerStatus.NOT_ANSWERED;
  }

  Color? get backgroundColur {
    switch (this) {
      case AnswerStatus.NOT_VISITED:
      case AnswerStatus.NOT_ANSWERED:
        return Colors.grey[300];
      case AnswerStatus.ANSWERED:
        return TestPageColour.answeredColor;
      case AnswerStatus.MARK_FOR_REVIEW:
        return TestPageColour.markForReviewColor;
      case AnswerStatus.ANSWERED_AND_MARK_FOR_REVIEW:
        return TestPageColour.markForReviewColor;
    }
  }
}
