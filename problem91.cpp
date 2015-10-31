#include <iostream>
#include <set>
#include <tuple>
#include <algorithm>
#include <numeric>
#include <vector>

int main(int argc, char** argv)
{
    using std::set;
    using coordinate = std::tuple<int, int>;
    using coordinate_container = set<std::tuple<coordinate, coordinate>>;

    std::vector<int> range(51);

    std::iota(range.begin(), range.end(), 0);

    coordinate_container coordinates;

    for(auto x1 : range) {
        for(auto y1 : range) {
            for(auto x2 : range) {
                for(auto y2 : range) {
                    auto first_tuple = coordinate(x1,y1);
                    auto second_tuple = coordinate(x2,y2);
                    auto zero_tuple = coordinate(0,0);

                    if (first_tuple == zero_tuple || second_tuple == zero_tuple) {
                        continue;
                    }
                    if (first_tuple == second_tuple) {
                        continue;
                    }

                    auto a = x1*x1+y1*y1;
                    auto b = x2*x2+y2*y2;
                    auto c = (x2-x1)*(x2-x1)+(y2-y1)*(y2-y1);
                    bool contains_right_angle =
                            a + b == c ||
                            a + c == b ||
                            b + c == a;

                    if (! contains_right_angle) {
                        continue;
                    }

                    auto coordinate_pair = std::make_tuple(first_tuple, second_tuple);
                    coordinates.insert(coordinate_pair);
                }
            }
        }
    }

    std::cout << coordinates.size()/2 << std::endl;
}
