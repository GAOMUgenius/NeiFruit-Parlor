// 定义商品数据模型
import { APIContants } from 'network';
import http from '@ohos.net.http';

interface Product {
  id: string;
  product_video: string;
  product_picture: string;
  product_name: string;
  product_price: number;
  product_unit: string;
  product_capacity: number;
  product_capacity_unit: string;
}

// 定义接口响应结构
interface GetProductResponse {
  status: number;
  msg: string;
  data: getProductData
}

interface getProductData {
  product_list: Product[];
}

// 定义错误处理接口
interface ApiError {
  code: number;
  message: string;
}

// 获取推荐商品的方法
async function fetchRecommendedProducts(): Promise<Product[]> {
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
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
        return result.data.product_list;
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

// 使用示例
async function loadProducts() {
  try {
    const products = await fetchRecommendedProducts();
    console.log('成功获取商品列表：', products);
    // 在这里更新UI状态或进行其他处理
  } catch (error) {
    // 显示错误信息给用户
    console.error('商品加载错误：', error);
  }
}