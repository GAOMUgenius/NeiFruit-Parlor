export class PostModel {
  post_id: number;
  user_id: number;
  user_picture: string;
  user_name: string;
  user_community: string;
  post_appraise_number: number;
  post_likes_number: number;
  post_title: string;
  post_content: string;
  post_content_picture: string[];

  constructor(
    post_id: number,
    user_id: number,
    user_picture: string,
    user_name: string,
    user_community: string,
    post_appraise_number: number,
    post_likes_number: number,
    post_title: string,
    post_content: string,
    post_content_picture: string[]
  ) {
    this.post_id = post_id;
    this.user_id = user_id;
    this.user_picture = user_picture;
    this.user_name = user_name;
    this.user_community = user_community;
    this.post_appraise_number = post_appraise_number;
    this.post_likes_number = post_likes_number;
    this.post_title = post_title;
    this.post_content = post_content;
    this.post_content_picture = post_content_picture;
  }
}

export const postDataEg: PostModel = new PostModel(
  0,
  0,
  'app.media.user_picture1',
  '吃汉堡吃到饱',
  '西柚学院',
  50,
  2000,
  '早点睡真的是百利无一害啊,失眠的可以看看我这方法管用吗',
  '楼主也是一个每天需要上早八的大学生，之前一直都是超12点睡，几乎大部分晚睡的原因都是失眠导致的，结果第二天每天都是让闹钟吵醒，起来一点精神都没有，后脑勺就跟让压了一块石头似的，一上课就困意来袭，头都抬不起来。\n' +
    '后面我每天10点关掉手机就睡觉，每天都是赶在闹钟响之前自然醒，起来就浑身神清气爽，晚睡起床就感觉世界都是灰色的，而早睡起床世界仿佛都是彩色的，头脑也很清晰心情也不烦躁，早睡也能起到美容的效果，之前我每天熬夜我额头都起了很多痘，现在每天早睡痘痘都正在慢慢的下去，之前我睡不着很大部分原因是因为失眠，我自己研究了个方法能让我在半个小时内就有困意，\n' +
    '我是在小破站上看那些 UP 主玩那些很小众的独立恐怖游戏，看一会就困意来袭关掉手机就能睡着，不知道这个方法你们能不能行，还有一个方法就是睡之前健健身比如平板支撑，仰卧起坐……让身体保持住劳累这样容易睡觉，祝各位盒友不要失眠早点睡，熬夜伤身体！',
  ['app.media.post_content_picture1', 'app.media.post_content_picture1',]
)

export class  PostPublishModel {
  post_title?: string;
  post_content?: string;
  post_content_picture?: string[];
  // constructor(post_title: string, post_content: string, post_content_picture: string[]) {
  //   this.post_title = post_title
  //   this.post_content = post_content
  //   this.post_content_picture = post_content_picture
  // }
}
