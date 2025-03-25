export class ProductInfoParameter {
  productinfo_storage: string //存储条件
  productinfo_reason: string //推荐理由
  productinfo_advantage: string //商品优势
  productinfo_brand: string //商品品牌
  productinfo_origin: string //产地
  product_raw_material: string;
  productinfo_picture: ResourceStr[];
  productinfo_video: ResourceStr;
  productinfo_name: string;
  productinfo_price: string;
  productinfo_unit: string;
  productinfo_capacity: string; //净含量
  productinfo_capacity_unit: string; //单位
  productinfo_introduce: string;

  constructor(
    productinfo_storage: string,
    productinfo_reason: string,
    productinfo_advantage: string,
    productinfo_brand: string,
    productinfo_origin: string,
   product_raw_material: string,
    productinfo_picture: ResourceStr[],
    productinfo_video: string,
    productinfo_name: string,
    productinfo_price: string,
    productinfo_unit: string,
    productinfo_capacity: string,
    productinfo_capacity_unit: string,
    productinfo_introduce: string
  ) {
    this.productinfo_storage = productinfo_storage;
    this.productinfo_reason = productinfo_reason;
    this.productinfo_advantage = productinfo_advantage;
    this.productinfo_brand = productinfo_brand;
    this.productinfo_origin = productinfo_origin;
    this.productinfo_picture = productinfo_picture;
    this.productinfo_video = productinfo_video;
    this.productinfo_name = productinfo_name;
    this.productinfo_price = productinfo_price;
    this.productinfo_unit = productinfo_unit;
    this.productinfo_capacity = productinfo_capacity;
    this.productinfo_capacity_unit = productinfo_capacity_unit;
    this.productinfo_introduce = productinfo_introduce
    this.product_raw_material = product_raw_material
  }
}

export const productInfoParameter: ProductInfoParameter = new ProductInfoParameter(
  '冷冻',
  '鲜甜Q弹',
  '深海捕捞',
  '深海牌',
  '产地',
  '小龙虾，蒜蓉味',
  [
    $r('app.media.productinfo_picture_1'),
    $r('app.media.productinfo_picture_2'),
    $r('app.media.productinfo_picture_3'),
    $r('app.media.productinfo_picture_4'),
    $r('app.media.productinfo_picture_5'),
  ],
  '',
  '小龙虾神仙桶',
  '99',
  '份',
  '1.5',
  'kg',
  '洪湖鲜活好虾，清水养殖，三挑三选成就三白好虾;秘制蒜蓉酱，虾肉紧实回甘，汤汁拌饭拌面都好吃'
)

export class SellingPointInfoList {
  sellingPoint: string
  sellingTitle: string

  constructor(sellingPoint: string, sellingTitle: string) {
    this.sellingPoint = sellingPoint;
    this.sellingTitle = sellingTitle
  }
}

