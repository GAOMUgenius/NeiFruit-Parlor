export interface  ShopInterface {
  id: string,
  name: string,
  picture: string[],
  category: string,
  location: string,
  rating: number,
  phone: string
}
export enum CategoryType{
  HOST = 0,//热门
  FRESH,//生鲜
  CATERING,//餐饮
  SCENIC//景点
}
// export const ShopList_Fresh: ShopInterface[] = [
//   {
//     id: "1",
//     name: "永辉超市",
//     picture: ['app.media.supermarkat_icon'],
//     category:"生鲜",
//     location: "社区北门",
//     rating: 4.8,
//     phone:"18336553278",
//   },
//   {
//     id: "2",
//     name: "四季欢喜生鲜",
//     picture: ['app.media.sijihuanxishengxian_icon'],
//     category:"生鲜",
//     location: "社区北门",
//     rating: 3,
//     phone:"15837312355",
//   },
//   {
//     id: "3",
//     name: "拼鲜喜生鲜超市",
//     picture: ['app.media.pinxianxi_icon'],
//     category:"生鲜",
//     location: "社区南门",
//     rating: 4,
//     phone:"18999219999",
//   },
//   {
//     id: "4",
//     name: "宅鲜乐生鲜",
//     picture: ['app.media.zhaixianle_icon'],
//     category:"生鲜",
//     location: "社区南门",
//     rating: 3.4,
//     phone:"13279493128",
//   },
//
// ]
// export const ShopList_Scenic: ShopInterface[] = [
//   {
//     id: "1",
//     name: "大兴善寺",
//     picture: 'app.media.daxingshansi_icon',
//     category:"生鲜",
//     location: "雁塔区小寨兴善寺",
//     rating: 4.8,
//     phone:"189992199999",
//   },
// ]
// export const ShopList_Catering: ShopInterface[] = [
//   {
//     id: "1",
//     name: "同州水盆",
//     picture: 'app.media.tongzhoushuipen_icon',
//     category:"生鲜",
//     location: "长安区青渠街",
//     rating: 4.8,
//     phone:"156332488757",
//   },
// ]
// export const ShopList_Host: ShopInterface[] = [
//   {
//     id: "1",
//     name: "永辉超市",
//     picture: 'app.media.supermarkat_icon',
//     category:"生鲜",
//     location: "社区北门",
//     rating: 4.8,
//     phone:"18336553278",
//   },
//   {
//     id: "2",
//     name: "四季欢喜生鲜",
//     picture: 'app.media.sijihuanxishengxian_icon',
//     category:"生鲜",
//     location: "社区北门",
//     rating: 3,
//     phone:"15837312355",
//   },
//   {
//     id: "3",
//     name: "同州水盆",
//     picture: 'app.media.tongzhoushuipen_icon',
//     category:"生鲜",
//     location: "社区北门",
//     rating: 4.8,
//     phone:"156332488757",
//   },
//   {
//     id: "4",
//     name: "拼鲜喜生鲜超市",
//     picture: 'app.media.pinxianxi_icon',
//     category:"生鲜",
//     location: "社区南门",
//     rating: 4,
//     phone:"18999219999",
//   },
//   {
//     id: "5",
//     name: "宅鲜乐生鲜",
//     picture: 'app.media.zhaixianle_icon',
//     category:"生鲜",
//     location: "社区南门",
//     rating: 3.4,
//     phone:"13279493128",
//   },
// ]
