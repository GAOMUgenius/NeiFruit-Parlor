import { http } from "@kit.NetworkKit";
import { APIContants } from "network";
import { AppraiseData } from "./AppraiseModel";


interface ProductAppraiseRes {
  status: number,
  message: string,
  data: ProductAppraiseData
}

interface ProductAppraiseData {
  appraise: AppraiseData[]
}

export async function getAppraise(id: number, pagesize: number, pages: number, token: string): Promise<AppraiseData[]> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();
  let ip = APIContants.IP
  let port = APIContants.PORT

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      extraData: JSON.stringify({ id: id, pages: pages, page_size: pagesize }), // 请求体数据
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    // 发送 POST 请求
    const response = await httpClient.request(
      `http://${ip}:${port}/api/v1/product/appraise/get`,
      requestOptions
    );

    // 检查响应状态码
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as ProductAppraiseRes;

      if (result.status === 1000) {
        return result.data.appraise
      } else {
        throw new Error(result.message || '获取评论失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('获取评论失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}