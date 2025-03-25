import { ProductData } from "uicomponents"
@Observed
export class ProductInfoParameter extends ProductData {
  @Track productinfo_storage: string //存储条件
  @Track productinfo_reason: string //推荐理由
  @Track productinfo_advantage: string //商品优势
  @Track productinfo_brand: string //商品品牌
  @Track productinfo_origin: string //产地
  @Track product_raw_material: string;
  @Track productinfo_picture: ResourceStr[];
  @Track productinfo_introduce: string;

  constructor(
    id: number,
    product_picture: ResourceStr,
    product_name: string,
    product_price: string,
    product_unit: string,
    product_capacity: string,
    product_capacity_unit: string,
    productinfo_storage: string,
    productinfo_reason: string,
    productinfo_advantage: string,
    productinfo_brand: string,
    productinfo_origin: string,
    product_raw_material: string,
    productinfo_picture: ResourceStr[],
    productinfo_introduce: string
  ) {
    super(id,
      product_picture,
      product_name,
      product_price,
      product_unit,
      product_capacity,
      product_capacity_unit)
    this.productinfo_storage = productinfo_storage;
    this.productinfo_reason = productinfo_reason;
    this.productinfo_advantage = productinfo_advantage;
    this.productinfo_brand = productinfo_brand;
    this.productinfo_origin = productinfo_origin;
    this.productinfo_picture = productinfo_picture;
    this.product_raw_material = product_raw_material;
    this.productinfo_introduce = productinfo_introduce
  }
}

export const productInfoParameter: ProductInfoParameter = new ProductInfoParameter(
  1,
  $r('app.media.productinfo_picture_1'),
  '小龙虾神仙桶',
  '99',
  '份',
  '1.5',
  'kg',
  '冷冻',
  '小龙虾，蒜蓉味',
  '鲜甜Q弹',
  '深海捕捞',
  '深海牌',
  '产地',
  [
    $r('app.media.productinfo_picture_1'),
    $r('app.media.productinfo_picture_2'),
    $r('app.media.productinfo_picture_3'),
    $r('app.media.productinfo_picture_4'),
    $r('app.media.productinfo_picture_5'),
  ],
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

