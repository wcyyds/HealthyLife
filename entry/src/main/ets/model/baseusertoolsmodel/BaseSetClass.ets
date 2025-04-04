export class BaseSetClass {
  id: string;
  title: string;
  image: string;
  state: string;
  url: string;

  constructor(id: string, title: string, image: string, state: string, url: string) {
    this.id = id;
    this.title = title;
    this.image = image;
    this.state = state;
    this.url = url;
  }
}