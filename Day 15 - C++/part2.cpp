#include <iostream>
#include <bitset>


int main() {
    int64_t a = 699;
    int64_t b = 124;
    int64_t mula = 16807;
    int64_t mulb = 48271;
    int64_t mod = 2147483647;
    int64_t result = 0;

    int64_t* nums_a = new int64_t[5000000];
    int64_t* nums_b = new int64_t[5000000];
    int found_a = 0;
    int found_b = 0;
    int five_million = 5000000;
    
    while (found_a < five_million) {
        a = (a * mula) % mod;
        if (a % 4 == 0) {
            nums_a[found_a] = a;
            found_a++;
        }
    }

    while (found_b < five_million) {
        b = (b * mulb) % mod;
        if (b % 8 == 0) {
            nums_b[found_b] = b;
            found_b++;
        }
    }
    for (int i=0;i<five_million;i++) {
        std::bitset<16> ab(nums_a[i]);
        std::bitset<16> bb(nums_b[i]);
        result += (ab == bb);
    }
    
    std::cout << result << "\n";

    return 0;
}
