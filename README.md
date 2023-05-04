# Muffin Meal Prep
* Scrum Master: Jay Kantor
* GitHub Repository Owner: Andre La Commare
* Database Administrator: Thomas McGlone 

URL for access

http://44.225.193.103:8080/MuffinMealPrep/


Username: TheMuffinMan

Password: password

For admin functionality:

Username: admin

Password: test

### Meals Rest Endpoints 
| HTTP Verb | URI                  | Request Body | Response Body |
|-----------|----------------------|--------------|---------------|
| GET       | `/api/meals`      |              | Collection of representations of all _meals_ resources |collection** endpoint |
| GET       | `/api/meals/1`   |              | Representation of _meal_ `1` |
| GET       | `/api/meals/{keyword}`   |              | Will dispaly a list of all the meals associated with the keyword|
| POST      | `/api/meals`      | Representation of a new _meal_ resource | Description of the result of the operation | **
| PUT       | `/api/meals/1`   | Representation of a new version of _meal_ `1` |
| PUT       | `/api/meals/admin/1`   | _Meal_ `1` will be reactivated. This is only possible when logged in as the admin profile|
| DELETE    | `/api/meals/1`   |              | | Response is void but only deactivates meal specified by the id so it is not visible to public by switching the enabled field to false.
| DELETE    | `/api/meals/admin/1`   |              | | Response is void but only deactivates meal specified by the id so it is not visible to public. This action can only be taken when logged in as the admin profile.

### Meal Plans Rest Endpoints

| HTTP Verb | URI                  | Request Body | Response Body |
|-----------|----------------------|--------------|---------------|
| GET       | `/api/mealPlans`      |              | Collection of representations of all _meal plans_ resources |collection** endpoint |
| GET       | `/api/mealPlans/1`   |              | Representation of _meal plan_ `1` |
| GET       | `/api/meals/{keyword}`   |              | Will dispaly a list of all the meal plans associated with the keyword|
| POST      | `/api/mealPlans`      | Representation of a new _meal plan_ resource | Description of the result of the operation | **
| PUT       | `/api/meals/1`   | Representation of a new version of _meal_ `1` |
| PUT       | `/api/mealPlans/1/meals/1`   | Adds meal `1` to meal plan `1` |
| PUT       | `/api/meals/admin/1`   | _Meal Plan_ `1` will be reactivated. This is only possible when logged in as the admin profile|
| DELETE    | `/api/mealPlans/1`   |              | | Response is void but only deactivates meal plan specified by the id so it is not visible to public by switching the enabled field to false.| DELETE    | `/api/mealPlans/1/meals/1`   |              | | Removes meal `1` from meal plan `1`
| DELETE    | `/api/meals/admin/1`   |              | | Response is void but only deactivates meal plan specified by the id so it is not visible to public. This action can only be taken when logged in as the admin profile.

Throughout this project, we also utilized many other REST endpoints outside of our primary two tables to achieve specific goals. For example, we use a GET mapping of /api/diets to find all of the different diets we implemented throughout the project. This endpoint is used in the meal plans page and is filtered to find specific diets using a pipe. Another example of this would be in the user controller with the PUT mapping of myShoppingList/{userId} and DELETE mapping of myShoppingList/{groceryItemId}. These two endpoints allow a user to add and remove a grocery item to their shopping list from a single meal view. 


## Description 

Muffin Meal Prep is the final project of our Skill Distillery 37 cohort and is a full-stack application whose purpose is to provide an easier way to create and manage meal plans and meals. Along with this, it allows for a social aspect where users can interact by leaving reviews on meal plans and adding other users' meals to their own meal plans. Finally, it allows users to add specific grocery items to their shopping lists so that there is an easy way to view and manage what grocery items they need to purchase. This application uses REST, Spring Data JPA, Spring Security SpringBoot, Angular, HTML, CSS, and MySQL workbench to achieve full-stack status.

## Database Schema

We used the visual tool MySQL workbench to develop the schema for Muffin Meal Prep. In total, our schema contains seventeen tables with varying relationships to each other. The core three tables of this application are meal, meal_plan, and user. These tables have many branches of them to create specific functionality within the application but are really the core of what is important and fundamentally necessary for the site to function. 

