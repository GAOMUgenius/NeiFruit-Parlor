//包装数组符合IDataSource接口的数据源
class ProductDataSource implements IDataSource {
  private dataList: ProductData[];

  constructor(data: ProductData[]) {
    this.dataList = data;
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): ProductData {
    return this.dataList[index];
  }

  public registerDataChangeListener(listener: DataChangeListener): void {
    // 监听数据变化（按需实现，如保存listener）
  }

  public unregisterDataChangeListener(listener: DataChangeListener): void {
    // 移除监听器（按需实现）
  }
}

export interface ProductData {
  product_picture: ResourceStr,
  product_name: string,
  product_price: string,
  product_unit: string,
  product_capacity: string,
  product_capacity_unit: string
}

export const ProductData_List: ProductData[] = [
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
  product_picture: $r('app.media.OIP'),
  product_name: "有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米有机小米",
  product_price: "78.5",
  product_unit: "袋",
  product_capacity: "1.8",
  product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
  {
    product_picture: $r('app.media.OIP'),
    product_name: "有机小米",
    product_price: "78.5",
    product_unit: "袋",
    product_capacity: "1.8",
    product_capacity_unit: "kg",
  },
]

export const productDataSource = new ProductDataSource(ProductData_List)