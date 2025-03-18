import { BasicDataSource } from "datastore";
import { ProductData } from "./ProductModel";

//包装商品信息符合IDataSource接口的数据源
@Observed
export class ProductDataSource extends BasicDataSource {
  @Track dataList: ProductData[] = [];

  public updateItem(newData: ProductData): void {

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
      item.product_id,
      item.product_picture,
      item.product_name,
      item.product_price,
      item.product_unit,
      item.product_capacity,
      item.product_capacity_unit,
      item.product_number)); // 必须创建新对象
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
    return a.product_id === b.product_id &&
      a.product_number === b.product_number; // 只对比关键字段
  }

}