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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "meal_plan")
public class MealPlan {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	private String description;

	private boolean enabled;

	@Column(name = "public")
	private boolean visible;

	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@UpdateTimestamp
	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	@JsonIgnore
	@ManyToMany(mappedBy = "favoriteMealPlans")
	List<User> usersWithFavMealPlans;
	
	@JsonIgnoreProperties({"password","enabled","role","email","createdAt", "updatedAt", "aboutMe",
		"firstName","lastName","imageUrl","mealComments", "groceries", "mealReviews", "userMeals",
		"favoriteMeals", "favoriteMealPlans", "planReviews", "userMealPlans",
		"planComments", "sentMessages", "receivedMessages"})
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User planCreator;

	@JsonIgnore
	@ManyToMany(mappedBy = "mealPlansWithDiets")
	private List<Diet> diets;

	@JsonIgnore
	@OneToMany(mappedBy = "mealPlan")
	private List<PlanComment> planComments;

	@JsonIgnore
	@OneToMany(mappedBy = "mealPlan")
	private List<PlanReview> planReviews;

	@JsonIgnoreProperties({"imgUrl","createdAt","updatedAt"})
	@ManyToMany(mappedBy = "mealPlans")
	private List<Meal> meals;

	// ADD AND REMOVE METHODS FOR MEALS NEED TO BE ADDED
	
	@ManyToOne
	@JoinColumn(name = "copied_from_id")
	private MealPlan copiedFromPlan;

	@JsonIgnore
	@OneToMany(mappedBy = "copiedFromPlan")
	private List<MealPlan> myCopies;

	public MealPlan() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public List<User> getUsersWithFavMealPlans() {
		return usersWithFavMealPlans;
	}

	public void setUsersWithFavMealPlans(List<User> usersWithFavMealPlans) {
		this.usersWithFavMealPlans = usersWithFavMealPlans;
	}

	public User getPlanCreator() {
		return planCreator;
	}

	public void setPlanCreator(User planCreator) {
		this.planCreator = planCreator;
	}

	public List<Diet> getDiets() {
		return diets;
	}

	public void setDiets(List<Diet> diets) {
		this.diets = diets;
	}

	public List<PlanComment> getPlanComments() {
		return planComments;
	}

	public void setPlanComments(List<PlanComment> planComments) {
		this.planComments = planComments;
	}

	public List<PlanReview> getPlanReviews() {
		return planReviews;
	}

	public void setPlanReviews(List<PlanReview> planReviews) {
		this.planReviews = planReviews;
	}

	public List<Meal> getMeals() {
		return meals;
	}

	public void setMeals(List<Meal> meals) {
		this.meals = meals;
	}
	
	public void addMeal(Meal meal) {
		if (meals == null) meals = new ArrayList<>();
		if (!meals.contains(meal)) {
			meals.add(meal);
			meal.addMealPlan(this);
		}
	}
	
	public void removeMeal(Meal meal) {
		if(meals != null && meals.contains(meal)) {
			meals.remove(meal);
			meal.removeMealPlan(this);
		}
	}

	public MealPlan getCopiedFromPlan() {
		return copiedFromPlan;
	}

	public void setCopiedFromPlan(MealPlan copiedFromPlan) {
		this.copiedFromPlan = copiedFromPlan;
	}

	public List<MealPlan> getMyCopies() {
		return myCopies;
	}

	public void setMyCopies(List<MealPlan> myCopies) {
		this.myCopies = myCopies;
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
		MealPlan other = (MealPlan) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "MealPlan [id=" + id + ", title=" + title + ", description=" + description + ", enabled=" + enabled
				+ ", visible=" + visible + ",meals=" + meals +  "]";
	}

}
