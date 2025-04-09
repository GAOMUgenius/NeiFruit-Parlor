export class AnnouncementData {
  id: number;
  title: string;
  community: string;
  content: string;
  date: string;
  constructor(id: number, title: string, community: string, content: string, date: string) {
    this.id = id;
    this.title = title;
    this.community = community;
    this.content = content;
    this.date = date;
  }
}

export const announcementDataDemo: AnnouncementData = new AnnouncementData(
  1,
  "社区停水通知",
  "西柚学院",
  '因管道维修，10月25日9:00-17:00暂停供水，请提前储水。',
  "2025-4-9"
)