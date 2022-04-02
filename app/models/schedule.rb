# frozen_string_literal: true

require 'sav/helpers/hashes/convert_array_to_hash'

class ScheduleStatus
  STATUSES = %w[open cancelled finished].freeze

  def initialize(status)
    @status = status
  end
end

class Schedule < ApplicationRecord
  include Sav::Helpers::Hashes
  # STATUSES = %w[open cancelled finished].freeze

  enum status: ConvertArrayToHash.new(ScheduleStatus::STATUSES).value, _suffix: true

  belongs_to :client
  belongs_to :user

  # def status
  #   @status ||= ScheduleStatus.new(read_attribute(:status))
  # end
end
