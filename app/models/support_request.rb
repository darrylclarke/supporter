class SupportRequest < ActiveRecord::Base
	validates :name,  presence: true
	validates :email, presence: true
	
	@@search_for = ""
	#after_create :set_done_false
	
	def self.get_search_string
		@@search_for
	end
	
	def self.set_search_string( s )
		@@search_for = s
	end
	
	def self.search( word )
		where( ["name ILIKE :aword OR email ILIKE :aword OR message ILIKE :aword", {aword: "%#{word}%"}])
	end

	
private

	# def set_done_false
	# 	self.done ||= false 
	# end
end
