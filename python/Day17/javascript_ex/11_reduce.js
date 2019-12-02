// 배열의 총합을 구해라
const numbers = [1,2,3,4]

// before
// let total = 0;
// for(let i =0; i<numbers.length; i++){
//     total += numbers[i]
// }

//using reduce
let sum = numbers.reduce(function (total, num){
    return total += num
},0)
console.log(sum)
console.log(numbers)

// 실습 1
// 평균을 구해라
const testResults = [90, 85, 70, 78, 58, 86, 99, 82]
let avg = testResults.reduce(function(total, num){
    return total += num
},0)/testResults.length
console.log(avg)

// 실습 2
// 배열에 담긴 {이름 : 중복 횟수 } 로 반환 
// {"pengsu": 2, "pororo":1, "bbung":2,"bungaeman":1}
const names = ['pengsu', 'bbung', 'pororo', 'bbung', 'bungaeman', 'pengsu']
let count = names.reduce(function (allNames, name){
    if(name in allNames){
        allNames[name] += 1        
    }else{
        allNames[name] = 1
    }
    return allNames
}, {})

console.log(count)