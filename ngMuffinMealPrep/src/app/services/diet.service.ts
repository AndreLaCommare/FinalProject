import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Diet } from '../models/diet';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class DietService {
  private url = environment.baseUrl + 'api/diets';


  constructor(private http: HttpClient, private auth: AuthService) { }

  index(): Observable<Diet[]> {
    return this.http.get<Diet[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('DietService.index(): error finding diets: ' + err)
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
