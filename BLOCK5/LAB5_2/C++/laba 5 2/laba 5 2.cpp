#include <iostream>
#include <fstream>
#include <locale>
#include <Windows.h>
#include <string>
using namespace std;

struct Node {
	int value;
	Node* left;
	Node* right;
};

enum Error {correct, errNodeInTree, errMaxHeight, errIncorrectFileExt, errCantOpenFile, errCantSaveFile, errIncorrectValue};

const string ERRORMESSAGES [] = { "", "Узел с таким значением уже есть в дереве!", "Достигнута максимальная высота дерева!",
	"Файл должен иметь разрешение.txt!", "Произошла ошибка при открытии файла!", "Произошла ошибка при записи в файл!", "Проверьте корректность данных!"};
const int MINVALUE = -999;
const int MAXVALUE = 999;
const int MAXHEIGHT = 7;

void showErrorMessage(Error error) {
	cout << ERRORMESSAGES[error] << " Повторите попытку.\n";
}

Node* createTree(bool& isCreated, int rootValue) {
	Node* root;
	root = new Node;
	root->value = rootValue;
	root->left = nullptr;
	root->right = nullptr;
	isCreated = true;
	return root;
}

void findPlace(Node* node, Node* newNode) {
	if (newNode->value > node->value)
		if (node->right != nullptr)
			findPlace(node->right, newNode);
		else
			node->right = newNode;
	else if (node->left != nullptr)
		findPlace(node->left, newNode);
	else
		node->left = newNode;
}

void addNode(int value, Node* root) {
	Node* newNode;
	newNode = new Node;
	newNode->value = value;
	newNode->left = nullptr;
	newNode->right = nullptr;
	findPlace(root, newNode);
}

void destroyTree(Node*& node) {
	if (node->right != nullptr)
		destroyTree(node->right);
	if (node->right == nullptr) {
		if (node->left != nullptr)
			destroyTree(node->left);
		if (node->left == nullptr) {
			delete node;
			node = nullptr;
		}
	}
}

bool isValueInTree(int value, Node* root) {
	bool isInTree;
	isInTree = false;
	if (root != nullptr) {
		Node* temp;
		temp = root;
		while ((temp != nullptr) && !isInTree) {
			if (value == temp->value)
				isInTree = true;
			else if (value > temp->value)
				temp = temp->right;
			else
				temp = temp->left;
		}
	}
	return isInTree;
}

int findNodeHeight(int value, Node* root) {
	int nodeHeight;
	Node* temp;
	nodeHeight = 1;
	temp = root;
	while (temp != nullptr) {
		if (value > temp->value)
			temp = temp->right;
		else
			temp = temp->left;
		nodeHeight++;
	}
	return nodeHeight;
}

void countChildren(Node* node, int& curCount) {
	if (node == nullptr)
		curCount = 0;
	else {
		if (node->right != nullptr) {
			curCount++;
			countChildren(node->right, curCount);
		}
		if (node->left != nullptr) {
			curCount++;
			countChildren(node->left, curCount);
		}
	}
}

void findUnequalNodes(Node* node) {
	int rightChildren;
	int leftChildren;
	rightChildren = 1;
	leftChildren = 1;
	countChildren(node->right, rightChildren);
	countChildren(node->left, leftChildren);
	if (rightChildren != leftChildren)
		cout << node->value << "		" << leftChildren << "		" << rightChildren << "\n";
	if (node->right != nullptr)
		findUnequalNodes(node->right);
	if (node->left != nullptr)
		findUnequalNodes(node->left);
}

int inputNum(string outputMessage, const int MIN, const int MAX) {
	int num;
	Error error;
	do {
		error = correct;
		cout << outputMessage;
		cin >> num;
		if (cin.get() != '\n') {
			cin.clear();
			while (cin.get() != '\n');
			error = errIncorrectValue;
		}
		if ((error == correct) && ((num < MIN) || (num > MAX)))
			error = errIncorrectValue;
		if (error != correct)
			showErrorMessage(error);
	} while (error != correct);
	return num;
}

Error checkNodeValue(int value, Node* root) {
	Error error;
	error = correct;
	if (isValueInTree(value, root))
		error = errNodeInTree;
	else if (findNodeHeight(value, root) > MAXHEIGHT)
		error = errMaxHeight;
	return error;
}

void addValueToTree(Node*& root, bool& isCreated) {
	int value;
	Error error;
	do {
		value = inputNum("Введите значение для добавления в дерево (-999..999): ", MINVALUE, MAXVALUE);
		error = checkNodeValue(value, root);
		if (error != correct)
			showErrorMessage(error);
	} while (error != correct);
	if (!isCreated)
		root = createTree(isCreated, value);
	else
		addNode(value, root);
	cout << "Вершина успешно добавлена!\n";
}

void outputTree(Node* node, string offset, char nodeType, ostream& out) {
	out << offset << "[" << nodeType << "] " << node->value << "\n";
	if (node->right != nullptr) 
		outputTree(node->right, offset + "  ", 'R', out);
	if (node->left != nullptr)
		outputTree(node->left, offset + "  ", 'L', out);
}

Error checkFileExtension(string path, Error error) {
	if ((error == correct) && (path.substr(path.size() - 4) != ".txt"))
		error = errIncorrectFileExt;
	return error;
}

