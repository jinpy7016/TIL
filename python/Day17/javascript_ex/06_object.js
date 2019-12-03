const pengsu ={
    name : "펭수",
    "phone number": '01012345678',
    profile:{
      dream: "우주 대스타",
      age: '10살',
      speciality: "요들송"
    }
  }
  
  console.log(pengsu.name)
  console.log(pengsu['name'])
  console.log(pengsu['phone number'])
  
  console.log(pengsu.profile)
  console.log(pengsu.profile.dream)

  ///////////////////////////////
  var books = ['Learning JS', 'Learning Django']
var comics = {
  DC: ['AquaMan', 'SuperMan'],
  Marvel: ['IronMan', 'AntMan']
}

var magazines = null;

// before
// var bookShop = {
//   books: books,
//   comics: comics,
//   magazines: magazines
// }

// after
let bookShop = {
  books,
  comics,
  magazines,
}

console.log(bookShop)
console.log(typeof bookShop)
console.log(bookShop.books[0])