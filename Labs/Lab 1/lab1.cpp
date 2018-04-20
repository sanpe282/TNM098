#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <queue>
#include <math.h>

using namespace std;

int main(){

    // Read file and assign to array
    ifstream file("data.txt");
    string tosses[61];

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
    int numbers[61][2];
    int diff[61];
    double sum_mean = 0;
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
        diff[i] = fabs(100-num_of_ones);

        sum_mean += diff[i];

        cout << i+1 << " - Longest sequence: " << longest_seq << endl;
        cout << i+1 << " - Distribution: " << numbers[i][1] << ", " << numbers[i][2] << endl;
        cout << i+1 << " - Difference: " << diff[i] << endl;
        cout << sum_mean << endl << endl;

        if(longest_seq < test2_lim)
            test2_humans.push(i+1);

        num_of_zeros = 0;
        num_of_ones = 0;
        sequence = 1;
        longest_seq = 0;
    }

    sum_mean = sum_mean/60;

    cout << "Final sum_mean: " << sum_mean << endl;

    double sum = 0;
    double s_dev = 0;
    double var = 0;

    for(int i = 0; i < 60; i++)
    {
        sum += pow((diff[i] - sum_mean),2);
    }

    var = sum/60;
    s_dev = sqrt(var);

    cout << "Variance: " << var << endl;
    cout << "Standard deviation: " << s_dev << endl << endl;


    for(int i = 0; i < 60; i++)
    {
        sum += pow((diff[i] - sum_mean),2);
    }


    // --- FINAL RESULT --- //

    cout << "--*--*--*--*-- RESULT --*--*--*--*--" << endl << endl;

    cout << "TEST 1: Count number of zeros and ones" << endl;
    cout << "If there is more than _ difference from 50/50 then the random generator is human/computer." << endl;
    cout << "If there is less than _ difference from 50/50 then the random generator is human/computer." << endl;
    cout << "The humans are: " << endl;
    cout << "Show humans here..." << endl << endl;

    cout << "TEST 2: Count the longest sequence with the same number" << endl;
    cout << "If the sequence is longer or equal to 7 then the random generator is computer." << endl;
    cout << "If the sequence is shorter than 7 then the random generator is human." << endl;
    cout << "The humans are: " << endl;

    while(!test2_humans.empty())
    {
       cout << test2_humans.front() << ", ";
        test2_humans.pop();
    }
    cout << endl << endl;

    cout << "TEST 3: Variance" << endl;

    cout << "--*--*--*--*--*--*--*--*--*--*--*--" << endl;

    return 0;
}

// LOLLOS TANKAR:
// J�mnt f�rdelat --> dator eller m�nniska(kanske liiiite mer m�nniska)
// Oj�mnt f�rdelat --> troligtvis en dator
// J�mnt f�rdelat med sm� frekvenser i talf�ljd --> m�nniska
// J�mnt f�rdelat med stora frekvenser i talf�ljd --> dator

// Jag vill r�kna diffen mellan nollor och ettor f�r varje person.
// Spara alla diffar och hitta medelv�rdet f�r diff. Anv�nda medelv�rdesdiffen f�r att ber�kna variansen



// FR�GOR:
// N�r m�nniskorna genererade random sekvens, fick de se tidigare nummer eller skrev de en i taget?
// N�r visste m�nniskan att sekvens var slut?
