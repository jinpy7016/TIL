//실습 1
function handlePosts(){
    const posts = [{
        id:23,
        title:"오늘의 뉴스"
    },
    {
        id:34,
        title:"오늘의 스포츠",
    },
    {
        id:78,
        title:"오늘의 연예",
    }]

    // for(let i = 0; i < posts.length ; i++ ){
    //     console.log(posts[i])
    //     console.log(posts[i].id)
    //     console.log(posts[i].title)
    // }

    posts.forEach(function(post){
        console.log(post)
        console.log(post.id)
        console.log(post.title)
    })
}
handlePosts()

// 실습 2
// image 배열안에 있는 정보를 가지고
// 넓이를 구하고 그값을 aras에 저장
const IMAGES = [
    { height:10, width:30 },
    { height:22, width:37 },
    { height:54, width:42 }
]
let areas = []

IMAGES.forEach( image => areas.push(image.height * image.width) )
console.log(areas)