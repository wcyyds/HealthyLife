export class BaseAccessTokenClass {
  access_token: string;
  refresh_token: string;
  expires_in: string;
  scope: string;
  session_key: string;
  session_secret: string;

  constructor(access_token: string, refresh_token: string, expires_in: string, scope: string, session_key: string, session_secret: string) {
    this.access_token = access_token;
    this.refresh_token = refresh_token;
    this.expires_in = expires_in;
    this.scope = scope;
    this.session_key = session_key;
    this.session_secret = session_secret;
  }
}