// 定义商品数据模型
import { APIContants } from 'network';
import http from '@ohos.net.http';
import { ProductData, ProductSelection } from './ProductModel';
import { ProductDataSource } from './ProductDataSource';
import { promptAction } from '@kit.ArkUI';

// 定义接口响应结构
interface GetProductResponse {
  status: number;
  msg: string;
  data: ProductData[]
}

interface getProductData {
  product_list: ProductData[];
}

// 定义错误处理接口
interface ApiError {
  code: number;
  message: string;
}

// 获取推荐商品的方法
export async function fetchRecommendedProducts(token: string): Promise<ProductData[]> {
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    //发送get请求
    const response = await httpClient.request(
      `http://${ip}:${port}/api/v1/product/list`,
      requestOptions
    );

    // 处理响应
    if (response.responseCode === 200) {
      const result = response.result as GetProductResponse;

      if (result.status === 1000) {
        return result.data;
      } else {
        throw new Error(result.msg || '获取商品列表失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    console.error('获取推荐商品失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    httpClient.destroy();
  }
}

export async function addToCart(product: ProductData, localDataSource: ProductDataSource| undefined, productSelectionMap: Map<string, ProductSelection> | undefined) {
  // 构造完整商品对象
  const newProduct: ProductData = new ProductData(
    product.id,
    product.product_picture,
    product.product_name,
    product.product_price,
    product.product_unit,
    product.product_capacity,
    product.product_capacity_unit,
  )
  try {
    if (localDataSource) {
      // 操作 productSelectionMap
      if (!productSelectionMap) {
        productSelectionMap = new Map();
      }

      // 获取或初始化商品数量
      const existingEntry = productSelectionMap.get(product.id.toString());
      if (existingEntry) {
        // 数量加1
        existingEntry.number++;
        productSelectionMap.set(product.id.toString(), existingEntry);
      } else {
        // 初始化数量为1
        productSelectionMap.set(product.id.toString(), { number: 1, ischoose: false });
      }

      // 操作 localDataSource（仅添加新商品）
      const existingProductIndex = localDataSource.findIndex(
        item => item.id === product.id
      );
      if (existingProductIndex === -1) {
        localDataSource.dataList.push(newProduct);
        localDataSource.reloadData();
      }

      promptAction.showToast({
        message: '添加购物车成功'
      });
    }
  } catch (error) {
    console.error('添加失败:', error);
  }
}