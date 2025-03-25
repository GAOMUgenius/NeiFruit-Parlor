export class AppraiseData {
  id: number
  user_name: string
  user_picture: ResourceStr
  user_rating: number
  user_content: string
  user_content_picture?: ResourceStr[]

  constructor(id: number = 1000, user_name: string = '嘻嘻学啥呢', user_picture: ResourceStr = $r('app.media.user_picture1'), user_rating: number = 4, user_content: string = '非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满非常好吃，感觉人生得到了圆满', user_content_picture: ResourceStr[] = [$r('app.media.productinfo_picture_2'), $r('app.media.productinfo_picture_4')]) {
    this.id = id
    this.user_name = user_name
    this.user_picture = user_picture
    this.user_rating = user_rating
    this.user_content = user_content
    // this.user_content_picture = user_content_picture
  }
}