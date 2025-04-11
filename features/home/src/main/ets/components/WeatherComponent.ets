import { UserData } from "datastore"
import { WeatherResponse } from "utils"
import { ComposeListItem } from "@ohos.arkui.advanced.ComposeListItem"

@Preview
@Component
export struct WeatherComponent {
  @Prop nowWeatherData: WeatherResponse
  @Prop userData: UserData
  build() {
    Column() {
      Row(){
        Column(){
          Text(this.userData.community)
            .fontSize(20)
            .margin({bottom: 5})
            .fontColor(Color.Black)

          Row(){
            Text(this.nowWeatherData.now.text)
              .fontSize(15)
              .margin({right: 10})
              .fontColor(Color.Black)

            Text('体感 ' + this.nowWeatherData.now.feelsLike + '℃')
              .fontSize(15)
              .fontColor(Color.Black)
          }
        }
        .margin({left: 15})
        .alignItems(HorizontalAlign.Start)

        Image($r(`app.media.${this.nowWeatherData.now.icon}`))
          .height(50)
          .width(50)

        Text(this.nowWeatherData.now.temp + '℃')
          .fontSize(30)
          .margin({right: 15})
          .fontColor(Color.Black)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')


      Row() {
        Column() {
          Text('风向： ' + this.nowWeatherData.now.windDir)
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ left: 10 })
          Text('风速： ' + this.nowWeatherData.now.windSpeed)
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ left: 10 })
          Text('相对湿度： ' + this.nowWeatherData.now.humidity + '%')
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ left: 10 })
        }
        .width('40%')
        Column() {
          Text('过去1小时降水量： ' + this.nowWeatherData.now.precip + 'mm')
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ right: 10 })
          Text('压强： ' + this.nowWeatherData.now.pressure  + '00Pa')
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ right: 10 })
          Text('能见度： ' + this.nowWeatherData.now.humidity + 'km')
            .width('100%')
            .margin({ bottom: 5 })
            .fontColor(Color.Black)
            .padding({ right: 10 })
        }
        .width('60%')
      }
      .margin({ bottom: 20 })
      .width('100%')

    }
    .padding({ top: 20 })
    .height('100%')
    .width("100%")
    .borderRadius(10)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .linearGradient({
      direction: GradientDirection.LeftBottom, // 渐变方向
      repeating: true, // 渐变颜色是否重复
      colors: [[0xfbc2eb, 0.0], [0xa6c1ee, 1.0]] // 数组末尾元素占比小于1时满足重复着色效果
    })
  }
}