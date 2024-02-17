#include <iostream>
#include <fstream>
using namespace std;

const double MIN = 0;
const double MAX_X = 100000;
const double MAX_EPS = 1;
const string CONSOLE_CHOICE = "0";
const string FILE_CHOICE = "1";

bool isRangeIncorrect(double num, const double MAX) {
    bool isIncorrect;
    isIncorrect = false;
    if ((num > MAX) || (num < MIN) || (num == MIN)) {
        isIncorrect = true;
        cout << "Значение не попадает в диапазон! Повторите попытку.\n";
    }
    return isIncorrect;
}

double getNumFromConsole(string outputMessage, const double MAX) {
    double num;
    bool isIncorrect;
    num = 0;
    do {
        isIncorrect = false;
        cout << outputMessage;
        cin >> num;
        if (cin.get() != '\n') {
            cin.clear();
            while (cin.get() != '\n');
            isIncorrect = true;
            cout << "Значения должны быть вещественными числами! Повторите попытку.\n";
        }
        if (!isIncorrect)
            isIncorrect = isRangeIncorrect(num, MAX);
    } while (isIncorrect);
    return num;
}

bool isFileExtIncorrect(string path, bool isIncorrect) {
    if (!isIncorrect && (path.substr(path.size() - 4) != ".txt")) {
        cout << "Введенный Вами файл не является текстовым! Повторите попытку.\n";
        isIncorrect = true;
    }
    return isIncorrect;
}

string getFileInputPath() {
    string path;
    bool isIncorrect;
    do {
        isIncorrect = false;
        cout << "В файле должно быть 2 строки, первая - со значением X, вторая - со значением точности.\n";
        cout << "Введите путь к файлу.\n";
        cin >> path;
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

double getNumFromFile(bool& isIncorrect, const double MAX, ifstream& fin) {
    double num;
    num = 0;
    fin >> num;
    if (!isIncorrect && fin.fail()) {
        fin.clear();
        isIncorrect = true;
        cout << "Значения должны быть вещественными числами! Повторите попытку.\n";
    }
    if (!isIncorrect)
        isIncorrect = isRangeIncorrect(num, MAX);
    return num;
}

void getDataFromFile(double& x, double& eps, string path) {
    bool isIncorrect;
    do {
        isIncorrect = false;
        ifstream fin(path);
        try {
            x = getNumFromFile(isIncorrect, MAX_X, fin);
            if (!isIncorrect) {
                eps = getNumFromFile(isIncorrect, MAX_EPS, fin);
                if (!fin.eof()) {
                    cout << "В файле некорректное количество строк! Повторите попытку.\n";
                    isIncorrect = true;
                }
            }
        }
        catch (string errorMessage) {
            cout << "Произошла ошибка при чтении из файла! Повторите попытку.\n";
            isIncorrect = true;
        }
        fin.close();
        if (isIncorrect)
            path = getFileInputPath();
    } while (isIncorrect);
    cout << "Данные из файла успешно считаны.\n";
}

string getChoice(string outputMessage) {
    string choice;
    bool isIncorrect;
    do {
        isIncorrect = false;
        cout << outputMessage;
        cin >> choice;
        if ((choice != CONSOLE_CHOICE) && (choice != FILE_CHOICE)) {
            isIncorrect = true;
            cout << "Введено некорректное значение! Повторите попытку.\n";
        }
    } while (isIncorrect);
    return choice;
}


void inputData(double& x, double& eps) {
    string choice;
    string finPath;
    x = 0;
    choice = getChoice("Введите 0, если хотите вводить данные через консоль, или 1, если использовать файл: ");
    if (choice == CONSOLE_CHOICE) {
        x = getNumFromConsole("Введите X: ", MAX_X);
        eps = getNumFromConsole("Введите точность: ", MAX_EPS);
    }
    else {
        finPath = getFileInputPath();
        getDataFromFile(x, eps, finPath);
    }
}

double calcSquareRoot(double x, double eps, double prev) {
    double y;
    double delta;
    y = 1.0 / 2.0 * (prev + x / prev);
    delta = abs(y - prev);
    if (delta > eps)
        return calcSquareRoot(x, eps, y);
    else
        return y;
}

string getFileOutputPath() {
    string path;
    bool isIncorrect;
    do {
        isIncorrect = false;
        cout << "Введите путь к файлу, в который нужно записать результат.\n";
        cin >> path;
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

void writeResultIntoFile(string path, double y, double x, double eps) {
    bool isIncorrect;
    do {
        isIncorrect = false;
        ofstream fout(path);
        try {
            fout << "Квадратный корень из " << x << " с точностью " << eps << " равен " << y;
        }
        catch (string errorMessage) {
            cout << "Произошла ошибка при записи в файл! Повторите попытку.\n";
            isIncorrect = true;
        }
        fout.close();
        if (isIncorrect)
            path = getFileOutputPath();
    } while (isIncorrect);
    cout << "Результат записан.\n";
}

void outputResult(double y, double x, double eps) {
    string choice;
    string foutPath;
    choice = getChoice("Введите 0, если нужно вывести результат в консоль, или 1, если записать в файл: ");
    if (choice == CONSOLE_CHOICE)
        cout << "Квадратный корень из " << x << " с точностью " << eps << " равен " << y;
    else {
        foutPath = getFileOutputPath();
        writeResultIntoFile(foutPath, y, x, eps);
    }
}

void writeCondition() {
    cout << "Данная программа, используя итерационную формулу Ньютона, находит с заданной точностью квадратный корень из X.\n";
    cout << "X и Eps (точность) - вещественные числа. X должно находиться в диапазоне (0, 100000], а Eps - (0, 1].\n";
}

int main() {
    setlocale(LC_ALL, "Russian");
    double x;
    double eps;
    double y;
    y = 1;
    writeCondition();
    inputData(x, eps);
    y = calcSquareRoot(x, eps, y);
    outputResult(y, x, eps);
    return 0;
}