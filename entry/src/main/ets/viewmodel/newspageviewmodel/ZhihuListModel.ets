export class ZhihuListModel{
  data: string = ''
  stories: Array<ZhihuListItem> = []
}

export class ZhihuListItem{
  title: string = ''
  images: Array<string> = []
  ga_prefix: string = ''
  id: number = 0
  type: number = 0
  url: string = ''
}