#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <queue>

using namespace std;

int main(){

    // Read file and assign to array
    ifstream file("data.txt");
    string tosses[60];

    if(file.is_open())
    {
        for(int i = 0; i < 60; i++)
        {
            file >> tosses[i];
        }
    }

    // Variables
    int num_of_zeros = 0;
    int num_of_ones = 0;
    int numbers[60][2];
    int sequence = 1;
    int longest_seq = 0;
    queue<int> test1_humans;
    queue<int> test2_humans;
    int test2_lim = 7;

    // Tests
    for(int i = 0; i < 60; i++)
    {
        string s = tosses[i];

        for(int j = 0; j < 200; j++)
        {
            // Calculate the distribution of zeros and ones
            if(s.substr(j,1)== "0")
                num_of_zeros++;

            if(s.substr(j,1)== "1")
                num_of_ones++;

            // Calculate the longest sequence
            if (s.substr(j,1) == s.substr(j+1,1))
                sequence++;
            else
            {
                if(sequence > longest_seq)
                    longest_seq = sequence;
                sequence = 1;
            }
        }

        numbers[i][1] = num_of_zeros;
        numbers[i][2] = num_of_ones;

        cout << i+1 << ": " << longest_seq << endl;

        cout << i+1 << ": " << numbers[i][1] << ", " << numbers[i][2] << endl;

        if(longest_seq < test2_lim)
            test2_humans.push(i+1);

        num_of_zeros = 0;
        num_of_ones = 0;
        sequence = 1;
        longest_seq = 0;
    }

    // --- FINAL RESULT --- //

    cout << "--*--*--*--*-- RESULT --*--*--*--*--" << endl;

    cout << "TEST 1: Count number of zeros and ones" << endl;
    cout << "If there is more than _ difference from 50/50 then the random generator is human/computer." << endl;
    cout << "If there is less than _ difference from 50/50 then the random generator is human/computer." << endl;
    cout << "The humans are: " << endl;
    cout << "Show humans here..." << endl;

    cout << "TEST 2: Count the longest sequence with the same number" << endl;
    cout << "If the sequence is longer or equal to 7 then the random generator is computer." << endl;
    cout << "If the sequence is shorter than 7 then the random generator is human." << endl;
    cout << "The humans are: " << endl;

    while(!test2_humans.empty())
    {
       cout << test2_humans.front() << ", ";
        test2_humans.pop();
    }
    cout << endl;

    cout << "TEST 3: Variance" << endl;

    cout << "--*--*--*--*--*--*--*--*--*--*--*--" << endl;

    return 0;
}

// LOLLOS TANKAR:
// Jämnt fördelat --> dator eller människa(kanske liiiite mer människa)
// Ojämnt fördelat --> troligtvis en dator
// Jämnt fördelat med små frekvenser i talföljd --> människa
// Jämnt fördelat med stora frekvenser i talföljd --> dator

// Jag vill räkna diffen mellan nollor och ettor för varje person.
// Spara alla diffar och hitta medelvärdet för diff. Använda medelvärdesdiffen för att beräkna variansen



// FRÅGOR:
// När människorna genererade random sekvens, fick de se tidigare nummer eller skrev de en i taget?
// När visste människan att sekvens var slut?
