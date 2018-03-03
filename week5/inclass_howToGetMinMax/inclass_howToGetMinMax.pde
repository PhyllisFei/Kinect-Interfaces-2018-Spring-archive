int[] numbers = {20, 5, 3, 2, 1, 4, 10};

void setup() {
  int min = 10000; //arbitrary number
  int max = 0;
  for (int i=0; i<numbers.length; i++) {
    if (max < numbers[i]) {
      max = numbers[i];
    }
    if (min > numbers[i]) {
      max = numbers[i];
      println(min);
    }
  }
  println("Result:" + max);

  noLoop();
}