class TestSoltuionsModelClass {
  TestSoltuionsModelClass({
    required this.id,
    required this.name,
    required this.durationInMinutes,
    required this.spentTimeInMinutes,
    required this.questionMobileVos,
    required this.testType,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.fixedTime,
    required this.numberOfQuestions,
    required this.testStatus,
    required this.orgId,
    required this.timeLeftForStartExam,
    required this.isDeletable,
    required this.attemptedQuestions,
    required this.score,
    required this.outOfScore,
    required this.strExamDate,
    required this.rank,
    required this.isLogActive,
    required this.isEditable,
    required this.bonus,
    required this.reportStatus,
    required this.correctAnswer,
    required this.inCorrectAnswer,
    required this.isPartial,
    required this.syncStatus,
    required this.resultVerificationFlag,
    required this.resultShowHode,
    required this.smsFlag,
    required this.mockTestType,
    required this.partialAnswer,
    required this.rankingSchemeType,
    required this.classPracticeTest,
    required this.isOnPremTest,
    required this.batchName,
    required this.batchStatus,
    required this.jee2021Flag,
  });
  late final int id;
  late final String name;
  late final int durationInMinutes;
  late final int spentTimeInMinutes;
  late final List<QuestionMobileVosTwo> questionMobileVos;
  late final int testType;
  late final int examDate;
  late final int startTime;
  late final int endTime;
  late final bool fixedTime;
  late final int numberOfQuestions;
  late final int testStatus;
  late final int orgId;
  late final int timeLeftForStartExam;
  late final bool isDeletable;
  late final int attemptedQuestions;
  late final double score;
  late final int outOfScore;
  late final String strExamDate;
  late final int rank;
  late final bool isLogActive;
  late final bool isEditable;
  late final double bonus;
  late final int reportStatus;
  late final int correctAnswer;
  late final int inCorrectAnswer;
  late final bool isPartial;
  late final int syncStatus;
  late final bool resultVerificationFlag;
  late final bool resultShowHode;
  late final bool smsFlag;
  late final int mockTestType;
  late final int partialAnswer;
  late final int rankingSchemeType;
  late final int classPracticeTest;
  late final int isOnPremTest;
  late final String batchName;
  late final int batchStatus;
  late final bool jee2021Flag;
  
  TestSoltuionsModelClass.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  // print("1. id: $id");
  name = json['name'];
  // print("2. name: $name");
  durationInMinutes = json['durationInMinutes'];
  // print("3. durationInMinutes: $durationInMinutes");
  spentTimeInMinutes = json['spentTimeInMinutes'];
  // print("4. spentTimeInMinutes: $spentTimeInMinutes");
  questionMobileVos = (json['questionMobileVos'] as List<dynamic>)
      .map((e) => QuestionMobileVosTwo.fromJson(e))
      .toList();
  // print("5. questionMobileVos: ${json['questionMobileVos']}");

  testType = json['testType'];
  // print("6. testType: $testType");
  examDate = json['examDate'];
  // print("7. examDate: $examDate");
  startTime = json['startTime'];
  // print("8. startTime: $startTime");
  endTime = json['endTime'];
  // print("9. endTime: $endTime");
  fixedTime = json['fixedTime'];
  // print("10. fixedTime: $fixedTime");
  numberOfQuestions = json['numberOfQuestions'];
  // print("11. numberOfQuestions: $numberOfQuestions");
  testStatus = json['testStatus'];
  // print("12. testStatus: $testStatus");
  orgId = json['orgId'];
  // print("13. orgId: $orgId");
  timeLeftForStartExam = json['timeLeftForStartExam'];
  // print("14. timeLeftForStartExam: $timeLeftForStartExam");
  isDeletable = json['isDeletable'];
  // print("15. isDeletable: $isDeletable");
  attemptedQuestions = json['attemptedQuestions'];
  // print("16. attemptedQuestions: $attemptedQuestions");
  score = json['score'];
  // print("17. score: $score");
  outOfScore = json['outOfScore'];
  // print("18. outOfScore: $outOfScore");
  strExamDate = json['strExamDate'];
  // print("19. strExamDate: $strExamDate");
  rank = json['rank'];
  // print("20. rank: $rank");
  isLogActive = json['isLogActive'];
  // print("21. isLogActive: $isLogActive");
  isEditable = json['isEditable'];
  // print("22. isEditable: $isEditable");
  bonus = json['bonus'];
  // print("23. bonus: $bonus");
  reportStatus = json['reportStatus'];
  // print("24. reportStatus: $reportStatus");
  correctAnswer = json['correctAnswer'];
  // print("25. correctAnswer: $correctAnswer");
  inCorrectAnswer = json['inCorrectAnswer'];
  // print("26. inCorrectAnswer: $inCorrectAnswer");
  isPartial = json['isPartial'];
  // print("27. isPartial: $isPartial");
  syncStatus = json['syncStatus'];
  // print("28. syncStatus: $syncStatus");
  resultVerificationFlag = json['resultVerificationFlag'];
  // print("29. resultVerificationFlag: $resultVerificationFlag");
  resultShowHode = json['resultShowHode'];
  // print("30. resultShowHode: $resultShowHode");
  smsFlag = json['smsFlag'];
  // print("31. smsFlag: $smsFlag");
  mockTestType = json['mockTestType'];
  // print("32. mockTestType: $mockTestType");
  partialAnswer = json['partialAnswer'];
  // print("33. partialAnswer: $partialAnswer");
  rankingSchemeType = json['rankingSchemeType'];
  // print("34. rankingSchemeType: $rankingSchemeType");
  classPracticeTest = json['classPracticeTest'];
  // print("35. classPracticeTest: $classPracticeTest");
  isOnPremTest = json['isOnPremTest'];
  // print("36. isOnPremTest: $isOnPremTest");
  batchName = json['batchName'];
  // print("37. batchName: $batchName");
  batchStatus = json['batchStatus'];
  // print("38. batchStatus: $batchStatus");
  jee2021Flag = json['jee2021Flag'];
  // print("39. jee2021Flag: $jee2021Flag");
}


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['durationInMinutes'] = durationInMinutes;
    _data['spentTimeInMinutes'] = spentTimeInMinutes;
    _data['questionMobileVos'] = questionMobileVos.map((e)=>e.toJson()).toList();
    _data['testType'] = testType;
    _data['examDate'] = examDate;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['fixedTime'] = fixedTime;
    _data['numberOfQuestions'] = numberOfQuestions;
    _data['testStatus'] = testStatus;
    _data['orgId'] = orgId;
    _data['timeLeftForStartExam'] = timeLeftForStartExam;
    _data['isDeletable'] = isDeletable;
    _data['attemptedQuestions'] = attemptedQuestions;
    _data['score'] = score;
    _data['outOfScore'] = outOfScore;
    _data['strExamDate'] = strExamDate;
    _data['rank'] = rank;
    _data['isLogActive'] = isLogActive;
    _data['isEditable'] = isEditable;
    _data['bonus'] = bonus;
    _data['reportStatus'] = reportStatus;
    _data['correctAnswer'] = correctAnswer;
    _data['inCorrectAnswer'] = inCorrectAnswer;
    _data['isPartial'] = isPartial;
    _data['syncStatus'] = syncStatus;
    _data['resultVerificationFlag'] = resultVerificationFlag;
    _data['resultShowHode'] = resultShowHode;
    _data['smsFlag'] = smsFlag;
    _data['mockTestType'] = mockTestType;
    _data['partialAnswer'] = partialAnswer;
    _data['rankingSchemeType'] = rankingSchemeType;
    _data['classPracticeTest'] = classPracticeTest;
    _data['isOnPremTest'] = isOnPremTest;
    _data['batchName'] = batchName;
    _data['batchStatus'] = batchStatus;
    _data['jee2021Flag'] = jee2021Flag;
    return _data;
  }
}

