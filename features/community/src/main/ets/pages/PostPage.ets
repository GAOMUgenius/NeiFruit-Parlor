import { BuilderNameConstants, RouterModule } from "routermodule";
import { CommonUtil } from "utils";
import { LengthMetrics } from "@kit.ArkUI";
import { PostInfoView } from "../views/PostInfoView";
import { PostModel } from "../model/PostModel";
import { PostAppraiseView } from "../views/PostAppraiseView";
import { AppraiseData, AppraiseDataSource } from "uicomponents";
import { PreferenceConstant, UserData } from "datastore";
import { PostDataSource } from "../model/PostDataResource";

@Component
struct PostPageStruct {
  @Prop postInfo: PostModel
  @State commentText: string = ''
  @State isPublishShow: boolean = false
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData = AppStorage.get(PreferenceConstant.USER_DATA)!
  @StorageLink(PreferenceConstant.POST_APPRAISE_LIST) postAppraiseData: AppraiseDataSource = AppStorage.get(PreferenceConstant.POST_APPRAISE_LIST)!
  @StorageLink(PreferenceConstant.POST_LIST) postListData: PostDataSource = AppStorage.get(PreferenceConstant.POST_LIST)!

  private publishAppraise() {
    const newAppraise = new AppraiseData(
      Date.now(), // 使用时间戳作为唯一ID
      this.postInfo.post_id,
      this.userData.username,
      this.userData.user_picture,
      5, // 默认评分
      this.commentText,
      // this.selectedImages
    )
    // 更新数据源
    this.postAppraiseData.pushDataItem(newAppraise)

    // 清空输入
    this.commentText = ''
    // this.selectedImages = []

    // 更新评论数
    const newAppraiseNumber = this.postInfo.post_appraise_number + 1
    const index = this.postListData.findIndex(item => item.post_id === this.postInfo.post_id);
    if (index === -1) return;
    // 获取原数据
    const originalData = this.postListData.getData(index);

    // 创建新数据对象
    const newData = new PostModel(
      originalData.post_id,
      originalData.user_id,
      originalData.user_picture,
      originalData.user_name,
      originalData.user_community,
      newAppraiseNumber,
      originalData.post_likes_number, // 更新点赞数
      originalData.post_title,
      originalData.post_content,
      originalData.post_content_picture
    );

    // 调用数据源方法更新
    this.postInfo = newData
    this.postListData.changeData(index, newData);
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        PostTab({ postinfo: this.postInfo })
          .margin({ bottom: 70 })

        Row() {
          Text('参与评论')
            .backgroundColor('#ffefefef')
            .margin({ left: 10 })
            .width('60%')
            .height(30)
            .padding({ left: 20 })
            .fontSize(13)
            .fontColor(Color.Gray)
            .borderRadius(8)
              // 通过选定的半模态接口，绑定模态展示界面，style中包含两个参数，一个是设置半模态的高度，不设置时默认高度是Large，一个是是否显示控制条DragBar，默认是true显示控制条，通过onDisappear控制状态变量变换。
            .bindSheet(this.isPublishShow, this.inputAppraise(), {
              height: 300,
              dragBar: false,
              onDisappear: () => {
                this.isPublishShow = false;
              }
            })
            .onClick(() => {
              this.isPublishShow = !this.isPublishShow;
            })

          Column() {
            Image($r('app.media.community_likes_off_icon'))
              .size({
                width: 18,
                height: 18
              })
            Text(this.postInfo.post_likes_number.toString())
              .fontSize(10)
              .fontColor(Color.Gray)
              .fontWeight(FontWeight.Regular)
          }
          .margin({ left: 40 })

          Column() {
            Image($r('app.media.community_appraise_icon'))
              .size({
                width: 18,
                height: 18
              })
            Text(this.postInfo.post_appraise_number.toString())
              .fontSize(10)
              .fontColor(Color.Gray)
              .fontWeight(FontWeight.Regular)
          }
          .margin({ left: 20 })
        }
        .backgroundColor(Color.White)
          .width('100%')
          .height(60)

      }
      .width('100%')
      .height('100%')
    }
  }
  @Builder
  inputAppraise() {
    // 评论输入区域
    Row() {
      TextArea({ text: this.commentText, placeholder: '说点什么...' })
        .height('auto')
        .padding(8)
        .backgroundColor('#fff')
        .borderRadius(8)
        .width('60%')
        .onChange((value) => {
          this.commentText = value
        })

      Button('发布')
        .width(60)
        .height(30)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          this.publishAppraise()
          this.isPublishShow = !this.isPublishShow
        })
        .margin({ top: 10 })
    }
    .alignItems(VerticalAlign.Top)
    .padding(8)
    .backgroundColor('#f5f5f5')
    .width('100%')
  }
}

@Component
struct PostTab {
  @Prop postinfo: PostModel
  @State tabArray: string[]  = ['正文', '评论']
  @State currentIndex: number = 0
  @State animationDuration: number = 300
  @State indicatorLeftMargin: number = 0
  @State indicatorWidth: number = 0
  private tabsWidth: number = 0
  private textInfos: [number, number][] = [[0, 0], [0, 0]]
  private isStartAnimateTo: boolean = false



  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 内容区域
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          PostInfoView({ postInfo: this.postinfo })
        }
        .tabBar(this.tabBuilder(0, this.tabArray[0]))
        TabContent() {
          PostAppraiseView({ postId: this.postinfo.post_id })
        }
        .tabBar(this.tabBuilder(1, this.tabArray[1]))
      }
      .barHeight(50)
      .width('100%')
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
}

@Builder
export function PostPage(value: object) {
  PostPageStruct({ postInfo: JSON.parse(JSON.stringify(value)) })
}

const builderName = BuilderNameConstants.COMMUNITY_POSTPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PostPage);
  RouterModule.registerBuilder(builderName, builder);
}