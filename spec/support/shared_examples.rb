# NB: RSpec runs each example within a transaction that is rolled back at the end of
# each test without being committed to the database. This is due to the fact that
# we have `use_transactional_fixtures = true`, which is the preferred default configuration.
# Unfortunately, MySQL does not update the full text indices for our table until after a
# transaction is committed. Since a transaction is not happening by default within each test
# and our searching is dependent on a transaction updating our MySQL indices, then any
# tests relying on the searching capability will not work by default. As a workaround, we
# need to ensure the record creation is committed to the database prior to the tests running.
# This is not an ideal solution, especially if this setup needs to be later copied around
# the code base or if we begin to manipulate records in between tests. We will need to
# find a more sustainable, long term solution in future.
shared_context "videos created and indexed" do
  before(:all) do
    @matchstick_men = FactoryBot.create(:video, :matchstick_men)
    @yoshimi_battles = FactoryBot.create(:video, :yoshimi_battles)
  end

  before(:each) do
    @matchstick_men.reload
    @yoshimi_battles.reload
  end

  after(:all) { Video.destroy_all }
end

