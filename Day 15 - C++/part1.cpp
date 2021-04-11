#include <iostream>
#include <bitset>

int main() {
    int64_t a = 699;
    int64_t b = 124;
    int64_t mula = 16807;
    int64_t mulb = 48271;
    int64_t mod = 2147483647;
    int result = result;
    
    for (int i=0;i<40000000;i++) {
        a = (a * mula) % mod;
        b = (b * mulb) % mod;
        std::bitset<16> ab(a);
        std::bitset<16> bb(b);
        result += (ab == bb);
    }
    std::cout << result << "\n";

    return 0;
}
