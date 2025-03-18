
import { ProductDataSource } from "./ProductDataSource"


@Observed
export class ProductData {
  @Track product_id: string = '0'
  @Track product_picture: ResourceStr = ''
  product_name: string = ''
  product_price: string = ''
  product_unit: string = ''
  product_capacity: string = ''
  product_capacity_unit: string= ''
  // @Track product_ischoose: boolean = false
  @Track product_number: number = 1

  constructor(
    product_id: string,
    product_picture: ResourceStr,
    product_name: string,
    product_price: string,
    product_unit: string,
    product_capacity: string,
    product_capacity_unit: string,
    // product_ischoose: boolean = false,
    product_number: number = 1
  ) {
    this.product_id = product_id;
    this.product_picture = product_picture;
    this.product_name = product_name;
    this.product_price = product_price;
    this.product_unit = product_unit;
    this.product_capacity = product_capacity
    this.product_capacity_unit = product_capacity_unit;
    // this.product_ischoose = product_ischoose;
    this.product_number = product_number
  }
}

export const ProductData_List: ProductData[] = [
  new ProductData(
     '1',
     $r('app.media.OIP'),
    "有机小米1 ",
    "78.5",
    "袋",
     "1.8",
     "kg",
     0
  ),
  new ProductData(
    '2',
    $r('app.media.OIP'),
    "有机小米2 ",
    "78.5",
    "袋",
    "1.8",
    "kg",
    0
  ),
  new ProductData(
    '3',
    $r('app.media.OIP'),
    "有机小米3 ",
    "78.5",
    "袋",
    "1.8",
    "kg",
    0
  ),
  new ProductData(
    '4',
    $r('app.media.OIP'),
    "有机小米4 ",
    "78.5",
    "袋",
    "1.8",
    "kg",
    0
  ),
]
