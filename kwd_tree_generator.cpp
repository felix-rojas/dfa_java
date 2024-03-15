#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::string; 
using std::vector; 
using std::ifstream; 
using std::cout; 
using std::endl; 

void generate_states(const string &keyword){
    for (unsigned int i = 0; i < keyword.length(); i++){
        cout << "state(" << keyword << i << ")." << endl;
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
  }
  else {
    cout << "No keyword list found." << endl;
  }
  for (auto keyword : kwds_vec) {
    generate_states(keyword);
  }

  return 0;
}