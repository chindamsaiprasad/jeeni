// ignore_for_file: public_member_api_docs, sort_constructors_first

class ViewSolution {
  int? id;
  String? name;
  int? durationInMinutes;
  int? spentTimeInMinutes;
  List<QuestionMobileVosResult>? questionMobileVos;
  int? testType;
  int? examDate;
  int? startTime;
  int? endTime;
  bool? fixedTime;
  int? numberOfQuestions;
  int? testStatus;
  int? orgId;
  int? timeLeftForStartExam;
  bool? isDeletable;
  int? attemptedQuestions;
  int? score;
  int? outOfScore;
  String? strExamDate;
  int? rank;
  bool? isLogActive;
  bool? isEditable;
  int? bonus;
  int? reportStatus;
  int? correctAnswer;
  int? inCorrectAnswer;
  bool? isPartial;
  int? syncStatus;
  bool? resultVerificationFlag;
  bool? resultShowHode;
  bool? smsFlag;
  int? mockTestType;
  int? partialAnswer;
  int? rankingSchemeType;
  int? classPracticeTest;
  int? isOnPremTest;
  String? batchName;
  int? batchStatus;
  bool? jee2021Flag;

  ViewSolution(
      {this.id,
      this.name,
      this.durationInMinutes,
      this.spentTimeInMinutes,
      this.questionMobileVos,
      this.testType,
      this.examDate,
      this.startTime,
      this.endTime,
      this.fixedTime,
      this.numberOfQuestions,
      this.testStatus,
      this.orgId,
      this.timeLeftForStartExam,
      this.isDeletable,
      this.attemptedQuestions,
      this.score,
      this.outOfScore,
      this.strExamDate,
      this.rank,
      this.isLogActive,
      this.isEditable,
      this.bonus,
      this.reportStatus,
      this.correctAnswer,
      this.inCorrectAnswer,
      this.isPartial,
      this.syncStatus,
      this.resultVerificationFlag,
      this.resultShowHode,
      this.smsFlag,
      this.mockTestType,
      this.partialAnswer,
      this.rankingSchemeType,
      this.classPracticeTest,
      this.isOnPremTest,
      this.batchName,
      this.batchStatus,
      this.jee2021Flag});

  ViewSolution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    durationInMinutes = json['durationInMinutes'];
    spentTimeInMinutes = json['spentTimeInMinutes'];
    if (json['questionMobileVos'] != null) {
      questionMobileVos = <QuestionMobileVosResult>[];
      json['questionMobileVos'].forEach((v) {
        questionMobileVos!.add(QuestionMobileVosResult.fromJson(v));
      });
    }
    // testType = json['testType'];
    // examDate = json['examDate'];
    // startTime = json['startTime'];
    // endTime = json['endTime'];
    // fixedTime = json['fixedTime'];
    // numberOfQuestions = json['numberOfQuestions'];
    // testStatus = json['testStatus'];
    // orgId = json['orgId'];
    // timeLeftForStartExam = json['timeLeftForStartExam'];
    // isDeletable = json['isDeletable'];
    // attemptedQuestions = json['attemptedQuestions'];
    // score = json['score'];
    // outOfScore = json['outOfScore'];
    // strExamDate = json['strExamDate'];
    // rank = json['rank'];
    // isLogActive = json['isLogActive'];
    // isEditable = json['isEditable'];
    // bonus = json['bonus'];
    // reportStatus = json['reportStatus'];
    // correctAnswer = json['correctAnswer'];
    // inCorrectAnswer = json['inCorrectAnswer'];
    // isPartial = json['isPartial'];
    // syncStatus = json['syncStatus'];
    // resultVerificationFlag = json['resultVerificationFlag'];
    // resultShowHode = json['resultShowHode'];
    // smsFlag = json['smsFlag'];
    // mockTestType = json['mockTestType'];
    // partialAnswer = json['partialAnswer'];
    // rankingSchemeType = json['rankingSchemeType'];
    // classPracticeTest = json['classPracticeTest'];
    // isOnPremTest = json['isOnPremTest'];
    // batchName = json['batchName'];
    // batchStatus = json['batchStatus'];
    // jee2021Flag = json['jee2021Flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['durationInMinutes'] = durationInMinutes;
    data['spentTimeInMinutes'] = spentTimeInMinutes;
    if (questionMobileVos != null) {
      data['questionMobileVos'] =
          questionMobileVos!.map((v) => v.toJson()).toList();
    }
    data['testType'] = testType;
    data['examDate'] = examDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['fixedTime'] = fixedTime;
    data['numberOfQuestions'] = numberOfQuestions;
    data['testStatus'] = testStatus;
    data['orgId'] = orgId;
    data['timeLeftForStartExam'] = timeLeftForStartExam;
    data['isDeletable'] = isDeletable;
    data['attemptedQuestions'] = attemptedQuestions;
    data['score'] = score;
    data['outOfScore'] = outOfScore;
    data['strExamDate'] = strExamDate;
    data['rank'] = rank;
    data['isLogActive'] = isLogActive;
    data['isEditable'] = isEditable;
    data['bonus'] = bonus;
    data['reportStatus'] = reportStatus;
    data['correctAnswer'] = correctAnswer;
    data['inCorrectAnswer'] = inCorrectAnswer;
    data['isPartial'] = isPartial;
    data['syncStatus'] = syncStatus;
    data['resultVerificationFlag'] = resultVerificationFlag;
    data['resultShowHode'] = resultShowHode;
    data['smsFlag'] = smsFlag;
    data['mockTestType'] = mockTestType;
    data['partialAnswer'] = partialAnswer;
    data['rankingSchemeType'] = rankingSchemeType;
    data['classPracticeTest'] = classPracticeTest;
    data['isOnPremTest'] = isOnPremTest;
    data['batchName'] = batchName;
    data['batchStatus'] = batchStatus;
    data['jee2021Flag'] = jee2021Flag;
    return data;
  }

  @override
  String toString() {
    return 'ViewSolution(id: $id, name: $name, durationInMinutes: $durationInMinutes, spentTimeInMinutes: $spentTimeInMinutes, questionMobileVos: $questionMobileVos, testType: $testType, examDate: $examDate, startTime: $startTime, endTime: $endTime, fixedTime: $fixedTime, numberOfQuestions: $numberOfQuestions, testStatus: $testStatus, orgId: $orgId, timeLeftForStartExam: $timeLeftForStartExam, isDeletable: $isDeletable, attemptedQuestions: $attemptedQuestions, score: $score, outOfScore: $outOfScore, strExamDate: $strExamDate, rank: $rank, isLogActive: $isLogActive, isEditable: $isEditable, bonus: $bonus, reportStatus: $reportStatus, correctAnswer: $correctAnswer, inCorrectAnswer: $inCorrectAnswer, isPartial: $isPartial, syncStatus: $syncStatus, resultVerificationFlag: $resultVerificationFlag, resultShowHode: $resultShowHode, smsFlag: $smsFlag, mockTestType: $mockTestType, partialAnswer: $partialAnswer, rankingSchemeType: $rankingSchemeType, classPracticeTest: $classPracticeTest, isOnPremTest: $isOnPremTest, batchName: $batchName, batchStatus: $batchStatus, jee2021Flag: $jee2021Flag)';
  }
}

