// 新增的星星评分组件
@Component
export struct StarRating {
  @Prop rating: number // 接收评分值
  private starItems: number[] = [0, 1, 2, 3, 4]

  build() {
    Row() {
      ForEach(this.starItems, (index: number) => {
        Image(this.getStarImage(index))
          .width(15)
          .height(15)
          .margin({ right: 8 })
      })
    }
    .padding(5)
  }

  // 根据索引判断星星颜色
  private getStarImage(index: number): Resource {
    const validNum = Math.min(5, Math.max(0, this.rating))
    return index < validNum ? $r('app.media.star_yellow') : $r('app.media.star_gray')
  }
}