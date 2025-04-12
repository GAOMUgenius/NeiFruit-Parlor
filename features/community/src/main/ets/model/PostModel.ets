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

export const postDataEgList: PostModel[] = [
  new PostModel(
  0,
  0,
  'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/e87ed842e807842692a99b44efbeb51.jpg',
  '星恋朔月',
  '西柚学院',
  2,
  5,
  '睡得晚 vs 睡得少，哪个危害更大？',
      '人类的悲欢并不相通。\n' +
      '现在熬夜的通常有两类人：\n' +
      '一类是「少睡党」，主动或被迫，ta 们每天只会睡 4～5 小时；\n' +
      '另一类则是「晚睡党」，相较前者似乎幸福很多，凌晨睡中午起，但睡够 7～8 小时。\n' +
      '睡得晚和睡得少，究竟哪个对身体的暴击更大？\n' +
      '1.睡得晚\n' +
      '你以为的「补觉自由」\n' +
      '实则正在掏空你的身体\n' +
      '深夜一两点还不睡的，要嘛是打工人，活儿没干完，在吭哧吭哧敲打第二天要交的 PPT\n' +
      '当你凌晨 2 点还在刷着手机，身体可能会误以为当下是「白天」：\n' +
      '👉 褪黑素罢工：蓝光抑制褪黑素分泌，导致入睡困难、睡眠浅（即使睡够 8 小时，质量也大打折扣）。\n' +
      '👉 肠胃懵圈：本该休息的胃被迫加班消化夜宵。\n' +
      '👉 免疫系统崩溃：NK 细胞（天然杀手细胞）活性降低 70%，流感病毒更易趁虚而入。\n' +
      '就说黑白倒班吧，早在 2007 年，国际癌症研究机构（IARC）就已经把上夜班定义为 2A 类致癌物。\n' +
      '晚睡≠补觉自由！！！\n' +
      '2.睡得少\n' +
      '身体「烧零件」\n' +
      '长期危害只多不少\n' +
      '听起来，晚睡晚起还不如晚睡早起？\n' +
      '不是的，睡得少有睡得少的危害。\n' +
      '抛开一些中了基因彩票的「先天短睡眠人士」——每晚只睡 4 小时，都能很好地工作，不会影响白天生\n' +
      '活。\n' +
      '大多数人少睡，身体会陷入一种「严重缺觉」的状态。\n' +
      '长此以往，还会影响肠道菌群，进而降低生殖性能。\n' +
      '睡眠不足对免疫系统的打击也更为全面和持久。\n' +
      '无论是三点睡、十点起，还是三点睡、六点起，都是对自己身体的一场霸凌。\n' +
      '充足的睡眠，才是修复好身体这座马车的关键。',
  ['https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/581d02a5dca36f1f7a5410cce8e25fe.png', 'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8eadb2f0cbff5b1ceb006de22f1d0a1.png',]
  ),
  new PostModel(
    1,
    1,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/b891f73953f2d6d9ea67e4f4c2c9de9.jpg',
    '吃汉堡吃到饱',
    '雁塔',
    1,
    3,
    '早点睡真的是百利无一害啊,失眠的可以看看我这方法管用吗',
    '楼主也是一个每天需要上早八的大学生，之前一直都是超12点睡，几乎大部分晚睡的原因都是失眠导致的，结果第二天每天都是让闹钟吵醒，起来一点精神都没有，后脑勺就跟让压了一块石头似的，一上课就困意来袭，头都抬不起来。\n' +
      '后面我每天10点关掉手机就睡觉，每天都是赶在闹钟响之前自然醒，起来就浑身神清气爽，晚睡起床就感觉世界都是灰色的，而早睡起床世界仿佛都是彩色的，头脑也很清晰心情也不烦躁，早睡也能起到美容的效果，之前我每天熬夜我额头都起了很多痘，现在每天早睡痘痘都正在慢慢的下去，之前我睡不着很大部分原因是因为失眠，我自己研究了个方法能让我在半个小时内就有困意，\n' +
      '我是在小破站上看那些 UP 主玩那些很小众的独立恐怖游戏，看一会就困意来袭关掉手机就能睡着，不知道这个方法你们能不能行，还有一个方法就是睡之前健健身比如平板支撑，仰卧起坐……让身体保持住劳累这样容易睡觉，祝各位盒友不要失眠早点睡，熬夜伤身体！',
    ['https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/ab60790826e809b50021801e79ff980.jpg']
  ),
  new PostModel(
    2,
    2,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/49b80e22297023c562032f5b1c0d1a6.jpg',
    '追不溯',
    '长安',
    1,
    7,
    '带邻友们讲一讲必须知道的保护自己的法律常识',
    '今天啊轩就带邻友们讲一讲必须知道的保护自己的法律常识～\n' +
      '无论是即将步入社会的学生，。还是已经摸爬滚打多年的职场老油条拍，可能都并不是很了解法律是如何保护咱打工人的，被老板欺负了都蒙在鼓里。\n' +
      '那可不行！劳动法翻起来！\n' +
      '1.遇到不和你签劳动合同的\n' +
      '如果你老板超过一个月，不满一年，不与你订立劳动合同的，应当向你每月支付双倍工资，一年后仍不签订劳动合同，视为已签订无固定期限合同。\n' +
      '请保留好工作证、餐票、评先评优等一切证明你工作的证据！\n' +
      '2.炒鱿鱼补偿金\n' +
      '第一次合同到期，企业选择终止需要支付 N 的补偿金二次合同到期，企业终止需要支付 2N（上海除\n' +
      '外）\n' +
      '不胜任工作解除要支付 N如果你提起仲裁公司还可能要支付 2N\n' +
      '大家常说的N+1通常是是协商解除的标准\n' +
      '（N 是指税前平均工资× 在本单位工作年限）\n' +
      '防止被公司以旷工理由解除劳动合同旷工三天自动离职！\n' +
      '3.不缴纳社保没法告！\n' +
      '很多人觉得公司不给缴纳社保是违法的\n' +
      '那去直接告公司不就得了？\n' +
      '不是这样的！！\n' +
      '如果你未缴纳社保和公积金\n' +
      '劳动仲裁是不受理的\n' +
      '只能走行政投诉\n' +
      '所以一定要交社保啊！！\n' +
      '4.加班记得留证据！\n' +
      '每周没有休息2天或上班超过40小时加班工资周六、日双倍，法定节假日三倍工资货真价实。\n' +
      '但是！\n' +
      '公司如果不付加班费你一定要保留加班证据否则很可能败诉。\n' +
      '5.辞职\n' +
      '辞职不需要批准，只需要提前 30 日通知即可哪怕离职手续没办完你也可以走人！\n' +
      '但是要三思而后辞\n' +
      '因为辞职不可撤回除非用人单位同意\n' +
      '那我要是和公司打官司会不会花很多钱啊？\n' +
      '别担心！\n' +
      '放心大胆地告！员工跟公司打官司诉讼费只要10块钱！',
    ['https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/eb8b4e324c5f75d0bfc4edf6b8edcd4.png', 'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/d4a12ece213fb33c9f80c4e2b29f86c.png']
  ),
  new PostModel(
    3,
    3,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/3939abcf60702acf3b7663d65100ca4.png',
    '不秃头的狐狸',
    '西安',
    1,
    25,
    '舍友还在打呼噜？快让他去医院看看！',
    '打呼噜是一个世界难题，全世界每 2 个人中就有 1 个人会打呼。\n' +
      '需要强调的是，打呼噜不仅会影响睡眠质量，还可能对人体产生更严重的危害。\n' +
      '简单地说，打呼噜是因为呼吸不畅。\n' +
      '呼吸的时候，气流从口、鼻进入，通过口腔、鼻腔、咽、喉等部位进入气管。\n' +
      '在这个过程中，任何一个地方不通畅，都可能让呼吸发出声响。\n' +
      '具体来说，鼾声的产生通常与以下因素有关：\n' +
      '呼吸道受阻：当空气通过受阻的呼吸道时，会产生嗓音，这是鼾声的主要原因。呼吸道受阻的原因可能是鼻腔狭窄、扁桃体肥大、舌头后坠等。\n' +
      '睡姿不当：睡觉时仰卧或侧卧不当，也会导致鼾声的产生。仰卧时，舌头会向后倒，阻碍呼吸，从而产生鼾声；侧卧时，舌头可能会滑向喉咙，同样会引起鼾声。\n' +
      '肥胖：肥胖会导致颈部脂肪堆积、腹部脂肪堆积、咽腔鼻腔狭窄等，这些都会促使打鼾。根据日常生活的经验，很多人体重越胖，打呼噜的声音就越大。',
    []
  ),
  new PostModel(
    4,
    4,
    'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/38477af1dff3fe0e72fbdd2afbb1cb5.jpg',
    '菊千代不是菊万代',
    '西柚学院',
    1,
    12,
    '皮蛋不是坏蛋，是好蛋？',
    '皮蛋，又称松花蛋、变蛋，是中国传统风味蛋制品，因蛋白表面常形成松枝状花纹而得名。\n' +
      '它以鸭蛋或鸡蛋为原料，通过碱性物质（如生石灰、草木灰等）腌制加工而成，口感鲜嫩滑爽，带有独特咸香和微涩风味。\n' +
      '相传江苏吴江一茶馆店主意外发现茶叶渣与炉灰中的鸭蛋形成黑色花纹，成为最早的皮蛋雏形。\n' +
      '皮蛋是坏蛋的谣言： \n' +
      '1. “皮蛋含铅高，吃了会铅中毒”\n' +
      '这一说法源于传统工艺中使用含铅的“黄丹粉”辅助成型。但自2015年起，我国已全面推广无铅工\n' +
      '艺，用硫酸铜、硫酸锌等替代含铅物质。\n' +
      '国家标准：皮蛋铅含量需≤0.2毫克/千克（部分标准为≤0.5毫克/千克），正规厂家产品远低于此限值。\n' +
      '2. “皮蛋营养价值低，是垃圾食品”\n' +
      '皮蛋富含蛋白质（更易吸收的小分子肽）、矿物质（钙、铁、锌、硒），且胆固醇低于鲜蛋减脂友好好帮手，高蛋白、低脂肪，适合替代普通蛋类。\n' +
      '此外中医认为可清热泻火，现代研究证实其多肽成分有抗氧化、抗炎活性\n' +
      '选购要点：\n' +
      '优先选择带SC标志的正规品牌，避免散装产品。\n' +
      '蛋壳完整、摇晃有弹性，少量黑斑为佳。\n' +
      '保存方法：\n' +
      '避光阴凉处存放，冷藏易导致口感变硬。\n' +
      '剥壳后2小时内未食用需重新加热。',
    ['https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/181c2d4de07c0730c018e4252afa686.png', 'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/c6ec9206a575152a89b77f7177cbd12.png']
  ),
]

export class  PostPublishModel {
  post_title?: string;
  post_content?: string;
  post_content_picture?: string[];
}

export interface likesChange {
  handleLikeChange(postId: number, newLikes: number): void
}
