package com.skilldistillery.meals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Meal {

	@Id	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@Column(name="image_url")
	private String imageUrl;
	
	private String instructions;
	
	@CreationTimestamp
	@Column(name="created_at")
	private LocalDateTime createdAt;
	
	@UpdateTimestamp
	@Column(name="updated_at")
	private LocalDateTime updatedAt;
	
	private boolean enabled;
	
	@Column(name="public")
	private boolean visible;
	
	@Column(name="prep_time")
	private int prepTime;
	
	@Column(name="cook_time")
	private int cookTime;
	
	@JsonIgnoreProperties({"mealComments", "groceries", "mealReviews", 
		"userMeals", "favoriteMeals", "favoriteMealPlans", "planReviews", 
		"userMealPlans", "planComments", "sentMessages", "receivedMessages"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@JsonIgnore
	@ManyToMany(mappedBy="favoriteMeals")
	private List<User> usersWithFavMeals;
	
	@JsonIgnore
	@ManyToMany(mappedBy="mealsWithDiets")
	List<Diet> diets;
	
	@JsonIgnore
	@ManyToMany(mappedBy = "meals")
	private List<MealPlan> mealPlans;
	
	@JsonIgnoreProperties({"meal"})
	@OneToMany(mappedBy="meal")
	private List<MealReview> reviews;
	
	@JsonIgnoreProperties({"mealsWithGroceries"})
	@ManyToMany
	@JoinTable(name = "meal_has_grocery_item", 
	joinColumns = @JoinColumn(name = "meal_id"), 
	inverseJoinColumns = @JoinColumn(name = "grocery_item_id"))
	private List<GroceryItem> groceryItems;
	
	@OneToMany(mappedBy="meal")
	private List<MealComment> comments;
	
	
	
	public Meal() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getInstructions() {
		return instructions;
	}

	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<Diet> getDiets() {
		return diets;
	}

	public void setDiets(List<Diet> diets) {
		this.diets = diets;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isVisible() {
		return visible;
	}

	public void setVisible(boolean visible) {
		this.visible = visible;
	}

	public int getPrepTime() {
		return prepTime;
	}

	public void setPrepTime(int prepTime) {
		this.prepTime = prepTime;
	}

	public int getCookTime() {
		return cookTime;
	}

	public void setCookTime(int cookTime) {
		this.cookTime = cookTime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<User> getUsersWithFavMeals() {
		return usersWithFavMeals;
	}

	public void setUsersWithFavMeals(List<User> usersWithFavMeals) {
		this.usersWithFavMeals = usersWithFavMeals;
	}

	public List<MealPlan> getMealPlans() {
		return mealPlans;
	}

	public void setMealPlans(List<MealPlan> mealPlans) {
		this.mealPlans = mealPlans;
	}
	
	public void addMealPlan (MealPlan mealPlan){
		if(mealPlans == null) mealPlans = new ArrayList<>();
		if(!mealPlans.contains (mealPlan)){
		mealPlans.add(mealPlan); 
		mealPlan.addMeal(this);
		}
	}
	
	public void removeMealPlan (MealPlan mealPlan) {
		if(mealPlans != null && mealPlans.contains (mealPlan)){
		mealPlans.remove(mealPlan);
		mealPlan.removeMeal(this);
		}
	}
	

	public List<MealReview> getReviews() {
		return reviews;
	}

	public void setReviews(List<MealReview> reviews) {
		this.reviews = reviews;
	}

	public List<GroceryItem> getGroceryItems() {
		return groceryItems;
	}

	public void setGroceryItems(List<GroceryItem> groceryItems) {
		this.groceryItems = groceryItems;
	}
	public void addGrocery (GroceryItem groceryItem){
		if(groceryItems == null) groceryItems = new ArrayList<>();
		if(!groceryItems.contains (groceryItem)){
		groceryItems.add(groceryItem); groceryItem.addMeal(this);
		}
	}
	
	public void removeGrocery (GroceryItem groceryItem) {
		if(groceryItems != null && groceryItems.contains (groceryItem)){
		groceryItems.remove(groceryItem);
		groceryItem.removeMeal(this);
		}
	}

	public List<MealComment> getComments() {
		return comments;
	}

	public void setComments(List<MealComment> comments) {
		this.comments = comments;
	}
	
	

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Meal other = (Meal) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Meal [id=" + id + ", name=" + name + ", description=" + description + ", imageUrl=" + imageUrl
				+ ", instructions=" + instructions + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt
				+ ", enabled=" + enabled + ", visible=" + visible + ", prepTime=" + prepTime + ", cookTime=" + cookTime
				+ ", user=" + user + "]";
	}
	
	
	
	

}
