import { CategoryTabs } from "../view/CategoryTab"


@Component
export struct HomePageStruct {

  build() {
    Navigation() {
      Scroll(){
        Column() {
          Column(){
            Text('首页信息栏')
          }
          .width('100%')
          .height('30%')
          .backgroundColor(Color.White)

          CategoryTabs()
        }
        .width('100%')
      }
      .width('100%')
    }
  }
}