class QuestionMobileVosTwo {
  QuestionMobileVosTwo({
    required this.id,
    required this.answerValidity,
    required this.type,
    required this.solutionAvailable,
    required this.durationInMinutes,
    required this.status,
    required this.userSelectedOption,
    required this.questionTypeId,
    required this.section,
    required this.questionType,
    required this.isMultipleAnswer,
    required this.positiveMark,
    required this.negativeMark,
    required this.groupId,
    required this.answerStatus,
    required this.numericAnswerDifference,
    required this.partialRule,
    required this.columnMatchAnswer,
    required this.questionUrl,
    required this.solutionUrl,
  });
  late final int id;
  late final List<bool> answerValidity;
  late final int type;
  late final bool solutionAvailable;
  late final int durationInMinutes;
  late final int status;
  late final String userSelectedOption;
  late final int questionTypeId;
  late final String section;
  late final String questionType;
  late final bool isMultipleAnswer;
  late final double positiveMark;
  late final double negativeMark;
  late final int groupId;
  late final int answerStatus;
  late final String numericAnswerDifference;
  late final int partialRule;
  late final List<Null?> columnMatchAnswer;
  late final String questionUrl;
  late final String solutionUrl;
  
  QuestionMobileVosTwo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    answerValidity = List.castFrom<dynamic, bool>(json['answerValidity']);
    type = json['type'];
    solutionAvailable = json['solutionAvailable'];
    durationInMinutes = json['durationInMinutes'];
    status = json['status'];
    userSelectedOption = json['userSelectedOption'];
    questionTypeId = json['questionTypeId'];
    section = json['section'];
    questionType = json['questionType'];
    isMultipleAnswer = json['isMultipleAnswer'];
    positiveMark = json['positiveMark'];
    negativeMark = json['negativeMark'];
    groupId = json['groupId'];
    answerStatus = json['answerStatus'];
    numericAnswerDifference = json['numericAnswerDifference'];
    partialRule = json['partialRule'];
    columnMatchAnswer = List.castFrom<dynamic, Null?>(json['columnMatchAnswer']);
    questionUrl = json['questionUrl'];
    solutionUrl = json['solutionUrl'];
  }

  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['answerValidity'] = answerValidity;
    _data['type'] = type;
    _data['solutionAvailable'] = solutionAvailable;
    _data['durationInMinutes'] = durationInMinutes;
    _data['status'] = status;
    _data['userSelectedOption'] = userSelectedOption;
    _data['questionTypeId'] = questionTypeId;
    _data['section'] = section;
    _data['questionType'] = questionType;
    _data['isMultipleAnswer'] = isMultipleAnswer;
    _data['positiveMark'] = positiveMark;
    _data['negativeMark'] = negativeMark;
    _data['groupId'] = groupId;
    _data['answerStatus'] = answerStatus;
    _data['numericAnswerDifference'] = numericAnswerDifference;
    _data['partialRule'] = partialRule;
    _data['columnMatchAnswer'] = columnMatchAnswer;
    _data['questionUrl'] = questionUrl;
    _data['solutionUrl'] = solutionUrl;
    return _data;
  }
}