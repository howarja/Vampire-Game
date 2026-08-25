extends Button
class_name questionButton

var currentQuestion: question;

signal trigger;

func _ready() -> void:
	pressed.connect(onPressed);

func connectToConvseration(newQuestion: question, startAnswer: Callable):
	currentQuestion = newQuestion;
	text = currentQuestion.prompt;
	trigger.connect(startAnswer);

func onPressed():
	trigger.emit(currentQuestion.answer)
