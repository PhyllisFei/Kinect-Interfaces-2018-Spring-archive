int[] numbers = {5, 3, 2, 1, 4, 10, 20};

void setup() {

  float sum = 0;
  int count = 0;
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] >= 5 && numbers[i] <= 10) {
      sum += numbers[i];
      count ++;
    }
  }
  float avg = 0;
  if (count > 0) {
    avg = sum / count;
  }

  println(avg);

  noLoop();
}