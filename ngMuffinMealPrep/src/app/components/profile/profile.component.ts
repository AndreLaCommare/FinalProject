import { ShoppingListService } from 'src/app/services/shopping-list.service';
import { UserService } from 'src/app/services/user.service';
import { ProfileService } from './../../services/profile.service';
import { User } from 'src/app/models/user';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
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
  userIsAdmin: boolean = false;
  allUsers: User[] = [];
  editMealPlan: MealPlan | null = null;
  mealPlanToChange: MealPlan | null = null;
  mealList: Meal[] = [];
  singleMeal: Meal | null = null;


  constructor(private authServ: AuthService,
    private currentRoute : ActivatedRoute,
    private mealService: MealService,
    private groceryItemService: GroceryItemService,
    private mealPlanService : MealPlanService,
    private userService: UserService,
    private router: Router,
    private shoppingListService: ShoppingListService){
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

        console.log(user);

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

      },

      error: (fail) => {
        console.error('Error reloading');
        console.error(fail);
      }

    });
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
        this.userMeals = [];
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
        this.userMealPlans = [];
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

   setEditMealPlan(mealPlan: MealPlan){
      this.editMealPlan = Object.assign({}, mealPlan);
   }

   changeMeals(mealPlan: MealPlan){
    this.mealPlanToChange = Object.assign({}, mealPlan);
   }

   updateMealPlan(mealPlan: MealPlan){
    console.log(mealPlan)
    this.mealPlanService.update(mealPlan).subscribe({
      next: (updatedMealPlan) => {
        this.editMealPlan = null;

        this.getLoggedInUser()
        console.log(updatedMealPlan)

      },

      error: (fail) => {
        console.error('Error reloading');
        console.error(fail);
      }

    });

   }

   findAllMeals(){
    this.mealService.index().subscribe({
     next: (meals) =>{
       console.log(meals)
       this.mealList = meals;
     }
    });
   }

   addMealToMealPlan(meal: Meal, mealPlan: MealPlan){
    this.mealPlanService.addMealToPlan(meal, mealPlan).subscribe( {
      next: () =>{
        this.getLoggedInUser();
        this.mealPlanToChange = null;

      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
   }




   removeMealFromMealPlan(meal: Meal, mealPlan: MealPlan){
    this.mealPlanService.deleteMealFromPlan(meal, mealPlan).subscribe( {
      next: () =>{
        this.getLoggedInUser();
        this.mealPlanToChange = null;
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }


  // deleteMealPlan(mealPlan: MealPlan) {
  //   this.mealPlanService.delete(mealPlan.id).subscribe({
  //     next: () => {
  //       this.ngOnInit();
  //     }
  //   })
  //   }

  deleteAccount(){
    this.userService.deleteAccount().subscribe( {
      next: () =>{
        this.logout();
        this.router.navigateByUrl('/home')
      },
      error: (nojoy)=>{
        console.error(nojoy)
      }});
  }

  logout(): void {
    localStorage.removeItem('credentials');
  }

  addGroceryToShoppingList(grocery: GroceryItem){
    console.log(this.userToDisplay)
      this.userToDisplay?.groceries.push(grocery)
    this.updateUserShoppingList(this.userToDisplay)
  }


  updateUserShoppingList(user: User|null){
    this.shoppingListService.update(user).subscribe({
      next: (update) => {


        this.ngOnInit();

      }

    })
  }


  displaySingleMeal(meal: Meal) {
    this.myMealPlans= false
    this.singleMeal = meal;
    }

    displayMealsInMealPlan(){
      this.myMealPlans= true
      this.singleMeal = null;
    }
}
