import { ProductData } from 'uicomponents'
import { ProductSelection } from 'uicomponents/src/main/ets/model/ProductModel'

@Component
export struct ShopCarListItem {
  @Prop data : ProductData
  @Link@Watch('isSelection') productSelectionMap: Map<string, ProductSelection>
  onDeleteData: (id: string) => void = () => {
  }
  onSelectionChange: ( id: string, isSelection: boolean ) => void = () => {
  }
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {

        this.dialogController.close()
      },
      confirm: () => {
        // 确认时提交修改
        this.productSelectionMap.delete(this.data.id.toString())
        this.onDeleteData(this.data.id.toString())
        this.dialogController.close()
      }
    }),
    autoCancel: true
  })


  // 计算当前选中状态（实时从 Map 获取）
   isSelection(): boolean {
    return this.productSelectionMap.get(this.data.id.toString())?.ischoose || false;
  }

  // Checkbox 的 onChange 事件
  onCheckboxChange(checked: boolean) {
    this.onSelectionChange(this.data.id.toString(), checked);
  }

  build() {
    Column() {
      Row() {
        Checkbox()
          .select(this.isSelection())
          .margin({ right: 10 })
          .onChange((checked) => {
            this.onCheckboxChange(checked);
          })

        Image(this.data.product_picture)
          .size({
            height: 70,
            width: 70
          })
          .margin({ right: 30 })

        this.ProductInfo(this.data.product_name, this.data.product_price, this.data.product_unit, this.data.product_capacity, this.data.product_capacity_unit)

      }
      .width('100%')
      .margin({ top: 20, bottom: 20 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceAround)
    }
    .height(110)
    .width('100%')
  }

  @Builder
  ProductInfo(product_name: string, product_price: string, product_unit: string, product_capacity: string, product_capacity_unit: string) {
    Column(){
      Row() {
        Text(product_name) // 添加空格分隔
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .flexShrink(1)

        Text(product_capacity + product_capacity_unit)
          .fontWeight(FontWeight.Bold)
          .fontSize(13)
          .flexShrink(0) // 禁止容量部分被截断
      }
      .width('100%')
      .alignItems(VerticalAlign.Bottom) // 顶部对齐
      .justifyContent(FlexAlign.Start) // 确保内容从行首开始排列

      Row() {
        //价格区域
        Row() {
          Text('￥')
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(15)
          Text(product_price)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffd2626')
            .fontSize(20)
          Text('/' + product_unit)
            .fontWeight(FontWeight.Medium)
            .fontSize(10)
            .fontColor(Color.Gray)
        }
        .width('35%')
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.Start)

        Row() {
          Text('-')
            .width(20)
            .fontSize(15)
            .height(18)
            .borderRadius(16)
            .backgroundColor('#f5f5f5')
            .fontColor('#666')
            .borderColor('#e0e0e0')
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })
            .onClick(() => {
              const currentNumber = this.productSelectionMap.get(this.data.id.toString())?.number || 0;
              if (currentNumber > 0) {
                const newNumber = currentNumber - 1;
                if (newNumber === 0) {
                  this.dialogController.open();
                } else {
                  // 更新Map中的数量
                  this.updateNumberInMap(newNumber);
                }
              }
            })

          Text((this.productSelectionMap.get(this.data.id.toString())?.number || 0).toString())
            .width(20)
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })


          Text('+')
            .width(20)
            .fontSize(15)
            .height(18)
            .borderRadius(16)
            .backgroundColor('#ff22c1ff')
            .fontColor('#ffffffff')
            .borderColor('#e0e0e0')
            .textAlign(TextAlign.Center)
            .margin({ right: 10 })
            .onClick(() =>{
              const currentNumber = this.productSelectionMap.get(this.data.id.toString())?.number || 0;
              const newNumber = currentNumber + 1;

              // 更新Map中的数量
              this.updateNumberInMap(newNumber);
            })

        }
        .alignItems(VerticalAlign.Center)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
    }
    .width('55%')
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  private updateNumberInMap(newNumber: number) {
    // 创建新Map保证状态更新
    const newMap = new Map(this.productSelectionMap);
    const existing = newMap.get(this.data.id.toString());

    if (existing) {
      // 保留选中状态，仅修改数量
      newMap.set(this.data.id.toString(), {
        ischoose: existing.ischoose,
        number: newNumber
      });
    } else {
      // 初始化条目（如果不存在）
      newMap.set(this.data.id.toString(), {
        ischoose: false,
        number: newNumber
      });
    }

    // 更新Link变量触发渲染
    this.productSelectionMap = newMap;

    // 通知父组件（保持接口兼容性）

  }
}

@CustomDialog
struct CustomDialogExample {
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('温馨提示')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 5 })
      Text('确定删除该商品?')
        .fontSize(14)
        .margin({ top: 20, bottom: 20 })
      Row() {
        Button('取消')
          .onClick(() => {
            this.controller?.close()
            this.cancel()
          })
          .margin({ right: 20 })
          .width(120)
          .fontSize(15)
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            this.controller?.close()
            this.confirm()
          })
          .width(120)
          .fontSize(15)
          .backgroundColor("#ff22c1ff")
      }
      .margin({ bottom: 20 })
    }
  }
}