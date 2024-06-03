// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jeeni/enums/answer_status.dart';

class TestResponse {}

class TestDownloadResponse extends TestResponse {
  int? id;
  String? name;
  String? password;
  int? durationInMinutes;
  int? spentTimeInMinutes;
  List<QuestionMobileVos>? questionMobileVos;
  int? testType;
  int? examDate;
  int? startTime;
  int? endTime;
  bool? fixedTime;
  int? numberOfQuestions;
  int? testStatus;
  int? orgId;
  int? timeLeftForStartExam;
  List<String>? wifiNames;
  bool? isDeletable;
  int? score;
  String? wifiPassword;
  String? wifiName;
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
  OrganisationVo? organisationVo;
  int? batchStatus;
  bool? jee2021Flag;

  TestDownloadResponse(
      {this.id,
      this.name,
      this.password,
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
      this.wifiNames,
      this.isDeletable,
      this.score,
      this.wifiPassword,
      this.wifiName,
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
      this.organisationVo,
      this.batchStatus,
      this.jee2021Flag});

  TestDownloadResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
    durationInMinutes = json['durationInMinutes'];
    spentTimeInMinutes = json['spentTimeInMinutes'];
    print("000000000000000000000000000000000000");

    if (json['questionMobileVos'] != null) {
      questionMobileVos = <QuestionMobileVos>[];
      json['questionMobileVos'].forEach((v) {
        questionMobileVos!.add(QuestionMobileVos.fromJson(v));
      });
    }
    print("1111111111111111111111111111111111111EEEEEEEEEEEEE");
    testType = json['testType'];
    examDate = json['examDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    fixedTime = json['fixedTime'];
    // numberOfQuestions = json['numberOfQuestions'];
    // testStatus = json['testStatus'];
    // orgId = json['orgId'];
    // timeLeftForStartExam = json['timeLeftForStartExam'];
    // wifiNames = json['wifiNames'].cast<String>();
    // isDeletable = json['isDeletable'];
    // score = json['score'];
    // wifiPassword = json['wifiPassword'];
    // wifiName = json['wifiName'];
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
    // print("2222222222222222222222222222222222222");

    // organisationVo = json['organisationVo'] != null
    //     ? new OrganisationVo.fromJson(json['organisationVo'])
    //     : null;
    // print("3333333333333333333333333333333333333");

    // batchStatus = json['batchStatus'];
    // jee2021Flag = json['jee2021Flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['durationInMinutes'] = this.durationInMinutes;
    data['spentTimeInMinutes'] = this.spentTimeInMinutes;
    if (this.questionMobileVos != null) {
      data['questionMobileVos'] =
          this.questionMobileVos!.map((v) => v.toJson()).toList();
    }
    data['testType'] = this.testType;
    data['examDate'] = this.examDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['fixedTime'] = this.fixedTime;
    data['numberOfQuestions'] = this.numberOfQuestions;
    data['testStatus'] = this.testStatus;
    data['orgId'] = this.orgId;
    data['timeLeftForStartExam'] = this.timeLeftForStartExam;
    data['wifiNames'] = this.wifiNames;
    data['isDeletable'] = this.isDeletable;
    data['score'] = this.score;
    data['wifiPassword'] = this.wifiPassword;
    data['wifiName'] = this.wifiName;
    data['isLogActive'] = this.isLogActive;
    data['isEditable'] = this.isEditable;
    data['bonus'] = this.bonus;
    data['reportStatus'] = this.reportStatus;
    data['correctAnswer'] = this.correctAnswer;
    data['inCorrectAnswer'] = this.inCorrectAnswer;
    data['isPartial'] = this.isPartial;
    data['syncStatus'] = this.syncStatus;
    data['resultVerificationFlag'] = this.resultVerificationFlag;
    data['resultShowHode'] = this.resultShowHode;
    data['smsFlag'] = this.smsFlag;
    data['mockTestType'] = this.mockTestType;
    data['partialAnswer'] = this.partialAnswer;
    data['rankingSchemeType'] = this.rankingSchemeType;
    data['classPracticeTest'] = this.classPracticeTest;
    data['isOnPremTest'] = this.isOnPremTest;
    if (this.organisationVo != null) {
      data['organisationVo'] = this.organisationVo!.toJson();
    }
    data['batchStatus'] = this.batchStatus;
    data['jee2021Flag'] = this.jee2021Flag;
    return data;
  }
}

