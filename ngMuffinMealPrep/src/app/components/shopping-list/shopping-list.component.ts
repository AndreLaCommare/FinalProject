import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { GroceryItem } from 'src/app/models/grocery-item';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { ShoppingListService } from 'src/app/services/shopping-list.service';

@Component({
  selector: 'app-shopping-list',
  templateUrl: './shopping-list.component.html',
  styleUrls: ['./shopping-list.component.css']
})
export class ShoppingListComponent implements OnInit{
  currentUser: User | null = null;


  constructor(
    private auth: AuthService,
    private currentRoute : ActivatedRoute,
    private shoppingServ: ShoppingListService){}

  ngOnInit(){
   this.getLoggedInUser();

  }



  getLoggedInUser( ){
    this.auth.getLoggedInUser().subscribe( {
      next: (user) =>{this.currentUser = user;
        console.log(user)
        console.log(this.currentUser)
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }

  removeFromList(grocery: GroceryItem){
    this.shoppingServ.deleteFromList(grocery).subscribe( {
      next: () =>{
        this.getLoggedInUser();
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }

}
