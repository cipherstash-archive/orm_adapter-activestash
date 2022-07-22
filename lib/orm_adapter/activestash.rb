require "active_stash/search"
require "orm_adapter"

class ActiveStash::Search::OrmAdapter < OrmAdapter::Base
	def find_first(options = {})
		cs_fields, db_fields, _options = discriminate_options(options)

		records = nil

		if db_fields.empty?
			klass.query(cs_fields)
				.first
		else
			if cs_fields.empty?
				OrmAdapter::ActiveRecord.new(klass).find_first(options)
			else
				stash_ids = klass.query(cs_fields).map(&:uuid)
				OrmAdapter::ActiveRecord.new(klass).find_first(db_fields.merge(stash_id: stash_ids))
			end
		end
	end

	def get!(id)
		OrmAdapter::ActiveRecord.new(klass).get!(id)
	end

	def get(id)
		OrmAdapter::ActiveRecord.new(klass).get(id)
	end

	private

	def discriminate_options(opts)
		cs_fields = {}
		db_fields = {}
		options = {}

		fields, _order, _limit, _offset = extract_conditions!(opts)

		fields.each do |k, v|
			if klass.stash_indexes.on(k).empty?
				db_fields[k] = v
			else
				cs_fields[k] = v
			end
		end

		[cs_fields, db_fields, options]
	end
end
