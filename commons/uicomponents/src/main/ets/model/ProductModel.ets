
import { ProductDataSource } from "./ProductDataSource"


@Observed
export class ProductData {
  @Track id: number = 0
  @Track product_picture: ResourceStr = ''
  product_name: string = ''
  product_price: string = ''
  product_unit: string = ''
  product_capacity: string = ''
  product_capacity_unit: string= ''

  constructor(
    id: number,
    product_picture: ResourceStr,
    product_name: string,
    product_price: string,
    product_unit: string,
    product_capacity: string,
    product_capacity_unit: string,
  ) {
    this.id = id;
    this.product_picture = product_picture;
    this.product_name = product_name;
    this.product_price = product_price;
    this.product_unit = product_unit;
    this.product_capacity = product_capacity
    this.product_capacity_unit = product_capacity_unit;
  }
}

export const ProductData_List: ProductData[] = [
  new ProductData(
    1,
    $r('app.media.ProductDataPicture5'),
    "泰国金枕头冷冻榴莲肉 ",
    "45.9",
    "盒",
    "300",
    "g/盒",
    // 0
  ),
  new ProductData(
    2,
    $r('app.media.ProdcutDataPicture6'),
    "智利西梅 ",
    "16.9",
    "盒",
    "350",
    "g/盒",
    // 0
  ),
  new ProductData(
     5,
     $r('app.media.ProductDataPicture1'),
    "龙井冰皮绿豆糕 ",
    "15.9",
    "盒",
     "12",
     "粒",
     // 0
  ),
  new ProductData(
    6,
    $r('app.media.ProductDataPicture2'),
    "蒙牛 特仑苏 纯牛奶 ",
    "39.9",
    "箱",
    "250",
    "ml*12",
    // 0
  ),
  new ProductData(
    3,
    $r('app.media.ProductDataPitcure3'),
    "埃及红西柚 两粒装 ",
    "14.9",
    "盒",
    "290",
    "g+",
    // 0
  ),
  new ProductData(
    4,
    $r('app.media.ProductDataPicture4'),
    "云南超大蓝莓 ",
    "16.9",
    "盒",
    "125",
    "g",
    // 0
  )
]

export interface ProductSelection {
  ischoose: boolean;
  number: number
}
