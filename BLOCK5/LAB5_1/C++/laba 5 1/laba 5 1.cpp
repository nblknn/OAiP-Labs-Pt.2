#include <iostream>
#include <fstream>
#include <locale>
#include <Windows.h>
#include <string>
using namespace std;

const int MINNUM = -999999;
const int MAXNUM = 999999;
const int MAXELEMENTS = 30;

struct stack {
	int num;
	stack* next;
};

stack* createStack(bool& isCreated) {
	stack* head;
	head = new stack;
	head->next = nullptr;
	cout << "Стек успешно создан!\n";
	isCreated = true;
	return head;
}

void stackPush(stack*& head, int num) {
	stack* newElement;
	newElement = new stack;
	newElement->num = num;
	newElement->next = head;
	head = newElement;
	cout << "Элемент успешно добавлен в стек!\n";
}

int stackPop(stack*& head, bool isShowMessage, int& elementsAmount) {
	stack* deletedElement;
	int num;
	deletedElement = head;
	head = deletedElement->next;
	num = deletedElement->num;
	delete deletedElement;
	if (isShowMessage)
		cout << "Элемент успешно удалён из стека!\n";
	elementsAmount--;
	return num;
}

void destroyStack(stack*& head, bool& isCreated, int& elementsAmount, bool isShowMessage) {
	while (head != nullptr)
		stackPop(head, false, elementsAmount);
	delete head;
	isCreated = false;
	elementsAmount = 0;
	if (isShowMessage)
		cout << "Стек успешно уничтожен!\n";
}

bool isStackEmpty(stack* head) {
	if (head->next == nullptr) {
		cout << "На данный момент стек пуст.\n";
		return true;
	}
	else
		return false;
}

bool isStackFull(int elementsAmount) {
	if (elementsAmount == MAXELEMENTS) {
		cout << "Достигнуто максимальное количество элементов!\n";
		return true;
	}
	else
		return false;
}

int inputNum(string outputMessage, const int MIN, const int MAX) {
	int num;
	bool isIncorrect;
	do {
		isIncorrect = false;
		cout << outputMessage;
		cin >> num;
		if (cin.get() != '\n') {
			cin.clear();
			while (cin.get() != '\n');
			isIncorrect = true;
			cout << "Введенное значение должно быть целым числом! Повторите попытку.\n";
		}
		if (!isIncorrect && ((num < MIN) || (num > MAX))) {
			cout << "Диапазон числа не соответствует условию! Повторите попытку.\n";
			isIncorrect = true;
		}
	} while (isIncorrect);
	return num;
}

void addElementToStack(stack*& head, int& elementsAmount) {
	if (!isStackFull(elementsAmount)) {
		int num;
		num = inputNum("Введите значение для добавления в стек (-999999..999999): ", MINNUM, MAXNUM);
		stackPush(head, num);
		elementsAmount++;
	}
}

void outputStack(stack* head, int elementsAmount) {
	if (!isStackEmpty(head)) {
		stack* temp;
		temp = head;
		cout << "Элементы стека:\n";
		for (int i = elementsAmount; i > 0; i--) {
			cout << i << ". " << temp->num << "\n";
			temp = temp->next;
		}
	}
}

bool isFileExtIncorrect(string path, bool isIncorrect) {
	if (!isIncorrect && (path.substr(path.size() - 4) != ".txt")) {
		cout << "Введенный Вами файл не в формате *.txt! Повторите попытку.\n";
		isIncorrect = true;
	}
	return isIncorrect;
}

string getFileInputPath() {
	string path;
	bool isIncorrect;
	do {
		isIncorrect = false;
		cout << "Введите путь к файлу:\n";
		getline(cin, path, '\n');
		ifstream fin(path);
		fin.open(path);
		if (!fin.is_open()) {
			cout << "Файл недоступен для чтения! Повторите попытку.\n";
			isIncorrect = true;
		}
		isIncorrect = isFileExtIncorrect(path, isIncorrect);
		fin.close();
	} while (isIncorrect);
	return path;
}

void getNumFromFile(stack*& head, int& elementsAmount) {
	if (!isStackFull(elementsAmount)) {
		int num;
		bool isIncorrect;
		string path;
		path = getFileInputPath();
		do {
			isIncorrect = false;
			ifstream fin(path);
			try {
				fin >> num;
				isIncorrect = (num > MAXNUM) || (num < MINNUM) || !fin.eof();
			}
			catch (string errorMessage) {
				cout << "Данные выбранного файла некорректны! Повторите попытку.\n";
				isIncorrect = true;
			}
			fin.close();
			if (isIncorrect) {
				cout << "Данные выбранного файла некорректны! Повторите попытку.\n";
				path = getFileInputPath();
			}
		} while (isIncorrect);
		cout << "Данные из файла успешно считаны.\n";
		stackPush(head, num);
		elementsAmount++;
	}
}

