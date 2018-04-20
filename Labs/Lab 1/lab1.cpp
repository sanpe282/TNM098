#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <queue>
#include <math.h>
#include <array>

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
    queue<int> test3_humans;
    int test2_lim = 7;

    // Tests
    for(int i = 0; i < 60; i++)
    {
        string s = tosses[i];

        for(int j = 0; j < 200; j++)
        {
            // Calculate the distribution of zeros and ones
            if(s.substr(j,1) == "0")
                num_of_zeros++;

            if(s.substr(j,1) == "1")
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

        if(diff[i] > 10)
            test1_humans.push(i+1);

        sum_mean += diff[i];

        //cout << i+1 << " - Longest sequence: " << longest_seq << endl;
        //cout << i+1 << " - Distribution: " << numbers[i][1] << ", " << numbers[i][2] << endl;
        //cout << i+1 << " - Difference: " << diff[i] << endl << endl;

        if(longest_seq < test2_lim)
            test2_humans.push(i+1);

        num_of_zeros = 0;
        num_of_ones = 0;
        sequence = 1;
        longest_seq = 0;
    }

    double sum = 0;
    double s_dev = 0;
    double var = 0;

    for(int i = 0; i < 60; i++)
    {
        sum += pow((diff[i] - sum_mean),2);
    }

    sum_mean = sum_mean/60;
    var = sum/60;
    s_dev = sqrt(var);

    //cout << "Final sum_mean: " << sum_mean << endl;
    //cout << "Variance: " << var << endl;
    //cout << "Standard deviation: " << s_dev << endl << endl;

    string possible_outcome[] = {"1111", "1110", "1101", "1100", "1011", "1010", "1001", "1000", "0111", "0110", "0101", "0100", "0011", "0010", "0001", "0000"};
    int dist[61][51];
    int num_of_dist[61][17] = {{0}};

    for(int i = 0; i < 60; i++) //for every person
    {
        for(int j = 0; j < 50; j++) //for every 'four'
        {
            string four = "";
            string s = tosses[i];

            for(int slot = j*4; slot < (j*4+4); slot++)
            {
                four += s.substr(slot,1);
            }

            //Compare 'four' with possible_outcome
            for(int k = 0; k < 16; k++)
            {
                if(four == possible_outcome[k])
                {
                    dist[i][j] = k;
                    num_of_dist[i][k]++;
                }
            }
        }

        double dist_mean = 0;
        int opt = 3.125;

        //cout << "Person: " << i+1 << endl;

        //Print num_of_dist
        for(int k = 0; k < 16; k++)
        {
            //cout << k  << ": " << num_of_dist[i][k] << endl;

            dist_mean += fabs(num_of_dist[i][k] - opt);
        }

        dist_mean = dist_mean/16;

        if(dist_mean > 1.5)
            test3_humans.push(i+1);

        //cout << "Dist mean: " << dist_mean << endl << endl;
    }

    // --- FINAL RESULT --- //

    cout << "--*--*--*--*-- RESULT --*--*--*--*--" << endl << endl;

    cout << "TEST 1: Count number of zeros and ones" << endl;
    cout << "If there is more than 10 difference from 50/50 then the random generator is computer." << endl;
    cout << "If there is less than or equal to 10 difference from 50/50 then the random generator is human." << endl;
    cout << "The humans are: " << endl;

    while(!test1_humans.empty())
    {
       cout << test1_humans.front() << ", ";
        test1_humans.pop();
    }
    cout << endl << endl;

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
    cout << "If the mean difference from the optimal distribution of 'fours' is smaller than or equal to 1.5 then the random generator is a computer." << endl;
    cout << "If the mean difference from the optimal distribution of 'fours' is larger than  1.5 then the random generator is a human." << endl;
    cout << "The humans are: " << endl;

    while(!test3_humans.empty())
    {
       cout << test3_humans.front() << ", ";
        test3_humans.pop();
    }
    cout << endl << endl;

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
