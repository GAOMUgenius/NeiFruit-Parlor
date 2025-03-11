import { ProductData, ProductDataSource } from 'uicomponents'

const shopCarInfo: ProductData[] = [
  {
    id: '1',
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    id: '1',
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    id: '1',
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    id: '1',
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  }
]

export const shopCarListDataSource = new ProductDataSource(shopCarInfo)