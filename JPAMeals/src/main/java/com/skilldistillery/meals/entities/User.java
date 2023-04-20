package com.skilldistillery.meals.entities;

import java.time.LocalDateTime;
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
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity
public class User {

	@Id	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private boolean enabled;

	private String role;
	
	private String email;
	
	@CreationTimestamp
	@Column(name="created_at")
	private LocalDateTime createdAt;
	
	@UpdateTimestamp
	@Column(name="updated_at")
	private LocalDateTime updatedAt;
	
	@Column(name="about_me")
	private String aboutMe;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="image_url")
	private String imageUrl;

	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<MealComment> mealComments;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "user_grocery_list", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "grocery_item_id"))
	private List<GroceryItem> groceries;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<MealReview> mealReviews;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Meal> userMeals;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "user_has_favorite_meal", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "meal_id"))
	private List<Meal> favoriteMeals;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "user_has_favorite_meal_plan", 
	joinColumns = @JoinColumn(name = "user_id"), 
	inverseJoinColumns = @JoinColumn(name = "meal_plan_id"))
	private List<MealPlan> favoriteMealPlans;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<PlanReview> planReviews;
	
	@JsonIgnore
	@OneToMany(mappedBy="planCreator")
	private List<MealPlan> userMealPlans;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<PlanComment> planComments;
	
	@JsonIgnore
	@OneToMany(mappedBy="sender")
	private List<Message> sentMessages;
	
	@JsonIgnore
	@OneToMany(mappedBy="receiver")
	private List<Message> receivedMessages;
	
	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public List<MealComment> getMealComments() {
		return mealComments;
	}

	public void setMealComments(List<MealComment> mealComments) {
		this.mealComments = mealComments;
	}

	public List<GroceryItem> getGroceries() {
		return groceries;
	}

	public void setGroceries(List<GroceryItem> groceries) {
		this.groceries = groceries;
	}

	public List<MealReview> getMealReviews() {
		return mealReviews;
	}

	public void setMealReviews(List<MealReview> mealReviews) {
		this.mealReviews = mealReviews;
	}


	public List<Meal> getFavoriteMeals() {
		return favoriteMeals;
	}

	public void setFavoriteMeals(List<Meal> favoriteMeals) {
		this.favoriteMeals = favoriteMeals;
	}

	public List<MealPlan> getFavoriteMealPlans() {
		return favoriteMealPlans;
	}

	public void setFavoriteMealPlans(List<MealPlan> favoriteMealPlans) {
		this.favoriteMealPlans = favoriteMealPlans;
	}

	public List<PlanReview> getPlanReviews() {
		return planReviews;
	}

	public void setPlanReviews(List<PlanReview> planReviews) {
		this.planReviews = planReviews;
	}

	public List<Meal> getUserMeals() {
		return userMeals;
	}

	public void setUserMeals(List<Meal> userMeals) {
		this.userMeals = userMeals;
	}

	public List<MealPlan> getUserMealPlans() {
		return userMealPlans;
	}

	public void setUserMealPlans(List<MealPlan> userMealPlans) {
		this.userMealPlans = userMealPlans;
	}

	public List<PlanComment> getPlanComments() {
		return planComments;
	}

	public void setPlanComments(List<PlanComment> planComments) {
		this.planComments = planComments;
	}

	public List<Message> getSentMessages() {
		return sentMessages;
	}

	public void setSentMessages(List<Message> sentMessages) {
		this.sentMessages = sentMessages;
	}

	public List<Message> getReceivedMessages() {
		return receivedMessages;
	}

	public void setReceivedMessages(List<Message> receivedMessages) {
		this.receivedMessages = receivedMessages;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + "]";
	}

}
