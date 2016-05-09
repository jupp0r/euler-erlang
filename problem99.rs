fn main() {
    use std::fs::File;
    use std::io::BufReader;      
    use std::io::prelude::*;
    use std::vec::Vec;           
                                 
    let file = File::open("problem99.txt").unwrap();
    let buf = BufReader::new(file);

    let mut i = 1u32;
    let mut max = 0f64;
    let mut max_position = 0u32;
    for line in buf.lines() {
        let l = line.unwrap();
        let nums = l.split(",").collect::<Vec<&str>>();
        let base = nums[0].parse::<f64>().unwrap();
        let exponent = nums[1].parse::<f64>().unwrap();
        let res = exponent * base.ln();
        if  res > max {
            max_position = i;
            max = res;
        }
        i = i + 1;               
    }

    println!("{}", max_position);
}
