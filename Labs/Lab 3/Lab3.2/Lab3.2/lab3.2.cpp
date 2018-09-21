#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <sstream>

using namespace std;

int main(){

ifstream myFile;
string line;
string myStream;
string input;
vector<string> myArray;
const char delim = '.';

myFile.open("01.txt");

if(!myFile)
{
    cout << "Error opening file!" << endl;
}

if(myFile)
{
    while(getline(myFile, input))
        myStream += " " + input;
}

//cout << myStream << endl;

stringstream newString(myStream);

size_t start = 0;
size_t finish = myStream.find_first_of(".!?", start);

/*if(finish != string::npos)
{
    line = myStream.substr(start, finish);
    cout << line << endl;
    cout << "End of line found" << endl;

    start = myStream.find_first_not_of(" \t\n", finish+1);
}*/

while(getline(newString, line, delim))
{
    line.erase(remove(line.begin(), line.end(), '_'), line.end());
    line.erase(remove(line.begin(), line.end(), '-'), line.end());
    line.erase(remove(line.begin(), line.end(), ','), line.end());
    line.erase(remove(line.begin(), line.end(), '"'), line.end());
    line.erase(remove(line.begin(), line.end(), '*'), line.end());
    line.erase(remove(line.begin(), line.end(), ' '), line.end());
    line.erase(remove(line.begin(), line.end(), '\n'), line.end());
    transform(line.begin(), line.end(), line.begin(), ::tolower);

    myArray.push_back(line);

}

vector<int>lineAscii;
vector<int>myAscii;

for(int i = 0 ; i < myArray.size(); i++)
{
//    if(!myArray[i].empty())
//        cout << myArray[i] << endl;
//    else
//        cout << "Empty slot!" << endl;

    string word = myArray[i];
    cout << word << endl;
    for (int j=0; j < word.length(); j++)
    {
        char w = word.at(j);
        cout << int(w) << " ";
        lineAscii.push_back(w);

    }

    myAscii.push_back(lineAscii);
    lineAscii.clear();
    word = "";
    cout << endl;
}

for(int i = 0; i< myAscii.size(); i++)
{
    cout << myAscii[i] << endl;
}


//string word = myArray[0];
//for(int i=0; i < word.length(); i++)
//{
//    char x = word.at(i);
//    cout << int(x) << " ";
//}

/* vector<string> myrow;
 * string myLine = myArray[2];
 *
 * myLine.erase(remove(myLine.begin(), myLine.end(), ' '), myLine.end());
 * myrow.push_back(myLine);
 *
 * cout << myrow[0] << endl;
 */



/*
for(int i = 0; i < 11; i++)
{
    if(i < 10){
        myFile.open("0"+i+".txt");
        if(myFile.is_open())
            myFile >> lines[i];
    }
    else
        myFile.open(i+".txt");
         if(myFile.is_open())
            myFile >> lines[i];
}*/



return 0;
}