string getFileInputPath() {
	string path;
	Error error;
	do {
		error = correct;
		cout << "Введите путь к файлу:\n";
		getline(cin, path, '\n');
		ifstream fin(path);
		fin.open(path);
		if (!fin.is_open())
			error = errCantOpenFile;
		error = checkFileExtension(path, error);
		fin.close();
		if (error != correct)
			showErrorMessage(error);
	} while (error != correct);
	return path;
}

void getNumFromFile(Node*& root, bool& isCreated) {
	int value;
	Error error;
	string path;
	path = getFileInputPath();
	do {
		error = correct;
		ifstream fin(path);
		try {
			fin >> value;
			if (!fin.eof())
				error = errCantOpenFile;
			else if ((value > MAXVALUE) || (value < MINVALUE))
				error = errIncorrectValue;
			else if (isCreated)
				error = checkNodeValue(value, root);
		}
		catch (string errorMessage) {
			error = errCantOpenFile;
		}
		fin.close();
		if (error != correct) {
			showErrorMessage(error);
			path = getFileInputPath();
		}
	} while (error != correct);
	if (!isCreated)
		root = createTree(isCreated, value);
	else
		addNode(value, root);
	cout << "Данные из файла успешно считаны.\n";
}

string getFileOutputPath() {
	string path;
	Error error;
	do {
		error = correct;
		cout << "Введите путь к файлу, в который нужно записать результат:\n";
		getline(cin, path, '\n');
		error = checkFileExtension(path, error);
		if (error == correct) {
			ofstream fout(path);
			fout.open(path);
			if (!fout.is_open())
				error = errCantSaveFile;
			fout.close();
		}
		if (error != correct)
			showErrorMessage(error);
	} while (error != correct);
	return path;
}

void writeTreeIntoFile(Node* root) {
	Error error;
	string path;
	path = getFileOutputPath();
	do {
		error = correct;
		ofstream fout(path);
		try {
			outputTree(root, "", '-', fout);
		}
		catch (string errorMessage) {
			error = errCantSaveFile;
		}
		fout.close();
		if (error != correct) {
			showErrorMessage(error);
			path = getFileOutputPath();
		}
	} while (error != correct);
	cout << "Результат записан.\n";
}

void outputInstruction() {
	cout << "Инструкция\n\n" << "ИЗМЕНЕНИЕ ДЕРЕВА:\n1. Элементы дерева - целые числа в диапазоне - 999..999.\n2. Значения у вершин не могут повторяться.\n3. Максимальная высота дерева - 7.\n\n"
		 << "ФАЙЛЫ:\n1. Открываемый / сохраняемый файл должен быть формата * .txt.\n2. В открываемом файле должно быть записано только 1 число, которое добавится в дерево.\n3. При сохранении данные указанного файла перезаписываются.\n\n"
		 << "Разработчик: Городко Ксения\nЛабораторная №5.2\n";
}

void outputProgramInfo() {
	cout << "Добро пожаловать в программу для работы с бинарным деревом!\n";
}

void outputMenu() {
	cout << "Меню:\n";
	cout << "1) Добавить вершину;\n" << "2) Вывести дерево;\n" << "3) Вывести информацию по заданию;\n" << "4) Открыть файл;\n" << "5) Сохранить файл;\n" << "6) Вывести инструкцию;\n" << "7) Выход из программы.\n";
	cout << "Для выбора пункта меню введите его номер.\n";
}

void returnToMenu() {
	cout << "\nНажмите Enter для возвращения в меню...\n";
	getchar();
}

void performMenuOption() {
	const int ADD = 1;
	const int SHOW = 2;
	const int DOTASK = 3;
	const int OPENFILE = 4;
	const int SAVEFILE = 5;
	const int SHOWINSTRUCTION = 6;
	const int EXIT = 7;
	int choice;
	bool isCreated;
	Node* root;
	choice = 0;
	isCreated = false;
	root = nullptr;
	while (choice != EXIT) {
		outputMenu();
		choice = inputNum("", ADD, EXIT);
		cout << "\n";
		if ((choice == ADD) || (choice == OPENFILE) || (choice > SAVEFILE) || isCreated) {
			switch (choice) {
			case ADD: {
				addValueToTree(root, isCreated);
				break;
			}
			case SHOW: {
			 	outputTree(root, "", '-', cout);
				break;
			}
			case DOTASK: {
				cout << "Вывести номера вершин, у которых количество потомков в левом поддереве не равно количеству потомков в правом поддереве.\nВершина || Левые потомки || Правые потомки\n";
				findUnequalNodes(root);
				break;
			}
			case OPENFILE: {
				getNumFromFile(root, isCreated);
				break;
			}
			case SAVEFILE: {
				writeTreeIntoFile(root);
				break;
			}
			case SHOWINSTRUCTION: {
				outputInstruction();
				break;
			}
			}
		}
		else
			cout << "На данный момент дерева не существует.\n";
		if (choice != EXIT)
			returnToMenu();
	}
	if (isCreated)
		destroyTree(root);
	cout << "Ждем Вашего возвращения...";
}

int main() {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	outputProgramInfo();
	performMenuOption();
	return 0;
}