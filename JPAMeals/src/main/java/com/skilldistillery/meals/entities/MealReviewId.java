package com.skilldistillery.meals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
@Embeddable
public class MealReviewId implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Column(name = "meal_id")
	private int mealId;

	@Column(name = "user_id")
	private int userId;
	
	public MealReviewId() {
		
	}

    
	public MealReviewId(int mealId,int userId) {
		  this.mealId = mealId;
	        this.userId = userId;
	}

	public int getMealId() {
		return mealId;
	}

	public void setMealId(int mealId) {
		this.mealId = mealId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(mealId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MealReviewId other = (MealReviewId) obj;
		return mealId == other.mealId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "MealReviewId [mealId=" + mealId + ", userId=" + userId + "]";
	}
	
	
	
	
}
