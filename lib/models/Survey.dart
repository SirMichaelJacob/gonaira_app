// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class Survey {
  String? id;
  String? title;
  String? description;
  String? completed;
  String? numberOfQuestions;
  var reward;
  var amount;
  var population;
  String? respondents;

  Survey({
    this.id,
    this.title,
    this.description,
    this.completed,
    this.numberOfQuestions,
    this.reward,
    this.amount,
    this.population,
    this.respondents,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        completed: json['completed'],
        numberOfQuestions: json['numberOfQuestions'],
        population: json['population'],
        amount: json['amount'],
        reward: int.parse(json['amount']) / int.parse(json['population']));
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['completed'] = completed;
    map['numberOfQuestions'] = numberOfQuestions;
    map['reward'] = reward;
    map['amount'] = amount;
    map['population'] = population;
    return map;
  }
}
