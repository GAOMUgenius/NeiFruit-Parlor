// 定义商品数据模型
import { APIContants } from 'network';
import http from '@ohos.net.http';
import { ProductData } from './ProductModel';

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