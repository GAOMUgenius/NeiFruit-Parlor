import { UserData } from "datastore"
import { changeIcon, WeatherResponse } from "utils"
import { ComposeListItem } from "@ohos.arkui.advanced.ComposeListItem"

@Preview
@Component
export struct WeatherComponent {
  @Prop nowWeatherData: WeatherResponse
  @Prop userData: UserData
  build() {
    Column() {
      Row(){
        Image($r(`app.media.${changeIcon(this.nowWeatherData.now.icon)}`))
          .height(130)
          .width(130)
          .margin({ left: 20 })

        Column() {
          Text(changeIcon(this.nowWeatherData.now.icon).replace(/_/g, ''))
            .fontColor(Color.White)
            .fontSize(20)
            .margin({ top: 20, left: 20 })

          Row() {
            Text(this.nowWeatherData.now.temp)
              .fontSize(80)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('°')
              .fontSize(50)
              .fontColor(Color.White)
              .margin({ top: 10 })
          }
          .margin({ left: 20 })
          .alignItems(VerticalAlign.Top)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .width('100%')

      Line()
        .width('70%')
        .height(0.5)
        .backgroundColor('#00eeecec')

      Row() {
        Column() {
            Image($r('app.media.wind'))
              .size({
                width: 30,
                height: 30
              })
              .margin({ bottom: 5 })
            Text(this.nowWeatherData.now.windSpeed + ' km/h')
              .fontColor(Color.White)
              .margin({ bottom: 5 })
              .fontSize(18)
            Text('WindSpeed')
              .fontSize(15)
              .fontColor(Color.Gray)
        }
        Column() {
          Image($r('app.media.vis'))
            .size({
              width: 42,
              height: 30
            })
            .margin({ bottom: 5 })
          Text(this.nowWeatherData.now.vis + ' km')
            .fontColor(Color.White)
            .margin({ bottom: 5 })
            .fontSize(18)
          Text('Vis')
            .fontSize(15)
            .fontColor(Color.Gray)
        }
        Column() {
          Image($r('app.media.humidity'))
            .size({
              width: 30,
              height: 30
            })
            .margin({ bottom: 5 })
          Text(this.nowWeatherData.now.humidity + '%')
            .fontColor(Color.White)
            .margin({ bottom: 5 })
            .fontSize(18)
          Text('Humidity')
            .fontSize(15)
            .fontColor(Color.Gray)
        }
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 20 })
      .width('100%')

    }
    .height('100%')
    .width("100%")
    .borderRadius(50)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      direction: GradientDirection.LeftBottom, // 渐变方向
      repeating: true, // 渐变颜色是否重复
      colors: [[0x434343, 0.0], [0x000000, 1.0]] // 数组末尾元素占比小于1时满足重复着色效果
    })
  }
}