class TimeslotsController < ApplicationController
  def update
    if params[:class] == "Profile" && params[:id].to_i == current_user.id
      profile = Profile.find(params[:id])
      profile.timeslots.destroy_all
      times = create_timeslots(profile, params[:timeslots])
      if profile.save
        render json: times
      else
        render nothing: true
      end
    else
      render nothing: true
    end

  end

  private

  def create_timeslots(profile, timeslots)
    JSON.parse(timeslots).each do |slot|
      start_time = Time.at(slot['start_time']).utc
      end_time = Time.at(slot['end_time']).utc
      new_timeslot = Timeslot.find_or_create_by(start_time: start_time, end_time: end_time)
      new_day = Day.find_by(name: slot['day'])
      DayTimeslot.find_or_create_by(day_id: new_day.id, timeslot_id: new_timeslot.id,
        owner_id: profile.id, owner_type: profile.class)
    end

    profile.times
  end
end
