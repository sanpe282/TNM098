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
    transform(line.begin(), line.end(), line.begin(), ::tolower);
    myArray.push_back(line);

}

for(int i = 0 ; i < myArray.size(); i++)
{
    cout << myArray[i] << endl;
}


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
