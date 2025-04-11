import { ProductData } from "uicomponents"

export class ShopInfoData {
  id: number = 1
  shop_picture: ResourceStr[] = [$r('app.media.ShopInfoSwiper1'), $r('app.media.ShopInfoSwiper2'), $r('app.media.ShopInfoSwiper3')]
  shop_name: string = '引力舍'
  shop_rating: number = 3.5
  shop_loacation: string = '西长安街与书香路交汇处'
  shop_product: ProductData[] = []
  shop_appraise: ShopAppraise[] = [new ShopAppraise()]
  shop_phone: string = '133999999'
}


export class ShopAppraise {
  id: number
  user_name: string
  user_picture: ResourceStr
  user_rating: number
  user_content: string
  user_content_picture?: ResourceStr[]

  constructor(id: number = 1000, user_name: string = '嘻嘻学啥呢', user_picture: ResourceStr = $r('app.media.shopPicture'), user_rating: number = 4, user_content: string = '非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满') {
    this.id = id
    this.user_name = user_name
    this.user_picture = user_picture
    this.user_rating = user_rating
    this.user_content = user_content
    // this.user_content_picture = user_content_picture
  }
}