##### User Table and Spring Security

The User table holds all the information for the Java entity User including the two most important fields username and password. The username will be stored in the database through plain text, but the password a user inputs when they register on the site is encoded through spring security and stored in the database in its encoded form. This provides a layer of encryption that was not previously present in our projects that simply used matching plain text to log into the site. 

Spring security is also essential for the authentication of logged-in user-specific functions. For example, when clicking on the profile link in our nav bar, the name, picture, meals, and meal plans for only the logged-in user are displayed. This is done through the authentication of spring security. Finally, the spring security Principal object is used throughout the project to ensure that only the currently logged-in user can only affect their own meals and meal plans. For example, when editing or deleting a meal or meal plan a Principal check is done through a repository method to ensure that the currently logged-in user is allowed to change that meal or plan. 

User also has many relationships that branch off of it to provide other functionality. For example, user has a many-to-many relationship with the grocery_item table which allows for the association of many grocery_item ids to many user ids. This table is what allows for the shopping list functionality in our application, and also what allows for many different users to have the same grocery items in their shopping list at the same time. 

##### Meal and Meal Plan 

The meal and meal plan tables provide the core functionality of the application. They each have many relationships with other tables such as diet and review, as well as having a relationship with each other through the many-to-many relationship meal_plan_has_meal which allows meals and meal plans to be associated together. These first two relationships allow us to connect more information to the entities like a specific diet for a meal plan or a review for a meal. Using these relationships is what allows us to bring to our site information like a meal plan's diet while also allowing us to create meal plans with diets in the first place. 

A good example of this comes in the many-to-many relationship between meal and grocery_item. Very similar to user and grocery_item, this relationship allows for many meals to be associated with many grocery items by binding their IDs together within the table. As opposed to a many-to-one relationship where we would only be able to have those specified grocery items associated with one meal. 



## Angular Development

## Services

Our Angular services were utilized to implement CRUD functionality through the proper Mapping channels specified in our Controllers in STS. We declared a URL for each service for example: in meal.service.ts our URL was defined as environment.baseUrl + 'api/meals'; allowing each of our subsequent CRUD methods to call the HttpClient's post/put/get/delete method while appending the appropriate path variables to the url as to match the Controller. 

## Components

All of our Angular components implement the OnInit interface. We then defined the NgOnInit function to properly get, and display the data in the browser upon first reaching a page. All component methods implementing CRUD operations made appropriate calls to the required entity's service. These methods are then called as click events on appropriate HTML elements in order to be accessible to the user. The Service is made present in our Component's through injection into the components no-args constructor. Most Components injected 2 or more Services in order to obtain the relevant data needed for the relevant browser page. Our Component Type Script often contained fields of local arrays in order to filter/check data results as well as booleans in order to manipulate conditionals in the Component's HTML.

## Models

Our Angular Models were used in order to have an entity from STS be constructed within the Angular side of the project. Our Component TypeScript file calls upon these models in order to create local entities like a User or Meal to bind data to in order to update or create them. For instance, the Create a Meal form on the webpage binds the inputs of each section to the model that is declared in the Component as a new Meal(); when the submit button is subsequently clicked, this model with the user-inputted data is sent back to the Database through Component and Service function calls.

## Modules

We used two modules in our Angular application. One basic app module and a routing module to control pathing from one page to another across the website. The module is the most fundamental building block of an Angular application. We learned quickly that any Component created implementing Service methods, pushing and toggling information on its html was useless if it was not first imported in the app.module.ts's class and declarations field.

## Pipes

Angular pipes initially seemed confusing but we found the use for two within our project and our understanding of them has improved. Our pipes manipulate the display of data rather than the data itself, functioning as a filter. One example from our project is the enabled meals pipe which is applied in our meal.component.html to keep deleted meals from displaying. That is to say, meals the user has deleted from their account but are still present within the database. 




## Java Back End

The back-end of our program, built using Spring Boot in Eclipse, consists of several different classes, all mapped together using Spring framework annotations. The boot app utilizes Entities, Services, and their implementations, Repositories, and Controllers.

