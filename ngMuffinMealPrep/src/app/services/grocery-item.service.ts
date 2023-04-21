import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { GroceryItem } from '../models/grocery-item';

@Injectable({
  providedIn: 'root',
})
export class GroceryItemService {
  private url = environment.baseUrl + 'api/groceryItems';

  constructor(private http: HttpClient) {}

  findAll(): Observable<GroceryItem[]> {
    return this.http.get<GroceryItem[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'GroceryItemService.findAll(): error retrieving grocery items: ' +
                err
            )
        );
      })
    );
  }

  findById(groceryItemId: number): Observable<GroceryItem> {
    return this.http.get<GroceryItem>(this.url + '/' + groceryItemId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'GroceryItemService.findById(): error retrieving grocery item: ' +
                err
            )
        );
      })
    );
  }

  create(groceryItem: GroceryItem): Observable<GroceryItem> {
    return this.http.post<GroceryItem>(this.url, groceryItem).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'GroceryItemService.create(): error creating grocery item: ' +
                err
            )
        );
      })
    );
  }

  update(groceryItemId: number, groceryItem: GroceryItem): Observable<GroceryItem> {
    return this.http.put<GroceryItem>(this.url + '/' + groceryItemId, groceryItem).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'GroceryItemService.update(): error updating grocery item: ' +
                err
            )
        );
      })
    );
  }

  delete(groceryItemId: number): Observable<boolean> {
    return this.http.delete<boolean>(this.url + '/' + groceryItemId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'GroceryItemService.delete(): error deleting grocery item: ' +
                err
            )
        );
      })
    );
  }
}

