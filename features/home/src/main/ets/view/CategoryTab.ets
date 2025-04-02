import { CommonUtil } from "utils";
import { ShopItemContent } from "../components/ShopItemConent";
import { CategoryType } from "../model/CategoriesModel";
import { LengthMetrics } from "@kit.ArkUI";

// 在父组件中管理状态
@Component
export struct CategoryTabs {
  @State colorArray: [string, CategoryType][] =
    [['热门', CategoryType.HOST], ['生鲜', CategoryType.FRESH], ['餐饮', CategoryType.CATERING], ['景点', CategoryType.SCENIC]]
  @State currentIndex: CategoryType = CategoryType.HOST
  @State animationDuration: number = 300
  @State indicatorLeftMargin: number = 0
  @State indicatorWidth: number = 0
  private tabsWidth: number = 0
  private textInfos: [number, number][] = []
  private isStartAnimateTo: boolean = false
  aboutToAppear():void {
    for (let i = 0; i < this.colorArray.length; i++) {
      this.textInfos.push([0, 0]);
    }
  }

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#182431')
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .id(index.toString())
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.textInfos[index] = [newValue.globalPosition.x as number, newValue.width as number]
          if (!this.isStartAnimateTo && this.currentIndex === index && this.tabsWidth > 0) {
            this.setIndicatorAttr(this.textInfos[this.currentIndex][0], this.textInfos[this.currentIndex][1])
          }
        })
    }.width('100%')
  }

  build() {
      Stack({ alignContent: Alignment.TopStart }) {
        // 内容区域
        Tabs({ barPosition: BarPosition.Start }) {
          ForEach(this.colorArray, (item: [string, CategoryType], index:number) => {
            TabContent() {
              this.BuildContent(item[1])
            }
            .tabBar(this.tabBuilder(index, item[0]))
          }, (item: [string, CategoryType]) => item[1].toString())
        }
        .margin({ left: '5%' })
        .barHeight(50)
        .width('90%')
        .height('auto')//设置高度为自定义，避免高度计算错误
        .animationDuration(this.animationDuration)
        .onAreaChange((oldValue: Area, newValue: Area)=> {
          this.tabsWidth = newValue.width as number
          if (!this.isStartAnimateTo) {
            this.setIndicatorAttr(this.textInfos[this.currentIndex][0], this.textInfos[this.currentIndex][1])
          }
        })
        .onChange((index: number) => {
          this.currentIndex = index // 监听索引index的变化，实现页签内容的切换。
        })
        .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
          // 切换动画开始时触发该回调。下划线跟着页面一起滑动，同时宽度渐变。
          this.currentIndex = targetIndex
          this.startAnimateTo(this.animationDuration, this.textInfos[targetIndex][0], this.textInfos[targetIndex][1])
        })
        .onAnimationEnd((index: number, event: TabsAnimationEvent) => {
          // 切换动画结束时触发该回调。下划线动画停止。
          let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
          this.startAnimateTo(0, currentIndicatorInfo.left, currentIndicatorInfo.width)
        })
        .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
          // 在页面跟手滑动过程中，逐帧触发该回调。
          let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
          this.currentIndex = currentIndicatorInfo.index
          this.setIndicatorAttr(currentIndicatorInfo.left, currentIndicatorInfo.width)
        })


        Column()
          .height(2)
          .width(this.indicatorWidth)
          .margin({ start: LengthMetrics.vp(this.indicatorLeftMargin), top: LengthMetrics.vp(48) })
          .backgroundColor('#007DFF')
      }
      // .alignContent(Alignment.Top)
      .width('100%')
  }

  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index
    if (index > 0 && (CommonUtil.getIsRTL() ? event.currentOffset < 0 : event.currentOffset > 0)) {
      nextIndex--
    } else if (index < this.textInfos.length - 1 &&
      (CommonUtil.getIsRTL() ? event.currentOffset > 0 : event.currentOffset < 0)) {
      nextIndex++
    }
    let indexInfo = this.textInfos[index]
    let nextIndexInfo = this.textInfos[nextIndex]
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth)
    let currentIndex = swipeRatio > 0.5 ? nextIndex : index // 页面滑动超过一半，tabBar切换到下一页。
    let currentLeft = indexInfo[0] + (nextIndexInfo[0] - indexInfo[0]) * swipeRatio
    let currentWidth = indexInfo[1] + (nextIndexInfo[1] - indexInfo[1]) * swipeRatio
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth }
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    this.isStartAnimateTo = true
    animateTo({
      duration: duration, // 动画时长
      curve: Curve.Linear, // 动画曲线
      iterations: 1, // 播放次数
      playMode: PlayMode.Normal, // 动画模式
      onFinish: () => {
        this.isStartAnimateTo = false
        console.info('play end')
      }
    }, () => {
      this.setIndicatorAttr(leftMargin, width)
    })
  }

  private setIndicatorAttr(leftMargin: number, width: number) {
    this.indicatorWidth = width
    if (CommonUtil.getIsRTL()) {
      this.indicatorLeftMargin = this.tabsWidth - leftMargin - width
    } else {
      this.indicatorLeftMargin = leftMargin
    }
  }

  @Builder
  BuildContent(categoryType: CategoryType) {
    ShopItemContent({ categoryType: categoryType})
  }
}