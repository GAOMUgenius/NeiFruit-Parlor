// 创建符合IDataSource接口的数据源
import { ShopInterface } from './CategoriesModel';

export class ShopDataSource implements IDataSource {
  private shops: ShopInterface[];

  constructor(shops: ShopInterface[]) {
    this.shops = shops;
  }

  totalCount(): number {
    return this.shops.length;
  }

  getData(index: number): ShopInterface {
    return this.shops[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    // 如果数据会动态变化，需要在此处实现监听
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    // 取消监听实现
  }
}