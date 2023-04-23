import { User } from 'src/app/models/user';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Meal } from 'src/app/models/meal';
import { MealService } from 'src/app/services/meal.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit{
  userToDisplay : User | null = null;
  myMeals: boolean = false;
  editMeal: Meal | null = null;



  constructor(private authServ: AuthService,
    private currentRoute : ActivatedRoute,
    private mealService: MealService){
  }



  ngOnInit(){
    let userId = this.currentRoute.snapshot.paramMap.get("userId");
    if (userId){

      this.getOtherUser(parseInt(userId));
    }else{
      this.getLoggedInUser();
    }
  }

  getLoggedInUser( ){
    this.authServ.getLoggedInUser().subscribe( {
      next: (user) =>{this.userToDisplay = user},
      error: (nojoy)=>{
        console.error(nojoy)
      }});


  }

  getOtherUser(userId: number){
    //implement subscribe to userService.getUser()
  }

  setEditMeal(meal: Meal){
    this.editMeal = Object.assign({}, meal);

  }

  updateMeal(meal: Meal){
    this.mealService.update(meal).subscribe({
      next: (updatedMeal) => {
        this.editMeal = null;
        console.log(updatedMeal)
        this.ngOnInit();

      }

    })
  }

  deleteMeal(mealId: number){
    this.mealService.delete(mealId).subscribe({
      next: () => {
        this.ngOnInit();
      }
    })
  }


}