class QuestionMobileVos {
  int? id;
  List<bool>? answerValidity;
  int? type;
  bool? solutionAvailable;
  int? durationInMinutes;
  int? status;
  int? questionTypeId;
  String? section;
  String? questionType;
  bool? isMultipleAnswer;
  double? positiveMark;
  double? negativeMark;
  int? groupId;
  int? answerStatus;
  String? numericAnswerDifference;
  int? partialRule;
  List<String>? columnMatchAnswer;
  String? questionUrl;
  String? solutionUrl;
  String? numericAnswer;
  AnswerStatus customAnswerStatus = AnswerStatus.NOT_VISITED;
  String? userSelectedOption;

  QuestionMobileVos({
    this.id,
    this.answerValidity,
    this.type,
    this.solutionAvailable,
    this.durationInMinutes,
    this.status,
    this.questionTypeId,
    this.section,
    this.questionType,
    this.isMultipleAnswer,
    this.positiveMark,
    this.negativeMark,
    this.groupId,
    this.answerStatus,
    this.numericAnswerDifference,
    this.partialRule,
    this.columnMatchAnswer,
    this.questionUrl,
    this.solutionUrl,
    this.numericAnswer,
    this.customAnswerStatus = AnswerStatus.NOT_VISITED,
    this.userSelectedOption,
  });

  QuestionMobileVos.fromJson(Map<String, dynamic> json) {
    print("sssssssssssssssssssssssssssssssssssssss");
    id = json['id'];
    answerValidity = json['answerValidity'].cast<bool>();
    type = json['type'];
    print("1111111111111111111111");

    solutionAvailable = json['solutionAvailable'];
    print("2222222222222222222222");

    durationInMinutes = json['durationInMinutes'];
    print("333333333333333333333");

    status = json['status'];
    print("444444444444444444444444");

    questionTypeId = json['questionTypeId'];
    print("55555555555555555555555");

    section = json['section'];
    print("66666666666666666666666");

    questionType = json['questionType'];
    print("7777777777777777777777");

    isMultipleAnswer = json['isMultipleAnswer'];
    print("888888888888888888888888");

    positiveMark = json['positiveMark'];
    print("999999999999999999999999");

    negativeMark = json['negativeMark'];
    print("111111111111111111111");
    groupId = json['groupId'];
    print("222222222222222222222222");
    answerStatus = json['answerStatus'];
    print("333333333333333333333333");
    numericAnswerDifference = json['numericAnswerDifference'];
    print("4444444444444444444444444");
    partialRule = json['partialRule'];
    print("5555555555555555555555555511111111111111");

    // columnMatchAnswer = json['columnMatchAnswer'].cast<String>();
    print("6666666666666666666666661111111111111 ${json['columnMatchAnswer']}");

    questionUrl = json['questionUrl'];
    solutionUrl = json['solutionUrl'];
    numericAnswer = json['numericAnswer'];
    print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answerValidity'] = this.answerValidity;
    data['type'] = this.type;
    data['solutionAvailable'] = this.solutionAvailable;
    data['durationInMinutes'] = this.durationInMinutes;
    data['status'] = this.status;
    data['questionTypeId'] = this.questionTypeId;
    data['section'] = this.section;
    data['questionType'] = this.questionType;
    data['isMultipleAnswer'] = this.isMultipleAnswer;
    data['positiveMark'] = this.positiveMark;
    data['negativeMark'] = this.negativeMark;
    data['groupId'] = this.groupId;
    data['answerStatus'] = this.answerStatus;
    data['numericAnswerDifference'] = this.numericAnswerDifference;
    data['partialRule'] = this.partialRule;
    data['columnMatchAnswer'] = this.columnMatchAnswer;
    data['questionUrl'] = this.questionUrl;
    data['solutionUrl'] = this.solutionUrl;
    data['numericAnswer'] = this.numericAnswer;
    return data;
  }

  void update(String? userSelectedOption) {
    this.userSelectedOption = userSelectedOption;
  }

