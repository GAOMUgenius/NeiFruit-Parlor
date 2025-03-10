export interface  ShopInterface {
  id: string,
  name: string,
  picture: string,
  category: string,
  location: string,
  rating: string,
  phone: string
}
export enum CateforyType{
  HOST = 0,
  FRESH,
  CATERING,
  SCENIC
}
export interface CateforyInterface {
  id: CateforyType,
  title: string
}

export const category_list: CateforyInterface[] = [
  {
    id: CateforyType.HOST,
    title: '热门'
  },
  {
    id: CateforyType.FRESH,
    title: '生鲜'
  },
  {
    id: CateforyType.CATERING,
    title: '餐饮'
  },
  {
    id: CateforyType.SCENIC,
    title: '景点'
  }
]
export const ShopList_Fresh: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"生鲜",
    location: "社区北门",
    rating: "4.8",
    phone:"189992199999",
  }
]
export const ShopList_Scenic: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"景点",
    location: "社区北门",
    rating: "4.8",
    phone:"189992199999",
  }
]
export const ShopList_Catering: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"餐饮",
    location: "社区北门",
    rating: "4.8",
    phone:"189992199999",
  }
]
export const ShopList_Host: ShopInterface[] = [
  {
    id: "1",
    name: "果果超市",
    picture: 'app.meida.shopPicture',
    category:"热门",
    location: "社区北门",
    rating: "4.8",
    phone:"189992199999",
  }
]
