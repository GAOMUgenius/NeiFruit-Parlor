
@Observed
export class ProductData {
  @Track id: number
  @Track product_picture: ResourceStr
  @Track product_name: string
  @Track product_price: string
  @Track product_unit: string
  @Track product_capacity: string
  @Track product_capacity_unit: string

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
    7,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/bc84386c760f07ed22bc947fa33d478.png',
    "罗马生菜 ",
    "4.98",
    "份",
    "400",
    "g",
    // 0
  ),
  new ProductData(
    8,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/474a62ae815919ed02e04cc1b0de4c9.png',
    '小龙虾神仙桶 ',
    '99',
    '份',
    '1.5',
    'kg',
  ),
  new ProductData(
    9,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/239941b3884b676ede55eac295a04fa.png',
    '提拉米苏蛋糕 ',
    '59.9',
    '个',
    '1',
    'kg',
  ),
  new ProductData(
    10,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8f3744b5bff6852555d09bfc7a6529b.png',
    '炫彩什锦寿司组合 ',
    '17.9',
    '盒',
    '365',
    'g',
  ),
  new ProductData(
    11,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2633341b834f1846a0ed89d8f5da816.png',
    '生菜玉米蔬菜沙拉 ',
    '9.9',
    '盒',
    '180',
    'g',
  ),
  new ProductData(
    12,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/03a6b462492437a87456bad28a08b81.png',
    '谷饲原切牛腩块 ',
    '45.9',
    '袋',
    '1',
    'kg',
  ),
  new ProductData(
    13,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/85571c602b94f9c8fbd321765bd7420.png',
    '国产沃柑 ',
    '9.9',
    '盒',
    '900',
    'g',
  ),
  new ProductData(
    14,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/390108ae1fbfe45d6d48f2635150919.png',
    '【鲜果切】酸嘢双拼(芭乐+青芒果) ',
    '19.9',
    '盒',
    '300',
    'g',
  ),
  new ProductData(
    15,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/2c66b6ddf42d30e73f3ca4962fdd9cd.png',
    '鲜活 精养虎背鲈鱼 ',
    '19.9',
    '条',
    '400 - 500',
    'g/条',
  ),
  new ProductData(
    16,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/ba10c3138e090f0da93c7cec0acd2f1.png',
    '青柠芝士 ',
    '29.9',
    '盒',
    '330',
    '4粒',
  ),
]

export interface ProductSelection {
  ischoose: boolean;
  number: number
}
