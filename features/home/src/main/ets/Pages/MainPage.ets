import { HomePageSwiperResource } from "../model/HomePageSwiperResource"
import { CategoryTabs } from "../view/CategoryTab"


@Component
export struct HomePageStruct {
  @State scrollOffset: number = 0
  @State searchBarOpacity: number = 1

  build() {
    Navigation() {
      Stack() {
        Scroll(){
          //页面主体内容
          Column() {
            Column(){
              Swiper() {
                ForEach(HomePageSwiperResource, (item: ResourceStr) => {
                  Image(item)
                    .size({
                      width: '100%',
                      height: '100%'
                    })
                    .objectFit(ImageFit.Cover)
                }, (item: ResourceStr) => item.toString())
              }
            }
            .margin({ top: 60 })
            .width('100%')
            .height('30%')
            .backgroundColor(Color.White)

            CategoryTabs()
          }
          .width('100%')
        }
        .width('100%')

        this.BuildFixedSearchBar()
      }
    }
  }

  @Builder
  BuildFixedSearchBar() {
    Column() {
      Search({ placeholder: '请输入搜索内容' })
        .width('90%')
        .height(40)
        .backgroundColor(Color.White)
        .padding(8)
        .borderRadius(20)
        .shadow({
          radius: 4,
          color: '#1A000000',
          offsetX: 1,
          offsetY: 1
        })
        .searchButton('搜索', { fontColor: ''})
    }
    .width('100%')
    .padding(10)
    .backgroundColor('#F5F5F5')
    .position({ x: 0, y: 0 }) // 固定定位在顶部
    .zIndex(999) // 确保在最顶层
    .opacity(this.searchBarOpacity)
  }
}