import { HttpHeaders } from '@angular/common/http';

export class Constants {
  static AUTH_BASE_URL = '/auth';
  static BEARER_TOKEN = 'token';
  static DEFAULT_HEADERS = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
    }),
  };
  static AUTH_HEADERS = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      Authorization: `Bearer ${localStorage.getItem('token')}`,
    }),
  };
}
