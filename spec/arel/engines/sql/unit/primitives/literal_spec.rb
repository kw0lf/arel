require File.join(File.dirname(__FILE__), '..', '..', '..', '..', '..', 'spec_helper')

module Arel
  describe SqlLiteral do
    before do
      @relation = Table.new(:users)
    end

    describe '#to_sql' do
      it "manufactures sql with a literal SQL fragment" do
        sql = @relation.project(Count.new(SqlLiteral.new("*"))).to_sql

        adapter_is :mysql do
          sql.should be_like(%Q{SELECT COUNT(*) AS count_id FROM `users`})
        end

        adapter_is_not :mysql do
          sql.should be_like(%Q{SELECT COUNT(*) AS count_id FROM "users"})
        end
      end
    end
  end
end
