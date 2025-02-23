

@Component
export struct HomePageStruct {

  build() {
    Navigation() {
      Row() {
        Text('这里是首页')
      }
      .width('100%')
      .height('100%')
    }
  }
}