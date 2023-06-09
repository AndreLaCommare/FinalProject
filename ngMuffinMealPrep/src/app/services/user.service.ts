import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private url = environment.baseUrl + 'api/users';
  constructor(private http: HttpClient, private auth: AuthService) { }


  index(): Observable<User[]> {
    // Return defensive copy of private array
    return this.http.get<User[]>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.index(): error retrieving users: ' + err)
        );
      })
    );
  };

  delete(userId: number): Observable<void>{
    return this.http.delete<void>(this.url + "/" + userId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.delete(): error disabling User: ' + err)
        );
      })
    );
  }

  reactivate(user: User): Observable<User>{
    return this.http.put<User>(this.url + "/" + user.id, user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.reactivate(): error re-enabling User: ' + err)
        );
      })
    );
  }

  deleteAccount(): Observable<void>{
    return this.http.delete<void>(this.url, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.delete(): error deleteing User: ' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
}
