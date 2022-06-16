import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthLoginDto } from '../models/dto/auth/auth';
import { AuthLoginResponse } from '../models/interfaces/auth/auth';
import { Constants } from '../utils/constants';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  constructor(private http: HttpClient) {}

  doLogin(logindDto: AuthLoginDto): Observable<AuthLoginResponse> {
    let requestUrl = `${environment.apiBaseUrl}${Constants.AUTH_BASE_URL}/login`;

    return this.http.post<AuthLoginResponse>(
      requestUrl,
      logindDto,
      Constants.DEFAULT_HEADERS
    );
  }
}
