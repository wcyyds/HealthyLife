export class BaseUseToolsClass{
  id: string;
  title: string ;
  image: string ;
  url: string;

  constructor(id: string,title: string, image: string, url: string) {
    this.id = id;
    this.title = title;
    this.image = image;
    this.url = url;
  }
}