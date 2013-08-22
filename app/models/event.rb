class Event < ActiveRecord::Base
  before_save :calc_duration
  attr_accessible :category, :course_id, :description, :duration, :start_time, :end_time, :instructor, :location, :status, :timeslot_ids, :person_ids
 
  def end_date_cannot_be_before_start
    if ((!end_time.blank?) and (!start_time.blank?)) and end_time < start_time
      errors.add(:end_time, "must be after the start, unless you are the Doctor")
    end
  end
  
  validates_presence_of :category, :description
  validate :end_date_cannot_be_before_start
  
  belongs_to :course
  has_many :timeslots
  has_many :people, :through => :timeslots
  
  #CATEGORY_CHOICES = ['Class', 'Patrol', 'Admin', 'Call-out', 'SAR']
  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting', 'Admin', 'Event']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled']

  def to_s
    description
  end

  def calc_duration #This is also used in timeslots; it should be extracted out
     if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end 
  end

end
