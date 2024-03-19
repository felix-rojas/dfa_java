#include <cctype>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::cout;
using std::endl;
using std::ifstream;
using std::string;
using std::vector;

vector<string> generate_states(const string &keyword) {
  vector<string> states;
  states.push_back(keyword);
  for (unsigned int i = 0; i < keyword.length(); i++) {
    string temp = keyword + std::to_string(i);
    states.push_back(temp);
  }
  return states;
}

void generate_transitions(const vector<string> &states) {
  cout << "% -------------------" << endl;
  cout << "% Keyword " << states[0] << " States" << endl;
  cout << "% -------------------" << endl;

  for (unsigned int i = 1; i < states.size(); i++) {
    cout << "state(" << states[i] << ")." << endl;
    if (i == states.size() - 1)
      cout << "kwd_accepting(" << states[i] << ")." << endl;
  }

  cout << "% --------------------------------------" << endl;
  cout << "% Keyword \'" << states[0] << "\' Transitions" << endl;
  cout << "% --------------------------------------" << endl;

  cout << "transition(keyword_check,X," + states[1] + "):-" << endl;
  cout << "\tX==\'" << states[0][0] << "\';" << endl;
  cout << "\tX==\'" << char(std::toupper(states[0][0])) << "\'." << endl;

  for (unsigned int i = 1; i < states.size() - 1; i++) {
    string temp1 = states[i];
    string temp2 = states[i + 1];
    char state_lettters = states[0][i];
    cout << "transition(" + temp1 + ",X," + temp2 + "):-" << endl;
    cout << "\tX==\'" << state_lettters << "\';" << endl;
    cout << "\tX==\'" << char(std::toupper(state_lettters)) << "\'." << endl;
  }
  cout << "% ------------------" << endl;
  cout << "% Transitions to q1" << endl;
  cout << "% ------------------" << endl;
  for (unsigned int i = 1; i < states.size(); i++) {
    string temp1 = states[i];
    char state_lettters = states[0][i];
    cout << "transition(" + temp1 + ",X," + "q1" + "):-" << endl;
    if (i != states.size() - 1) {
      cout << "\tX\\=\'" << state_lettters << "\'," << endl;
      cout << "\tX\\=\'" << char(std::toupper(state_lettters)) << "\'," << endl;
      cout << "\tchar_type(X,alpha)"
           << "." << endl;
    } else {
      cout << "\tchar_type(X,alpha)"
           << "." << endl;
    }
  }
  cout << "% -----------------" << endl;
  cout << "% Transitions to q3" << endl;
  cout << "% -----------------" << endl;
  for (unsigned int i = 1; i < states.size(); i++) {
    string temp1 = states[i];
    cout << "transition(" + temp1 + ",X," + "q3" + "):-";
    cout << "\tX==\'$\'"
         << "." << endl;
  }
  cout << "% -----------------" << endl;
  cout << "% Transitions to q4" << endl;
  cout << "% -----------------" << endl;
  for (unsigned int i = 1; i < states.size(); i++) {
    string temp1 = states[i];
    char state_lettters = states[0][i];
    cout << "transition(" + temp1 + ",X," + "q4" + "):-" << endl;
    cout << "\tchar_type(X,digit)"
         << "." << endl;
  }
  cout << "% -----------------" << endl;
  cout << "% Transitions to q5" << endl;
  cout << "% -----------------" << endl;
  for (unsigned int i = 1; i < states.size(); i++) {
    string temp1 = states[i];
    char state_lettters = states[0][i - 1];
    cout << "transition(" + temp1 + ",X," + "q5" + "):-";
    cout << "\tX==\'_\'"
         << "." << endl;
  }
}

int main() {
  string line;
  vector<string> kwds_vec;
  ifstream file("kwds.txt");
  if (file.is_open()) {
    while (getline(file, line)) {
      kwds_vec.push_back(line);
    }
    file.close();
  } else {
    cout << "No keyword list found." << endl;
  }

  for (auto keyword : kwds_vec) {
    vector<string> kwd_states = generate_states(keyword);
    generate_transitions(kwd_states);
  }

  return 0;
}