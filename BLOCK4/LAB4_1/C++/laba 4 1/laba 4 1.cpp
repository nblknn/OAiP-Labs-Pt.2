#include <iostream>
#include <fstream>
#include <locale>
#include <Windows.h>
#include <string>
using namespace std;

const int MINYEAR = 1900;
const int MAXYEAR = 2024;
const int MINPRICE = 0;
const int MAXPRICE = 999999999;
const int MAXLENGTH = 20;
const int LASTYEAR = 2023;
const int MAXRECORDS = 30;

struct car {
	string model;
	string country;
	int year;
	int price;
};

string inputString(string outputMessage) {
	string str;
	bool isIncorrect;
	do {
		isIncorrect = false;
		cout << outputMessage;
		getline(cin, str, '\n');
		if (str.size() > MAXLENGTH) {
			isIncorrect = true;
			cout << "Длина не должна превышать 20 символов!\n";
		}
	} while (isIncorrect);
	return str;
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

car inputRecord() {
	car newCar;
	newCar.model = inputString("Введите марку автомобиля (до 20 символов): ");
	newCar.country = inputString("Введите государство-производителя (до 20 символов): ");
	newCar.year = inputNum("Введите год выпуска (целое число от 1900 до 2024): ", MINYEAR, MAXYEAR);
	newCar.price = inputNum("Введите цену (целое число от 0 до 999999999): ", MINPRICE, MAXPRICE);
	return newCar;
}

bool isListEmpty(int listLength) {
	if (listLength == 0) {
		cout << "В данный момент список пуст.\n";
		return true;
	}
	else
		return false;
}

car* addRecordToList(car* list, int& listLength, bool& isSaved) {
	car newCar;
	car* newList;
	if (listLength < MAXRECORDS) {
		newCar = inputRecord();
		newList = new car[listLength + 1];
		for (int i = 0; i < listLength; i++)
			newList[i] = list[i];
		newList[listLength] = newCar;
		cout << "Автомобиль успешно добавлен в список!\n";
		listLength++;
		isSaved = false;
	}
	else {
		cout << "Достигнуто максимальное количество записей!\n";
		newList = list;
	}
	return newList;
}

void outputList(car* list, int listLength) {
	if (!isListEmpty(listLength)) {
		cout << "№ || Марка || Государство || Год || Цена\n";
		for (int i = 0; i < listLength; i++) {
			cout << i + 1 << ". " << list[i].model << " " << list[i].country << " " << list[i].year << " " << list[i].price << "\n";
		}
	}
}

car* editRecord(car* list, int listLength, bool& isSaved) {
	int selectedIndex;
	selectedIndex = 0;
	outputList(list, listLength);
	if (listLength != 0) {
		selectedIndex = inputNum("Введите номер записи, которую хотите изменить, или 0 для выхода в меню: ", 0, listLength) - 1;
		if (selectedIndex != -1) {
			list[selectedIndex] = inputRecord();
			cout << "Запись успешно изменена!\n";
			isSaved = false;
		}
	}
	return list;
}

car* deleteRecord(car* list, int& listLength, bool& isSaved) {
	int deleteIndex;
	car* newList;
	deleteIndex = 0;
	outputList(list, listLength);
	if (listLength != 0) {
		deleteIndex = inputNum("Введите номер записи, которую хотите удалить, или 0 для выхода в меню: ", 0, listLength) - 1;
		if (deleteIndex != -1) {
			for (int i = deleteIndex; i < listLength - 1; i++)
				list[i] = list[i + 1];
			newList = new car[listLength - 1];
			for (int i = 0; i < listLength - 1; i++)
				newList[i] = list[i];
			cout << "Запись успешно удалена!\n";
			listLength--;
			isSaved = false;
		}
		else
			newList = list;
	}
	else
		newList = list;
	return newList;
}

bool isFileExtIncorrect(string path, bool isIncorrect) {
	if (!isIncorrect && (path.substr(path.size() - 8) != ".carlist")) {
		cout << "Введенный Вами файл не является формата *.carlist! Повторите попытку.\n";
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

car* getListFromFile(int& listLength, bool& isSaved) {
	bool isIncorrect;
	string path;
	car* list;
	path = getFileInputPath();
	list = new car();
	do {
		isIncorrect = false;
		ifstream fin(path);
		try {
			fin >> listLength;
			isIncorrect = listLength > MAXRECORDS;
			list = new car[listLength];
			int i = 0;
			while ((!isIncorrect) && (i < (listLength))) {
				getline(fin, list[i].model, '\n');
				getline(fin, list[i].country, '\n');
				fin >> list[i].year;
				fin >> list[i].price;
				isIncorrect = (list[i].model.size() > MAXLENGTH) || (list[i].country.size() > MAXLENGTH)
					|| (list[i].year > MAXYEAR) || (list[i].year < MINYEAR)
					|| (list[i].price > MAXPRICE) || (list[i].price < MINPRICE);
				i++;
			}
			if (!isIncorrect && !fin.eof())
				isIncorrect = true;
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
	isSaved = true;
	return list;
}

string getFileOutputPath() {
	string path;
	bool isIncorrect;
	do {
		isIncorrect = false;
		cout << "Введите путь к файлу, в который нужно записать результат:\n";
		getline(cin, path, '\n');
		ofstream fout(path);
		fout.open(path);
		if (!fout.is_open()) {
			cout << "Файл недоступен для записи! Повторите попытку.\n";
			isIncorrect = true;
		}
		isIncorrect = isFileExtIncorrect(path, isIncorrect);
		fout.close();
	} while (isIncorrect);
	return path;
}

void writeListIntoFile(car* list, int listLength, bool& isSaved) {
	if (!isListEmpty(listLength)) {
		bool isIncorrect;
		string path;
		path = getFileOutputPath();
		do {
			isIncorrect = false;
			ofstream fout(path);
			try {
				fout << listLength << " ";
				for (int i = 0; i < listLength; i++) {
					fout << list[i].model << "\n" << list[i].country << "\n" << list[i].year << "\n" << list[i].price;
					if (i < listLength - 1)
						fout << " ";
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
		isSaved = true;
	}
}

void saveFileOnExit(car* list, int listLength, string outputMessage, bool& isSaved) {
	const int NOTSAVETOFILE = 0;
	const int SAVETOFILE = 1;
	int choice;
	choice = inputNum(outputMessage, NOTSAVETOFILE, SAVETOFILE);
	if (choice == SAVETOFILE)
		writeListIntoFile(list, listLength, isSaved);
}

bool isLastYearInList(car* list, int listLength) {
	int i;
	bool isLastYear;
	i = 0;
	isLastYear = false;
	while ((i < listLength) && !isLastYear) {
		if (list[i].year == LASTYEAR)
			isLastYear = true;
		i++;
	}
	return isLastYear;
}

int findTaskListLength(car* mainList, int mainListLength) {
	int length;
	length = 0;
	for (int i = 0; i < mainListLength; i++)
		if (mainList[i].year == LASTYEAR)
			length++;
	return length;
}

car* createTaskList(car* mainList, int mainListLength, int taskListLength) {
	car* taskList;
	int j;
	taskList = new car[taskListLength];
	j = 0;
	for (int i = 0; i < mainListLength; i++)
		if (mainList[i].year == LASTYEAR) {
			taskList[j] = mainList[i];
			j++;
		}
	return taskList;
}

car* sortList(car* list, int listLength) {
	int maxIndex;
	for (int i = 0; i < listLength - 1; i++) {
		maxIndex = i;
		for (int j = i + 1; j < listLength; j++)
			if (list[j].price > list[maxIndex].price)
				maxIndex = j;
		if (maxIndex != i)
			swap(list[maxIndex], list[i]);
	}
	return list;
}

void performTask(car* mainList, int mainListLength, bool isSaved) {
	cout << "Вывести информацию об автомобилях выпуска прошлого года в порядке убывания цен.\n";
	if (isLastYearInList(mainList, mainListLength)) {
		int taskListLength;
		car* taskList;
		car* sortedTaskList;
		taskListLength = findTaskListLength(mainList, mainListLength);
		taskList = createTaskList(mainList, mainListLength, taskListLength);
		sortedTaskList = sortList(taskList, taskListLength);
		outputList(sortedTaskList, taskListLength);
		saveFileOnExit(sortedTaskList, taskListLength,
			"\nЖелаете сохранить список из задания в файл? Введите 1, если да, и 0, если нет: ", isSaved);
	}
	else
		cout << "В списке нет автомобилей, выпущенных в прошлом году.\n";
}

void outputInstruction() {
	cout << "Инструкция\n\nДАННЫЕ:\n1. Максимальная длина данных о марке и государстве-производителе - 20 символов.\n" << "2. Год выпуска и цена - целые числа.\n"
		<< "3. Диапазон года выпуска: 1900..2024.\n" << "4. Диапазон цены: 0..999999999.\n" << "5. Максимальное количество записей - 30.\n\n"
		<< "ФАЙЛЫ:\n1. Открываемый / сохраняемый файл должен быть формата * .carlist.\n" << "2. При сохранении данные указанного файла перезаписываются.\n\n"
		<< "Разработчик: Городко Ксения\nЛабораторная №4.1\n";
}

void outputProgramInfo() {
	cout << "Добро пожаловать в Гараж - программу для создания и редактирования списков со сведениями об автомобилях!\n";
}

void outputMenu() {
	cout << "Меню:\n";
	cout << "1) Добавить новую запись;\n" << "2) Изменить уже имеющуюся запись;\n" << "3) Удалить запись;\n"
		<< "4) Вывести текущий список записей;\n" << "5) Вывести информацию по заданию;\n" << "6) Открыть файл;\n"
		<< "7) Сохранить записи в файл;\n" << "8) Вывести инструкцию;\n" << "9) Выход из программы.\n";
	cout << "Для выбора пункта меню введите его номер.\n";
}

void returnToMenu() {
	cout << "\nНажмите Enter для возвращения в меню...\n";
	getchar();
}

void performMenuOption() {
	const int ADDRECORD = 1;
	const int EDITRECORD = 2;
	const int DELETERECORD = 3;
	const int SHOWLIST = 4;
	const int SHOWTASK = 5;
	const int OPENFILE = 6;
	const int SAVEFILE = 7;
	const int SHOWINSTRUCTION = 8;
	const int EXIT = 9;
	int choice;
	bool isSaved;
	int listLength;
	car* mainList;
	choice = 0;
	isSaved = true;
	listLength = 0;
	mainList = new car();
	while (choice != EXIT) {
		outputMenu();
		choice = inputNum("", ADDRECORD, EXIT);
		cout << "\n";
		switch (choice) {
			case ADDRECORD: {
				mainList = addRecordToList(mainList, listLength, isSaved);
				break;
			}
			case EDITRECORD: {
				mainList = editRecord(mainList, listLength, isSaved);
				break;
			}
			case DELETERECORD: {
				mainList = deleteRecord(mainList, listLength, isSaved);
				break;
			}
			case SHOWLIST: {
				outputList(mainList, listLength);
				break;
			}
			case SHOWTASK: {
				performTask(mainList, listLength, isSaved);
				break;
			}
			case OPENFILE: {
				mainList = getListFromFile(listLength, isSaved);
				break;
			}
			case SAVEFILE: {
				writeListIntoFile(mainList, listLength, isSaved);
				break;
			}
			case SHOWINSTRUCTION: {
				outputInstruction();
				break;
			}
		}
		if (choice != EXIT)
			returnToMenu();
		else if (!isSaved && (listLength != 0)) {
			saveFileOnExit(mainList, listLength, "Желаете сохранить список в файл? Введите 1, если да, и 0, если нет: ", isSaved);
		}
	}
	cout << "Благодарим за приобретение программы Гараж!";
}

int main() {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	outputProgramInfo();
	performMenuOption();
	return 0;
}