  QuestionMobileVos copyWith({
    int? id,
    List<bool>? answerValidity,
    int? type,
    bool? solutionAvailable,
    int? durationInMinutes,
    int? status,
    int? questionTypeId,
    String? section,
    String? questionType,
    bool? isMultipleAnswer,
    double? positiveMark,
    double? negativeMark,
    int? groupId,
    int? answerStatus,
    String? numericAnswerDifference,
    int? partialRule,
    List<String>? columnMatchAnswer,
    String? questionUrl,
    String? solutionUrl,
    String? numericAnswer,
    AnswerStatus? customAnswerStatus,
    String? userSelectedOption,
  }) {
    return QuestionMobileVos(
      id: id ?? this.id,
      answerValidity: answerValidity ?? this.answerValidity,
      type: type ?? this.type,
      solutionAvailable: solutionAvailable ?? this.solutionAvailable,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      status: status ?? this.status,
      questionTypeId: questionTypeId ?? this.questionTypeId,
      section: section ?? this.section,
      questionType: questionType ?? this.questionType,
      isMultipleAnswer: isMultipleAnswer ?? this.isMultipleAnswer,
      positiveMark: positiveMark ?? this.positiveMark,
      negativeMark: negativeMark ?? this.negativeMark,
      groupId: groupId ?? this.groupId,
      answerStatus: answerStatus ?? this.answerStatus,
      numericAnswerDifference:
          numericAnswerDifference ?? this.numericAnswerDifference,
      partialRule: partialRule ?? this.partialRule,
      columnMatchAnswer: columnMatchAnswer ?? this.columnMatchAnswer,
      questionUrl: questionUrl ?? this.questionUrl,
      solutionUrl: solutionUrl ?? this.solutionUrl,
      numericAnswer: numericAnswer ?? this.numericAnswer,
      customAnswerStatus: customAnswerStatus ?? this.customAnswerStatus,
      userSelectedOption: userSelectedOption ?? this.userSelectedOption,
    );
  }
}

class OrganisationVo {
  int? id;
  String? name;
  bool? active;
  int? adminId;
  List<Batches>? batches;
  bool? partialResult;
  int? apkVersion;
  bool? resultVerificationFlag;
  bool? isTestQuestionsDownload;
  int? isOnPrem;
  int? noOfDevice;
  bool? isEnrollStudentRollnoWise;
  int? productId;

  OrganisationVo(
      {this.id,
      this.name,
      this.active,
      this.adminId,
      this.batches,
      this.partialResult,
      this.apkVersion,
      this.resultVerificationFlag,
      this.isTestQuestionsDownload,
      this.isOnPrem,
      this.noOfDevice,
      this.isEnrollStudentRollnoWise,
      this.productId});

  OrganisationVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    adminId = json['adminId'];
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(new Batches.fromJson(v));
      });
    }
    partialResult = json['partialResult'];
    apkVersion = json['apkVersion'];
    resultVerificationFlag = json['resultVerificationFlag'];
    isTestQuestionsDownload = json['isTestQuestionsDownload'];
    isOnPrem = json['isOnPrem'];
    noOfDevice = json['noOfDevice'];
    isEnrollStudentRollnoWise = json['isEnrollStudentRollnoWise'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['adminId'] = this.adminId;
    if (this.batches != null) {
      data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    }
    data['partialResult'] = this.partialResult;
    data['apkVersion'] = this.apkVersion;
    data['resultVerificationFlag'] = this.resultVerificationFlag;
    data['isTestQuestionsDownload'] = this.isTestQuestionsDownload;
    data['isOnPrem'] = this.isOnPrem;
    data['noOfDevice'] = this.noOfDevice;
    data['isEnrollStudentRollnoWise'] = this.isEnrollStudentRollnoWise;
    data['productId'] = this.productId;
    return data;
  }
}

class Batches {
  int? id;
  String? name;
  int? startDate;
  int? endDate;
  bool? active;
  int? orgId;
  int? courseId;
  int? amount;
  bool? subscribable;
  bool? deleted;
  int? syncStatus;
  int? totalStudents;
  bool? isEnrollStudentRollnoWise;

  Batches(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.active,
      this.orgId,
      this.courseId,
      this.amount,
      this.subscribable,
      this.deleted,
      this.syncStatus,
      this.totalStudents,
      this.isEnrollStudentRollnoWise});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    active = json['active'];
    orgId = json['orgId'];
    courseId = json['courseId'];
    amount = json['amount'];
    subscribable = json['subscribable'];
    deleted = json['deleted'];
    syncStatus = json['syncStatus'];
    totalStudents = json['totalStudents'];
    isEnrollStudentRollnoWise = json['isEnrollStudentRollnoWise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['active'] = this.active;
    data['orgId'] = this.orgId;
    data['courseId'] = this.courseId;
    data['amount'] = this.amount;
    data['subscribable'] = this.subscribable;
    data['deleted'] = this.deleted;
    data['syncStatus'] = this.syncStatus;
    data['totalStudents'] = this.totalStudents;
    data['isEnrollStudentRollnoWise'] = this.isEnrollStudentRollnoWise;
    return data;
  }
}
