export interface  ShopInterface {
  id: string,
  name: string,
  picture: string,
  category: string,
  location: string,
  rating: number,
  phone: string
}
export enum CategoryType{
  HOST = 0,
  FRESH,
  CATERING,
  SCENIC
}
// export interface CateforyInterface {
//   id: CategoryType,
//   title: string
// }
//
// export const category_list: CateforyInterface[] = [
//   {
//     id: CategoryType.HOST,
//     title:'热门'
//   },
//   {
//     id: CategoryType.FRESH,
//     title: '生鲜'
//   },
//   {
//     id: CategoryType.CATERING,
//     title: '餐饮'
//   },
//   {
//     id: CategoryType.SCENIC,
//     title: '景点'
//   }
// ]
export const ShopList_Fresh: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: 4.8,
    phone:"189992199999",
  },
  {
    id: "2",
    name: "肉肉商超",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: 3,
    phone:"1993333333",
  },
  {
    id: "3",
    name: "果蔬特卖",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区南门",
    rating: 4,
    phone:"189992199999",
  }
]
export const ShopList_Scenic: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: 4.8,
    phone:"189992199999",
  },
]
export const ShopList_Catering: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: 4.8,
    phone:"189992199999",
  },
]
export const ShopList_Host: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: 4.8,
    phone:"189992199999",
  },
]
