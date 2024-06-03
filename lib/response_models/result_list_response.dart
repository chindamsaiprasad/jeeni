class ResultModelClass {
  ResultModelClass({
    required this.id,
    required this.name,
    required this.password,
    required this.durationInMinutes,
    required this.spentTimeInMinutes,
    required this.testType,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.fixedTime,
    required this.numberOfQuestions,
    required this.testStatus,
    required this.orgId,
    required this.markingTemplateVos,
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
    required this.markingTemplate,
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
  late final String password;
  late final int durationInMinutes;
  late final int spentTimeInMinutes;
  late final int testType;
  late final int examDate;
  late final int startTime;
  late final int endTime;
  late final bool fixedTime;
  late final int numberOfQuestions;
  late final int testStatus;
  late final int orgId;
  late final List<dynamic> markingTemplateVos;
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
  late final MarkingTemplate markingTemplate;
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
  
  ResultModelClass.fromJson(Map<String, dynamic> json){
    // print("1");
    id = json['id'];
    // print("2");
    name = json['name'];
    // print("3");
    password = json['password'] ?? "";
    // print("4");
    durationInMinutes = json['durationInMinutes'];
    // print("5");
    spentTimeInMinutes = json['spentTimeInMinutes'];
    // print("6");
    testType = json['testType'];
    // print("7");
    examDate = json['examDate'];
    // print("8");
    startTime = json['startTime'];
    // print("9");
    endTime = json['endTime'];
    // print("10");
    fixedTime = json['fixedTime'];
    // print("11");
    numberOfQuestions = json['numberOfQuestions'];
    // print("12");
    testStatus = json['testStatus'];
    // print("13");
    orgId = json['orgId'];
    // print("14");
    markingTemplateVos = List.castFrom<dynamic, dynamic>(json['markingTemplateVos']);
    // print("15");
    timeLeftForStartExam = json['timeLeftForStartExam'];
    // print("16");
    isDeletable = json['isDeletable'];
    // print("17");
    attemptedQuestions = json['attemptedQuestions'];
    // print("18");
    score = json['score'];
    // print("19");
    outOfScore = json['outOfScore'];
    // print("20");
    strExamDate = json['strExamDate'];
    // print("21");
    rank = json['rank'];
    // print("22");
    isLogActive = json['isLogActive'];
    // print("23");
    isEditable = json['isEditable'];
    // print("24");
    bonus = json['bonus'];
    // print("25");
    reportStatus = json['reportStatus'];
    // print("26");
    correctAnswer = json['correctAnswer'];
    // print("27");
    inCorrectAnswer = json['inCorrectAnswer'];
    // print("28");
    markingTemplate = MarkingTemplate.fromJson(json['markingTemplate']);
    // print("29");
    isPartial = json['isPartial'];
    // print("30");
    syncStatus = json['syncStatus'];
    // print("31");
    resultVerificationFlag = json['resultVerificationFlag'];
    // print("32");
    resultShowHode = json['resultShowHode'];
    // print("33");
    smsFlag = json['smsFlag'];
    // print("34");
    mockTestType = json['mockTestType'];
    // print("35");
    partialAnswer = json['partialAnswer'];
    // print("36");
    rankingSchemeType = json['rankingSchemeType'];
    // print("37");
    classPracticeTest = json['classPracticeTest'];
    // print("38");
    isOnPremTest = json['isOnPremTest'];
    // print("39");
    batchName = json['batchName'];
    // print("40");
    batchStatus = json['batchStatus'];
    // print("41");
    jee2021Flag = json['jee2021Flag'];
    // print("42");
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['password'] = password;
    _data['durationInMinutes'] = durationInMinutes;
    _data['spentTimeInMinutes'] = spentTimeInMinutes;
    _data['testType'] = testType;
    _data['examDate'] = examDate;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['fixedTime'] = fixedTime;
    _data['numberOfQuestions'] = numberOfQuestions;
    _data['testStatus'] = testStatus;
    _data['orgId'] = orgId;
    _data['markingTemplateVos'] = markingTemplateVos;
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
    _data['markingTemplate'] = markingTemplate.toJson();
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

class MarkingTemplate {
  MarkingTemplate();
  
  MarkingTemplate.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}