## Controllers
As user input and user data moves from the front-end, Angular side of the application, each interaction is mapped to a different REST API endpoint within a controller. Using the "RestController" annotation, the endpoints are then recognized for the user input to seamlessly flow into the back-end. Based on the desired outcome, Spring is able to simultaneously ensure the user is authenticated by taking in a Principal user, and also calling upon the appropriate service method it needs. In the case of the method below, the controller endpoint that is mapped also must receive the meal id path variable to pass on to the service layer. Once that occurs, the controller is able to either return what is needed, a specific meal in this case, or an error indicating where the failure occurred.

``` 
@GetMapping("meals/{mealId}")
    public Meal showByMealId(HttpServletRequest req, HttpServletResponse res,
                     @PathVariable Integer mealId) {
        Meal meal = mealService.findByMealId(mealId);
        if (meal == null) {
            res.setStatus(404);
        }
        return meal;
    }
```

## Services

At the service level, the meal id received in this case utilizes just one method, although many could be needed for a single endpoint. To achieve the necessary outcome at the service level, a method accesses both the getters and setters within the entity class and the corresponding repository to gather, set, then persist the data in the database. The method below demonstrates how the meal object is referenced to set the updated fields, while the repository handles directly speaking to the database.

```
@Override
	public Meal update(String username, int mealId, Meal meal) {
		Meal managedMeal = mealRepo.findByIdAndUser_Username(mealId, username);
		if (managedMeal != null) {
			managedMeal.setName(meal.getName());
			managedMeal.setDescription(meal.getDescription());
			managedMeal.setImageUrl(meal.getImageUrl());
			managedMeal.setInstructions(meal.getInstructions());
			managedMeal.setEnabled(meal.isEnabled());
			managedMeal.setVisible(meal.isVisible());
			
			mealRepo.saveAndFlush(managedMeal);
		}
		return managedMeal;
	}
```
## Repositories 
Within the repositories in this program, the JPA Repository is extended in order to use its library of queries to access the database. Using entity names and required naming conventions, Spring Data JPA queries what is required of the database and persists the data to achieve the CRUD objective or otherwise. The MealRepository used in this program only contained a handful of custom query methods, which were subsequently called on in numerous service methods to achieve different REST endpoints. Each entity that required data manipulation needed a specific repository interface for organizing their query methods.


```
public interface MealRepository extends JpaRepository<Meal, Integer> {
	Meal findById(int mealId);
	List<Meal> findByUser_Username(String username);
	Meal findByIdAndUser_Username(int mealId, String username);
	List<Meal> findByNameLike(String query);

}
```
## Entities 
While the entity classes within the program required similar getters, setters, and other repeated items, each was mapped to achieve the most logical flow of data. There were numerous instances in which JSONIgnore and JSONIgnoreProperties were needed to avoid recursion and unnecessary calls to the database. These are found throughout the major entities in this program, as a major aspect was the users need to access lists within lists at multiple layers. An example of this from the MealPlan entity is below.

```
@JsonIgnoreProperties({"imgUrl","createdAt","updatedAt", "mealPlans"})
	@ManyToMany
	@JoinTable(name = "meal_plan_has_meal", 
	joinColumns = @JoinColumn(name = "meal_plan_id"), 
	inverseJoinColumns = @JoinColumn(name = "meal_id"))
	private List<Meal> meals;
```

 ## Technologies Used
* Java
* Spring Tool Suite
* Spring Data JPA
* Spring Security
* Spring Boot
* REST
* HTML
* CSS
* JSON
* Angular


## Lessons Learned

* We believe that we should have utilized routing a lot more throughout this project which would have been easier if we had used smaller components such as single meal and single meal plan views. When we each graduate from this course and fork this project we all plan to implement this change. 

* We all also learned a great deal about JSON ignores. Specifically, that owning sides of many-to-many relationships should be the side that is specified with the join table so that the data can be persisted correctly in the database. Along with JSON ignore we also learned that we should wait to actually implement JSON ignores until they are actually needed to stop recursion. We previously were adding them based on what we thought would cause problems in the future which can work, but can also cause problems when information is not displaying correctly. 

* Finally, we learned about the usefulness of pipes for filtering data. As opposed to using the back end Java or an if statement in the HTML, a pipe can be used to filter your information and applied anywhere necessary. 


