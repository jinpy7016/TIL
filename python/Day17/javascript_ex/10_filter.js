const PRODUCTS = [
    { name : 'cucumber', type:'vegetable'},
    { name : 'banana', type:'fruit'},
    { name : 'carrot', type:'vegetable'},
    { name : 'apple', type:'fruit'},
]

//before 
// var selectProducts = []
// for (var i=0; i< PRODUCTS.length; i++){
//     if(PRODUCTS[i].type === 'vegetable'){
//         selectProducts.push(PRODUCTS[i])
//     }
// }
// console.log(selectProducts)

// let selectProducts = PRODUCTS.filter(function(prod){
//     return prod.type === 'vegetable'
// })
// console.log(selectProducts)


// 실습1
// 89점 이상인 결과만 배열로 저장
const testResults = [90, 85, 70, 78, 58, 86, 99, 82]
let over80 = testResults.filter(function (score) {
    return score >= 80    
})
console.log(over80)

