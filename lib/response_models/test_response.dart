class TestResponse {
  List<Test>? test;

  TestResponse({this.test});

  TestResponse.fromJson(Map<String, dynamic> json) {
    if (json['test'] != null) {
      test = <Test>[];
      json['test'].forEach((v) {
        test!.add(Test.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (test != null) {
      data['test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Test {
  int? id;
  String? name;
  String? password;
  int? durationInMinutes;
  int? spentTimeInMinutes;
  int? questionMobileVos;
  int? questionIds;
  int? batchIds;
  Null? questionsData;
  Null? questionsPaperData;
  int? testType;
  int? examDate;
  int? startTime;
  int? endTime;
  bool? fixedTime;
  int? numberOfQuestions;
  int? testStatus;
  int? orgId;
  int? questionPaperIds;
  List<Null>? markingTemplateVos;
  int? timeLeftForStartExam;
  String? wifiNames;
  int? attemptedQuestions;
  double? score;
  int? outOfScore;
  int? strExamDate;
  String? wifiPassword;
  String? wifiName;
  int? rank;
  Null? testLogs;
  double? bonus;
  int? reportStatus;
  int? correctAnswer;
  int? inCorrectAnswer;
  Null? questionVos;
  int? reminderTime;
  MarkingTemplate? markingTemplate;
  Null? questionMobileVosMap;
  int? syncStatus;
  bool? resultVerificationFlag;
  bool? resultShowHode;
  bool? smsFlag;
  int? mockTestType;
  int? partialAnswer;
  int? rankingSchemeType;
  int? classPracticeTest;
  int? isOnPremTest;
  Null? organisationVo;
  String? batchName;
  int? batchStatus;
  bool? jee2021Flag;
  bool? partial;
  bool? deletable;
  bool? logActive;
  bool? editable;

  Test(
      {this.id,
      this.name,
      this.password,
      this.durationInMinutes,
      this.spentTimeInMinutes,
      this.questionMobileVos,
      this.questionIds,
      this.batchIds,
      this.questionsData,
      this.questionsPaperData,
      this.testType,
      this.examDate,
      this.startTime,
      this.endTime,
      this.fixedTime,
      this.numberOfQuestions,
      this.testStatus,
      this.orgId,
      this.questionPaperIds,
      this.markingTemplateVos,
      this.timeLeftForStartExam,
      this.wifiNames,
      this.attemptedQuestions,
      this.score,
      this.outOfScore,
      this.strExamDate,
      this.wifiPassword,
      this.wifiName,
      this.rank,
      this.testLogs,
      this.bonus,
      this.reportStatus,
      this.correctAnswer,
      this.inCorrectAnswer,
      this.questionVos,
      this.reminderTime,
      this.markingTemplate,
      this.questionMobileVosMap,
      this.syncStatus,
      this.resultVerificationFlag,
      this.resultShowHode,
      this.smsFlag,
      this.mockTestType,
      this.partialAnswer,
      this.rankingSchemeType,
      this.classPracticeTest,
      this.isOnPremTest,
      this.organisationVo,
      this.batchName,
      this.batchStatus,
      this.jee2021Flag,
      this.partial,
      this.deletable,
      this.logActive,
      this.editable});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    durationInMinutes = json['durationInMinutes'];
    spentTimeInMinutes = json['spentTimeInMinutes'];
    questionMobileVos = json['questionMobileVos'];
    questionIds = json['questionIds'];
    batchIds = json['batchIds'];
    questionsData = json['questionsData'];
    questionsPaperData = json['questionsPaperData'];
    testType = json['testType'];
    examDate = json['examDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    fixedTime = json['fixedTime'];
    numberOfQuestions = json['numberOfQuestions'];
    testStatus = json['testStatus'];
    orgId = json['orgId'];
    questionPaperIds = json['questionPaperIds'];
    if (json['markingTemplateVos'] != null) {
      markingTemplateVos = <Null>[];
      // json['markingTemplateVos'].forEach((v) { markingTemplateVos!.add(new Null.fromJson(v)); });
    }
    timeLeftForStartExam = json['timeLeftForStartExam'];
    wifiNames = json['wifiNames'];
    attemptedQuestions = json['attemptedQuestions'];
    score = json['score'];
    outOfScore = json['outOfScore'];
    strExamDate = json['strExamDate'];
    wifiPassword = json['wifiPassword'];
    wifiName = json['wifiName'];
    rank = json['rank'];
    testLogs = json['testLogs'];
    bonus = json['bonus'];
    reportStatus = json['reportStatus'];
    correctAnswer = json['correctAnswer'];
    inCorrectAnswer = json['inCorrectAnswer'];
    questionVos = json['questionVos'];
    reminderTime = json['reminderTime'];
    markingTemplate = json['markingTemplate'] != null
        ? MarkingTemplate.fromJson(json['markingTemplate'])
        : null;
    questionMobileVosMap = json['questionMobileVosMap'];
    syncStatus = json['syncStatus'];
    resultVerificationFlag = json['resultVerificationFlag'];
    resultShowHode = json['resultShowHode'];
    smsFlag = json['smsFlag'];
    mockTestType = json['mockTestType'];
    partialAnswer = json['partialAnswer'];
    rankingSchemeType = json['rankingSchemeType'];
    classPracticeTest = json['classPracticeTest'];
    isOnPremTest = json['isOnPremTest'];
    organisationVo = json['organisationVo'];
    batchName = json['batchName'];
    batchStatus = json['batchStatus'];
    jee2021Flag = json['jee2021Flag'];
    partial = json['partial'];
    deletable = json['deletable'];
    logActive = json['logActive'];
    editable = json['editable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['durationInMinutes'] = durationInMinutes;
    data['spentTimeInMinutes'] = spentTimeInMinutes;
    data['questionMobileVos'] = questionMobileVos;
    data['questionIds'] = questionIds;
    data['batchIds'] = batchIds;
    data['questionsData'] = questionsData;
    data['questionsPaperData'] = questionsPaperData;
    data['testType'] = testType;
    data['examDate'] = examDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['fixedTime'] = fixedTime;
    data['numberOfQuestions'] = numberOfQuestions;
    data['testStatus'] = testStatus;
    data['orgId'] = orgId;
    data['questionPaperIds'] = questionPaperIds;
    if (markingTemplateVos != null) {
      // data['markingTemplateVos'] = this.markingTemplateVos!.map((v) => v.toJson()).toList();
    }
    data['timeLeftForStartExam'] = timeLeftForStartExam;
    data['wifiNames'] = wifiNames;
    data['attemptedQuestions'] = attemptedQuestions;
    data['score'] = score;
    data['outOfScore'] = outOfScore;
    data['strExamDate'] = strExamDate;
    data['wifiPassword'] = wifiPassword;
    data['wifiName'] = wifiName;
    data['rank'] = rank;
    data['testLogs'] = testLogs;
    data['bonus'] = bonus;
    data['reportStatus'] = reportStatus;
    data['correctAnswer'] = correctAnswer;
    data['inCorrectAnswer'] = inCorrectAnswer;
    data['questionVos'] = questionVos;
    data['reminderTime'] = reminderTime;
    if (markingTemplate != null) {
      data['markingTemplate'] = markingTemplate!.toJson();
    }
    data['questionMobileVosMap'] = questionMobileVosMap;
    data['syncStatus'] = syncStatus;
    data['resultVerificationFlag'] = resultVerificationFlag;
    data['resultShowHode'] = resultShowHode;
    data['smsFlag'] = smsFlag;
    data['mockTestType'] = mockTestType;
    data['partialAnswer'] = partialAnswer;
    data['rankingSchemeType'] = rankingSchemeType;
    data['classPracticeTest'] = classPracticeTest;
    data['isOnPremTest'] = isOnPremTest;
    data['organisationVo'] = organisationVo;
    data['batchName'] = batchName;
    data['batchStatus'] = batchStatus;
    data['jee2021Flag'] = jee2021Flag;
    data['partial'] = partial;
    data['deletable'] = deletable;
    data['logActive'] = logActive;
    data['editable'] = editable;
    return data;
  }
}

class MarkingTemplate {
  MarkingTemplate();

  MarkingTemplate.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
