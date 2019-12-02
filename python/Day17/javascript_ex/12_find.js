let heroes = [
    { name: 'tony stark', age:45},
    { name: 'captin ame', age:82},
    { name: 'thor', age:1500},
    { name: 'tony stark', age:25},
]

//before
// var hero = {}
// for (let i = 0; i < heroes.length; i++) {
//     if (heroes[i].name === 'tony stark') {
//         hero = heroes[i]
//         break;
//     }
// }
// console.log(hero)

let hero = heroes.find(function(man){
    return man.name === 'tony stark'
})
console.log(hero)

// 실습 1
// 잔액이 2만원 이상인 사람의 이름 출력
const ACCOUNTS = [
    { name:'pengsu', money:1200 },
    { name:'bbung', money:24000 },
    { name:'pororo', money:50000 },
]
let aaa = ACCOUNTS.find(function(man){
    return man.money >= 20000
}).name
console.log(aaa)