string getFileOutputPath() {
	string path;
	bool isIncorrect;
	do {
		isIncorrect = false;
		cout << "Введите путь к файлу, в который нужно записать результат:\n";
		getline(cin, path, '\n');
		isIncorrect = isFileExtIncorrect(path, isIncorrect);
		if (!isIncorrect) {
			ofstream fout(path);
			fout.open(path);
			if (!fout.is_open()) {
				cout << "Файл недоступен для записи! Повторите попытку.\n";
				isIncorrect = true;
			}
			fout.close();
		}
	} while (isIncorrect);
	return path;
}

void writeStackIntoFile(int elementsAmount, stack* head) {
	if (!isStackEmpty(head)) {
		bool isIncorrect;
		string path;
		stack* temp;
		path = getFileOutputPath();
		do {
			isIncorrect = false;
			ofstream fout(path);
			try {
				temp = head;
				fout << "Стек:\n\n";
				for (int i = elementsAmount; i > 0; i--) {
					fout << temp->num << "\n--------\n";
					temp = temp->next;
				}
			}
			catch (string errorMessage) {
				cout << "Произошла ошибка. Повторите попытку.\n";
				isIncorrect = true;
			}
			fout.close();
			if (isIncorrect)
				path = getFileOutputPath();
		} while (isIncorrect);
		cout << "Результат записан.\n";
	}
}

void outputInstruction() {
	cout << "Инструкция\n\n" << "ИЗМЕНЕНИЕ СТЕКА:\n1. Можно удалить только последний добавленный в стек элемент.\n2. Элементы стека - целые числа в диапазоне -999999..999999.\n3. Максимальное количество элементов в стеке - 30.\n\n"
		 << "ФАЙЛЫ:\n1. Открываемый / сохраняемый файл должен быть формата * .txt.\n2. В открываемом файле должно быть записано только 1 число, которое добавится в стек.\n3. При сохранении данные указанного файла перезаписываются.\n\n"
		 << "Разработчик: Городко Ксения\nЛабораторная №5.1\n";
}

void outputProgramInfo() {
	cout << "Добро пожаловать в программу для работы со стеком!\n";
}

void outputMenu() {
	cout << "Меню:\n";
	cout << "1) Создать пустой стек;\n" << "2) Добавить элемент;\n" << "3) Удалить элемент;\n"
		 << "4) Вывести элементы стека;\n" << "5) Уничтожить стек;\n" << "6) Открыть файл;\n"
		 << "7) Сохранить файл;\n" << "8) Вывести инструкцию;\n" << "9) Выход из программы.\n";
	cout << "Для выбора пункта меню введите его номер.\n";
}

void returnToMenu() {
	cout << "\nНажмите Enter для возвращения в меню...\n";
	getchar();
}

void performMenuOption() {
	const int CREATE = 1;
	const int PUSH = 2;
	const int POP = 3;
	const int SHOW = 4;
	const int DESTROY = 5;
	const int OPENFILE = 6;
	const int SAVEFILE = 7;
	const int SHOWINSTRUCTION = 8;
	const int EXIT = 9;
	int choice;
	int elementsAmount;
	bool isCreated;
	stack* head;
	choice = 0;
	elementsAmount = 0;
	isCreated = false;
	head = nullptr;
	while (choice != EXIT) {
		outputMenu();
		choice = inputNum("", CREATE, EXIT);
		cout << "\n";
		if ((choice == CREATE) || (choice > SAVEFILE) || isCreated) {
			switch (choice) {
			case CREATE: {
				if (isCreated)
					destroyStack(head, isCreated, elementsAmount, false);
				head = createStack(isCreated);
				break;
			}
			case PUSH: {
				addElementToStack(head, elementsAmount);
				break;
			}
			case POP: {
				if (!isStackEmpty(head))
					stackPop(head, true, elementsAmount);
				break;
			}
			case SHOW: {
				outputStack(head, elementsAmount);
				break;
			}
			case DESTROY: {
				destroyStack(head, isCreated, elementsAmount, true);
				break;
			}
			case OPENFILE: {
				getNumFromFile(head, elementsAmount);
				break;
			}
			case SAVEFILE: {
				writeStackIntoFile(elementsAmount, head);
				break;
			}
			case SHOWINSTRUCTION: {
				outputInstruction();
				break;
			}
			}
		}
		else
			cout << "На данный момент стека не существует.\n";
		if (choice != EXIT)
			returnToMenu();
	}
	if (isCreated)
		destroyStack(head, isCreated, elementsAmount, false);
	cout << "Ждем Вашего возвращения...";
}

int main() {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	outputProgramInfo();
	performMenuOption();
	return 0;
}