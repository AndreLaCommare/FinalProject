import { User } from 'src/app/models/user';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Meal } from 'src/app/models/meal';
import { MealService } from 'src/app/services/meal.service';
import { GroceryItemService } from 'src/app/services/grocery-item.service';
import { GroceryItem } from 'src/app/models/grocery-item';
import { MealPlan } from 'src/app/models/meal-plan';
import { MealPlanService } from 'src/app/services/meal-plan.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit{
  userToDisplay : User | null = null;
  myMeals: boolean = false;
  myMealPlans: boolean = false;
  editMeal: Meal | null = null;
  groceryItemList: GroceryItem [] = [];
  userMeals: Meal[] = [];
  userMealPlans: MealPlan[] = [];



  constructor(private authServ: AuthService,
    private currentRoute : ActivatedRoute,
    private mealService: MealService,
    private groceryItemService: GroceryItemService,
    private mealPlanService : MealPlanService){
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
      next: (user) =>{this.userToDisplay = user;
        this.getUserMeals();
        this.getUserMealPlans();
        this.userToDisplay.userMeals = this.userMeals;
        this.userToDisplay.userMealPlans = this.userMealPlans;

        console.log(this.userToDisplay.userMeals)}
     ,
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

  findAllGroceryItems(){
    this.groceryItemService.findAll().subscribe({
     next: (itemList) =>{
       console.log("in find all groceries: " + itemList)
       this.groceryItemList = itemList;
     }
    });
   }

   getUserMeals(){
    this.mealService.index().subscribe({
      next: (data) => {
        for(let meal of data){
          if(meal.user?.id === this.userToDisplay?.id){
            this.userMeals.push(meal);

          }
        }
      },


  error: (fail) => {
    console.error('Error reloading');
    console.error(fail);
  }
  });
   }

   getUserMealPlans(){
    this.mealPlanService.index().subscribe({
      next: (data) => {
        for(let mealPlan of data){
          if(mealPlan.planCreator?.id === this.userToDisplay?.id){
            this.userMealPlans.push(mealPlan);

          }
        }
      },


  error: (fail) => {
    console.error('Error reloading');
    console.error(fail);
  }
  });

   }


}
