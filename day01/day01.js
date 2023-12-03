// only example data for brevity
const puzzleInput = `1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchetsix1mpffbnbnnlxthree
4eight3one92`;

const wordToDigit = {
  "one": "1",
  "two": "2",
  "three": "3",
  "four": "4",
  "five": "5",
  "six": "6",
  "seven": "7",
  "eight": "8",
  "nine": "9"
};

const splitInputLines = (multilineInput) => multilineInput.split("\n");

//returns digit from digit or word
const digitFromWord = (word) => wordToDigit[word] ? wordToDigit[word] : word;

const digitsToNumber = (digit1, digit2) => parseInt(`${digit1}${digit2}`)

let getFirstAndLastDigit = splitInputLines(puzzleInput).reduce(
  (accumulator, currentValue) => {
    const regExp = /\d|one|two|three|four|five|six|seven|eight|nine/g;

    let matches = currentValue.match(regExp);

    return accumulator + digitsToNumber(digitFromWord(matches[0]), digitFromWord(matches[matches.length-1]));

  }, 0);

console.log(getFirstAndLastDigit);