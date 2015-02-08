class CriminalHistoriesController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :criminal_histories
  end

  def first_item
    @applicant.criminal_histories.first
  end

  def last_item
    @applicant.criminal_histories.last
  end

  def make_new
    c = CriminalHistory.new
    c.person = @applicant.identity
    c.crime_type = CrimeType.where(name: "felony").first
    c
  end

  def set_model
    @model = CriminalHistory.find(params[:id])
  end

  def edit_model item
    edit_applicant_criminal_history_path(@applicant, item)
  end

  def model_params
    params.require(:criminal_history).permit(:person_id, :crime_type_id, :description, :year)
  end

  def next_page
    find_next_page @applicant.criminal_histories, @model, :edit_model
  end

  def front_of_next_section
    # Criminal history is the last section, so send the user back to the summary page
    @applicant
  end

  def back_of_previous_section
    edit_employment_path(@applicant.employments.last)
  end
end