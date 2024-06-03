class ResultDetailsModelClass {
  ResultDetailsModelClass({
    required this.testWise,
    required this.batchWise,
  });
  late final List<TestWise> testWise;
  late final List<BatchWise> batchWise;
  
  ResultDetailsModelClass.fromJson(Map<String, dynamic> json){
    testWise = List.from(json['testWise']).map((e)=>TestWise.fromJson(e)).toList();
    batchWise = List.from(json['batchWise']).map((e)=>BatchWise.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['testWise'] = testWise.map((e)=>e.toJson()).toList();
    _data['batchWise'] = batchWise.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class TestWise {
  TestWise({
    required this.studentName,
    required this.mobileNumber,
    required this.parentNumber,
    required this.attemptedQuestions,
    required this.score,
    required this.outOfScore,
    required this.rank,
    required this.correct,
    required this.inCorrect,
    required this.studenId,
    required this.subjectName,
    required this.chapterName,
    required this.complexity,
    required this.totalQuestions,
    required this.bonus,
    required this.testId,
    required this.batchId,
    required this.isPresent,
    required this.category,
    required this.questionId,
    required this.questionTag,
    required this.percentage,
    required this.questionSummary,
    required this.partialCorrect,
    required this.percentile,
    required this.loginId,
    required this.rollNumber,
    required this.categoryRank,
    required this.subjectListWithMarks,
    required this.correctMCQ,
    required this.correctNumeric,
  });
  late final String studentName;
  late final String mobileNumber;
  late final String parentNumber;
  late final String attemptedQuestions;
  late final int score;
  late final int outOfScore;
  late final String rank;
  late final String correct;
  late final String inCorrect;
  late final int studenId;
  late final String subjectName;
  late final String chapterName;
  late final String complexity;
  late final String totalQuestions;
  late final String bonus;
  late final String testId;
  late final String batchId;
  late final bool isPresent;
  late final String category;
  late final String questionId;
  late final String questionTag;
  late final String percentage;
  late final String questionSummary;
  late final String partialCorrect;
  late final String percentile;
  late final String loginId;
  late final String rollNumber;
  late final String categoryRank;
  late final String subjectListWithMarks;
  late final String correctMCQ;
  late final String correctNumeric;
  
  TestWise.fromJson(Map<String, dynamic> json){
    studentName = json['studentName'];
    mobileNumber = json['mobileNumber'];
    parentNumber = json['parentNumber'];
    attemptedQuestions = json['attemptedQuestions'];
    score = json['score'];
    outOfScore = json['outOfScore'];
    rank = json['rank'];
    correct = json['correct'];
    inCorrect = json['inCorrect'];
    studenId = json['studenId'];
    subjectName = json['subjectName'];
    chapterName = json['chapterName'];
    complexity = json['complexity'];
    totalQuestions = json['totalQuestions'];
    bonus = json['bonus'];
    testId = json['testId'];
    batchId = json['batchId'];
    isPresent = json['isPresent'];
    category = json['category'];
    questionId = json['questionId'];
    questionTag = json['questionTag'];
    percentage = json['percentage'];
    questionSummary = json['questionSummary'];
    partialCorrect = json['partialCorrect'];
    percentile = json['percentile'];
    loginId = json['login_id'];
    rollNumber = json['rollNumber'];
    categoryRank = json['categoryRank'];
    subjectListWithMarks = json['subjectListWithMarks'];
    correctMCQ = json['correctMCQ'];
    correctNumeric = json['correctNumeric'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['studentName'] = studentName;
    _data['mobileNumber'] = mobileNumber;
    _data['parentNumber'] = parentNumber;
    _data['attemptedQuestions'] = attemptedQuestions;
    _data['score'] = score;
    _data['outOfScore'] = outOfScore;
    _data['rank'] = rank;
    _data['correct'] = correct;
    _data['inCorrect'] = inCorrect;
    _data['studenId'] = studenId;
    _data['subjectName'] = subjectName;
    _data['chapterName'] = chapterName;
    _data['complexity'] = complexity;
    _data['totalQuestions'] = totalQuestions;
    _data['bonus'] = bonus;
    _data['testId'] = testId;
    _data['batchId'] = batchId;
    _data['isPresent'] = isPresent;
    _data['category'] = category;
    _data['questionId'] = questionId;
    _data['questionTag'] = questionTag;
    _data['percentage'] = percentage;
    _data['questionSummary'] = questionSummary;
    _data['partialCorrect'] = partialCorrect;
    _data['percentile'] = percentile;
    _data['login_id'] = loginId;
    _data['rollNumber'] = rollNumber;
    _data['categoryRank'] = categoryRank;
    _data['subjectListWithMarks'] = subjectListWithMarks;
    _data['correctMCQ'] = correctMCQ;
    _data['correctNumeric'] = correctNumeric;
    return _data;
  }
}

class BatchWise {
  BatchWise({
    required this.studentName,
    required this.mobileNumber,
    required this.parentNumber,
    required this.attemptedQuestions,
    required this.score,
    required this.outOfScore,
    required this.rank,
    required this.correct,
    required this.inCorrect,
    required this.studenId,
    required this.subjectName,
    required this.chapterName,
    required this.complexity,
    required this.totalQuestions,
    required this.bonus,
    required this.testId,
    required this.batchId,
    required this.isPresent,
    required this.category,
    required this.questionId,
    required this.questionTag,
    required this.percentage,
    required this.questionSummary,
    required this.partialCorrect,
    required this.percentile,
    required this.loginId,
    required this.rollNumber,
    required this.categoryRank,
    required this.subjectListWithMarks,
    required this.correctMCQ,
    required this.correctNumeric,
  });
  late final String studentName;
  late final String mobileNumber;
  late final String parentNumber;
  late final String attemptedQuestions;
  late final int score;
  late final int outOfScore;
  late final int rank;
  late final String correct;
  late final String inCorrect;
  late final int studenId;
  late final String subjectName;
  late final String chapterName;
  late final String complexity;
  late final String totalQuestions;
  late final String bonus;
  late final String testId;
  late final String batchId;
  late final bool isPresent;
  late final String category;
  late final String questionId;
  late final String questionTag;
  late final String percentage;
  late final String questionSummary;
  late final String partialCorrect;
  late final String percentile;
  late final String loginId;
  late final String rollNumber;
  late final String categoryRank;
  late final String subjectListWithMarks;
  late final String correctMCQ;
  late final String correctNumeric;
  
  BatchWise.fromJson(Map<String, dynamic> json){
    studentName = json['studentName'];
    mobileNumber = json['mobileNumber'];
    parentNumber = json['parentNumber'];
    attemptedQuestions = json['attemptedQuestions'];
    score = json['score'];
    outOfScore = json['outOfScore'];
    rank = json['rank'];
    correct = json['correct'];
    inCorrect = json['inCorrect'];
    studenId = json['studenId'];
    subjectName = json['subjectName'];
    chapterName = json['chapterName'];
    complexity = json['complexity'];
    totalQuestions = json['totalQuestions'];
    bonus = json['bonus'];
    testId = json['testId'];
    batchId = json['batchId'];
    isPresent = json['isPresent'];
    category = json['category'];
    questionId = json['questionId'];
    questionTag = json['questionTag'];
    percentage = json['percentage'];
    questionSummary = json['questionSummary'];
    partialCorrect = json['partialCorrect'];
    percentile = json['percentile'];
    loginId = json['login_id'];
    rollNumber = json['rollNumber'];
    categoryRank = json['categoryRank'];
    subjectListWithMarks = json['subjectListWithMarks'];
    correctMCQ = json['correctMCQ'];
    correctNumeric = json['correctNumeric'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['studentName'] = studentName;
    _data['mobileNumber'] = mobileNumber;
    _data['parentNumber'] = parentNumber;
    _data['attemptedQuestions'] = attemptedQuestions;
    _data['score'] = score;
    _data['outOfScore'] = outOfScore;
    _data['rank'] = rank;
    _data['correct'] = correct;
    _data['inCorrect'] = inCorrect;
    _data['studenId'] = studenId;
    _data['subjectName'] = subjectName;
    _data['chapterName'] = chapterName;
    _data['complexity'] = complexity;
    _data['totalQuestions'] = totalQuestions;
    _data['bonus'] = bonus;
    _data['testId'] = testId;
    _data['batchId'] = batchId;
    _data['isPresent'] = isPresent;
    _data['category'] = category;
    _data['questionId'] = questionId;
    _data['questionTag'] = questionTag;
    _data['percentage'] = percentage;
    _data['questionSummary'] = questionSummary;
    _data['partialCorrect'] = partialCorrect;
    _data['percentile'] = percentile;
    _data['login_id'] = loginId;
    _data['rollNumber'] = rollNumber;
    _data['categoryRank'] = categoryRank;
    _data['subjectListWithMarks'] = subjectListWithMarks;
    _data['correctMCQ'] = correctMCQ;
    _data['correctNumeric'] = correctNumeric;
    return _data;
  }
}