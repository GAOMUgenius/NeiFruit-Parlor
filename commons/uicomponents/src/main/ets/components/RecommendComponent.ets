@Component
export struct RecommendComponent {
  build() {
    Row() {
      Text('- ')
        .fontWeight(FontWeight.Bolder)
        .fontColor(Color.Gray)
      Text('推荐')
        .fontWeight(FontWeight.Bold)
        .fontSize(13)
      Text('·')
        .fontWeight(FontWeight.Bolder)
      Text('RECOMMEND')
        .fontWeight(FontWeight.Bold)
        .fontSize(13)
        .fontColor('#309fff')
      Text(' -')
        .fontWeight(FontWeight.Bolder)
        .fontColor(Color.Gray)
    }
  }
}