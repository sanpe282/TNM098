#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <sstream>

using namespace std;

int main(){

    string line;
    string myStream;
    string input;
    vector<string> myArray;
    const char delim = '.';

    vector<string>allSentences;
    vector<vector<string>>allFiles;

    // ----- Process all the file to get numbers ----- //
    for(int i = 1; i <= 10; i++)
    {
        cout << "----- TEXT " << i << " -----" << endl;

        // Create the filename for all the files
        stringstream ss;
        ss << i << ".txt";
        string filename = ss.str();

        // Open file
        ifstream myFile;
        myFile.open(filename);
        filename = "";

        // Test if file opens successfully
        if(!myFile)
        {
            cout << "Error opening file!" << endl;
        }
        else if(myFile)
        {
            cout << "Opened file successfully!" << endl;

            while(getline(myFile, input))
                myStream += " " + input;
        }

        // Close file
        myFile.close();

        stringstream newString(myStream);

        size_t start = 0;
        size_t finish = myStream.find_first_of(".!?", start);

        myStream = "";

        // Remove all characters in line
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
            line = "";
        }

        vector<int>lineAscii;
        vector<vector<int>>textAscii;

        // Convert each letter to ascii
        for(int i = 0; i < myArray.size(); i++)
        {
            string word = myArray[i];

            if(word != "")
            {
                for (int j = 0; j < word.length(); j++)
                {
                    char w = word.at(j);
                    lineAscii.push_back(w);
                }

                // Save lineAscii
                textAscii.push_back(lineAscii);

                lineAscii.clear();
            }
        }

        myArray.clear();

        for(int i = 0; i < textAscii.size(); i++)
        {
            stringstream sentence;

            for(int j = 0; j < textAscii[i].size(); j++)
            {
                sentence << textAscii[i][j];
            }

            string mySentence = sentence.str();
            allSentences.push_back(mySentence);
        }

        allFiles.push_back(allSentences);
        allSentences.clear();
    }

    // ----- Compare the files sentence by sentence ----- //
    for(int file = 0; file < allFiles.size(); file++)
    {
        cout << "----- TEXT " << file+1 << " -----" << endl;

        // Compare
        for(int sent = 0; sent < allFiles[file].size(); sent++)
        {
            //cout << "The sentence: " << allFiles[file][sent] << endl;

            //vector<string>theSent = allFiles[file][sent];

            //vector<string>testSent = allFiles[file][sent];

            if(allFiles[file][sent] == allFiles[file][sent])
                cout << "Match found" << endl;
        }

        // Find the sentence
        // The shortest match

        // Find the paragraph
        // The longest match

    }

    return 0;
}
