import { BasicDataSource } from "datastore";
import { ProductData } from "./ProductModel";

//包装商品信息符合IDataSource接口的数据源
@Observed
export class ProductDataSource extends BasicDataSource {
  @Track dataList: ProductData[] = [];

  public updateItem(newData: ProductData): void {
    const data =  new ProductData(
      newData.id,
      newData.product_picture,
      newData.product_name,
      newData.product_price,
      newData.product_unit,
      newData.product_capacity,
      newData.product_capacity_unit)
    // const index = this.findIndex(newData.product_id)
    // 通过ID查找索引
    const index = this.findIndex((item) => item.id === newData.id);

    if (index !== -1) {
      // 使用已封装的changeData方法进行替换
      this.changeData(index, data);
    }
  }

  // 添加索引查找方法
  findIndex(predicate: (item: ProductData) => boolean): number {
    return this.dataList.findIndex(predicate)
  }

  public totalCount(): number {
    return this.dataList.length;
  }

  public getData(index: number): ProductData {
    return this.dataList[index];
  }
  public addData(index: number, data: ProductData): void {
    this.dataList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushDataList(data: ProductData[]): void {
    this.dataList = this.dataList.concat(data);
    this.notifyDataAdd(this.dataList.length - data.length);
  }

  public pushDataItem(data: ProductData): void {
    this.dataList.push(data);
    this.notifyDataAdd(this.dataList.length - 1);
  }

  public deleteData(index: number): void {
    this.dataList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: ProductData): void {
    this.dataList.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public async refreshData(list: ProductData[]): Promise<void> {
    // 使用更精确的对比方式
    const isChanged = this.dataList.length !== list.length ||
    this.dataList.some((item, index) => !this.isEqual(item, list[index]));

    if (!isChanged) return;

    this.dataList = list.map(item => new ProductData(
      item.id,
      item.product_picture,
      item.product_name,
      item.product_price,
      item.product_unit,
      item.product_capacity,
      item.product_capacity_unit
      )); // 必须创建新对象

    this.notifyDataReload(); // 确保触发刷新
  }

  public reloadData(): void {
    this.notifyDataReload();
  }

  public modifyAllData(changeItem: (item: ProductData) => ProductData): void {
    this.dataList = this.dataList.map((item: ProductData) => {
      return changeItem(item);
    })
  }


  private isEqual(a: ProductData, b: ProductData): boolean {
    return a.id === b.id

  }

  public deleteById(productId: string): void {
    const index = this.findIndex(item => item.id.toString() === productId);
    if (index !== -1) {
      this.deleteData(index);
    }
  }
}