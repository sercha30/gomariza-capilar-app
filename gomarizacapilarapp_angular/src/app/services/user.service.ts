import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { UserMeResponse } from '../models/interfaces/user/user';
import { Constants } from '../utils/constants';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  constructor(private http: HttpClient) {}

  getLoggedUser(): Observable<UserMeResponse> {
    let requestUrl = `${environment.apiBaseUrl}${Constants.AUTH_BASE_URL}/me`;

    return this.http.get<UserMeResponse>(requestUrl, Constants.AUTH_HEADERS);
  }
}
