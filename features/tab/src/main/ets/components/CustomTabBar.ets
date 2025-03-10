import { TabBarData, TabBarType, TabsInfo } from "../model/TabBarModel"

@Component
export struct CustomTabBar {
  @Link currentIndex: TabBarType;

  onChange(index: TabBarType): void {
    this.currentIndex = index;
  }

  build() {
    Flex({
      direction: FlexDirection.Row,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.SpaceAround
    }) {
      ForEach(TabsInfo, (item: TabBarData) => {
        TabItem({
          index: item.id,
          selectedIndex: this.currentIndex,
          onChange: (index: number) => this.onChange(index)
        })
      }, (item: TabBarData) => item.id.toString())
    }
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    .backgroundBlurStyle(BlurStyle.NONE)
    .padding({ bottom: 0 })
    .clip(false)
    .height(56)
    .width('100%')
    .border({
      width: { top: 0.5 }
    })
  }
}

@Component
struct TabItem {
  @Prop index: number
  @Prop selectedIndex: number
  @State showAnimation: boolean = false;
  onChange: (index: number) => void = () => {
  };
  build() {
    Column() {
      Image(this.selectedIndex === this.index ? TabsInfo[this.index].activeIcon : TabsInfo[this.index].defaultIcon)
        .size({
          width: 24,
          height: 24
        })
      Text(TabsInfo[this.index].title)
        .fontSize(10)
        .margin({ top: 5 })
        .fontWeight(600)
        .fontColor(this.index === this.selectedIndex ? $r('app.color.tab_title_text_on') : $r('app.color.tab_title_text_off'))

    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .clip(false)
    .padding({ left: 4, right: 4 , top: 5 })
    .layoutWeight(1)
    .size({ width: '100%', height: '100%'})
    .onClick(() => {
      if (this.selectedIndex!==this.index) {
        this.showAnimation = true;
        this.onChange(this.index);
        setTimeout(() => {
          this.showAnimation = false;
        }, 300)
      }
    })
  }
}