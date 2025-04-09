import { CategoryTabs } from "../view/CategoryTab"
import { PreferenceConstant, UserData } from "datastore"
import { fetchWeatherData, WeatherResponse } from "utils"
import { WeatherComponent } from "../components/WeatherComponent"
import { promptAction } from "@kit.ArkUI"
import { VoIPExtensionContext } from "@kit.PushKit"
import { CommunityAnnouncementComponent } from "../components/CommunityAnnouncementComponent"


@Component
export struct HomePageStruct {
  @State scrollOffset: number = 0
  @State searchBarOpacity: number = 1
  @State userData: UserData | undefined = AppStorage.get(PreferenceConstant.USER_DATA)
  @Prop nowWeatherData: WeatherResponse | null
  @Prop locationError: boolean
  // @Prop onRetry?: () => void


  @Builder
  getLoadingState() {
    if (this.locationError) {
      ErrorComponent({ retryAction: (): void => this.retryFetch() })
    } else {
      LoadingComponent()
    }
  }

  retryFetch() {
    // 可以通过事件通知父组件重新获取
    // this.onRetry?.()
  }

  build() {
    Navigation() {
      Stack() {
        Scroll(){
          //页面主体内容
          Column() {
            Swiper() {
              if (this.nowWeatherData) {
                WeatherComponent({ nowWeatherData: this.nowWeatherData, userData: this.userData })
                CommunityAnnouncementComponent()
              } else {
                this.getLoadingState()
              }
            }
            .margin({ top: 80 })
            .width('100%')
            .height(200)
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

// components/LoadingComponent.ets
@Component
struct LoadingComponent {
  build() {
    Column() {
      Progress({ value: 200 })
        .width(50)
        .height(50)
      Text('正在获取天气数据...')
        .margin({ top: 10 })
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
  }
}

// components/ErrorComponent.ets
@Component
struct ErrorComponent {
  @Prop retryAction: () => void

  build() {
    Column() {
      // Image($r('app.media.ic_error'))
      //   .width(80)
      //   .height(80)
      Text('数据加载失败')
        .margin({ top: 10 })
      Button('重试', { type: ButtonType.Capsule })
        .margin({ top: 20 })
        .onClick(() => this.retryAction())
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
  }
}