// 导入 HTTP 模块
import http from '@ohos.net.http';

// 定义响应数据结构接口
interface CodeResponse {
  status: string;
  message: string;
  data: DataResponse
}

interface DataResponse {
  code: string
}
// 获取验证码方法
export async function getVerificationCode(email: string): Promise<string> {
  // 创建 HTTP 客户端
  const httpClient = http.createHttp();

  try {
    // 配置请求参数
    const requestOptions: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: JSON.stringify({ email }), // 请求体数据
      expectDataType: http.HttpDataType.OBJECT // 期望返回数据类型
    };

    // 发送 POST 请求
    const response = await httpClient.request(
      'https://api/v1/auth/code',
      requestOptions
    );

    // 检查响应状态码
    if (response.responseCode === 200) {
      // 解析响应数据
      const result = response.result as CodeResponse;

      if (result.status === '1000') {
        return result.data.code; // 返回验证码
      } else {
        throw new Error(result.message || '验证码获取失败');
      }
    } else {
      throw new Error(`请求失败，状态码：${response.responseCode}`);
    }
  } catch (error) {
    // 处理错误情况
    console.error('获取验证码失败:', error);
    throw new Error(`网络请求失败：${error.message}`);
  } finally {
    // 释放 HTTP 客户端资源
    httpClient.destroy();
  }
}

// 使用示例（在需要的地方调用）
export async function onGetCodeClick() {
  try {
    const email = '2047772125@qq.com';
    const code = await getVerificationCode(email);
    console.log('验证码获取成功:', code);
    // 这里可以添加处理验证码的逻辑（如显示到界面）
  } catch (error) {
    console.error('验证码获取失败:', error.message);
    // 这里可以添加错误提示逻辑
  }
}