const NUMBERS = [1,2,3,4,5]

//some
const some_result = NUMBERS.some(function(e){
    return e % 2 === 0 
})
console.log(some_result) //true

//every 
const every_result = NUMBERS.every(function(e){
    return e % 2 === 0
})
console.log(every_result) //false