class QuestionMobileVosResult {
  int? id;
  List<bool>? answerValidity;
  int? type;
  bool? solutionAvailable;
  int? durationInMinutes;
  int? status;
  String? userSelectedOption;
  int? questionTypeId;
  String? section;
  String? questionType;
  bool? isMultipleAnswer;
  double? positiveMark;
  double? negativeMark;
  int? groupId;
  int? answerStatus;
  String? numericAnswer;
  String? numericAnswerDifference;
  int? partialRule;
  List<String>? columnMatchAnswer;
  String? questionUrl;
  String? solutionUrl;

  QuestionMobileVosResult(
      {this.id,
      this.answerValidity,
      this.type,
      this.solutionAvailable,
      this.durationInMinutes,
      this.status,
      this.userSelectedOption,
      this.questionTypeId,
      this.section,
      this.questionType,
      this.isMultipleAnswer,
      this.positiveMark,
      this.negativeMark,
      this.groupId,
      this.answerStatus,
      this.numericAnswer,
      this.numericAnswerDifference,
      this.partialRule,
      this.columnMatchAnswer,
      this.questionUrl,
      this.solutionUrl});

  QuestionMobileVosResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answerValidity = json['answerValidity'].cast<bool>();
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
    numericAnswer = json['numericAnswer'];
    numericAnswerDifference = json['numericAnswerDifference'];
    partialRule = json['partialRule'];
    columnMatchAnswer = (json['columnMatchAnswer'] as List<dynamic>?)
        ?.map((e) => e == null ? "" : e as String)
        .toList();
    questionUrl = json['questionUrl'];
    solutionUrl = json['solutionUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['answerValidity'] = answerValidity;
    data['type'] = type;
    data['solutionAvailable'] = solutionAvailable;
    data['durationInMinutes'] = durationInMinutes;
    data['status'] = status;
    data['userSelectedOption'] = userSelectedOption;
    data['questionTypeId'] = questionTypeId;
    data['section'] = section;
    data['questionType'] = questionType;
    data['isMultipleAnswer'] = isMultipleAnswer;
    data['positiveMark'] = positiveMark;
    data['negativeMark'] = negativeMark;
    data['groupId'] = groupId;
    data['answerStatus'] = answerStatus;
    data['numericAnswerDifference'] = numericAnswerDifference;
    data['partialRule'] = partialRule;
    data['columnMatchAnswer'] = columnMatchAnswer;
    data['questionUrl'] = questionUrl;
    data['solutionUrl'] = solutionUrl;
    return data;
  }

  @override
  String toString() {
    return 'QuestionMobileVosResult(\n id: $id,\n answerValidity: $answerValidity,\n type: $type,\n solutionAvailable: $solutionAvailable,\n durationInMinutes: $durationInMinutes,\n status: $status, \n userSelectedOption: $userSelectedOption,\n questionTypeId: $questionTypeId,\n section: $section,\n questionType: $questionType,\n isMultipleAnswer: $isMultipleAnswer,\n positiveMark: $positiveMark,\n negativeMark: $negativeMark,\n groupId: $groupId,\n answerStatus: $answerStatus,\n numericAnswerDifference: $numericAnswerDifference,\n partialRule: $partialRule,\n columnMatchAnswer: $columnMatchAnswer,\n questionUrl: $questionUrl,\n solutionUrl: $solutionUrl)';
  }
}
