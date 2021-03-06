# frozen_string_literal: true

###############
# Plans     #
###############

Stripe::Plan.find_or_create_by_id(
  'anonymous-plan',
  amount: 0,
  interval: 'month',
  name: 'Anonymous Plan',
  currency: 'usd'
)
PaidUp::Plan.create(
  title: 'Anonymous',
  stripe_id: 'anonymous-plan',
  description: 'What you can do without logging in.',
  sort_order: -1
)
Stripe::Plan.find_or_create_by_id(
  'free-plan',
  amount: 0,
  interval: 'month',
  name: 'Free Plan',
  currency: 'usd'
)
free_plan = PaidUp::Plan.create(
  title: 'Free',
  stripe_id: 'free-plan',
  description: "Can't beat the price!",
  sort_order: 0
)
Stripe::Plan.find_or_create_by_id(
  'no-ads-plan',
  amount: 100,
  interval: 'month',
  name: 'No Ads Plan',
  currency: 'usd'
)
no_ads_plan = PaidUp::Plan.create(
  title: 'No Ads',
  stripe_id: 'no-ads-plan',
  description: 'No frills, just removes the ads.',
  sort_order: 1
)
Stripe::Plan.find_or_create_by_id(
  'group-leader-plan',
  amount: 500,
  interval: 'month',
  name: 'Group Leader Plan',
  currency: 'usd'
)
group_leader_plan = PaidUp::Plan.create(
  title: 'Group Leader',
  stripe_id: 'group-leader-plan',
  description: 'For leaders of single groups, with configuration.',
  sort_order: 2
)
Stripe::Plan.find_or_create_by_id(
  'professional-plan',
  amount: 1000,
  interval: 'month',
  name: 'Professional Plan',
  currency: 'usd'
)
professional_plan = PaidUp::Plan.create(
  title: 'Professional',
  stripe_id: 'professional-plan',
  description: 'Designed for professionals with unlimited groups, a calendar '\
                 'and configuration.',
  sort_order: 3
)

###############
# Coupons     #
###############

Stripe::Coupon.find_or_create_by_id(
  '25OFF',
  percent_off: 25,
  currency: 'usd',
  duration: 'forever'
)

Stripe::Coupon.find_or_create_by_id(
  'MINUS25',
  amount_off: 25,
  currency: 'usd',
  duration: 'forever'
)

######################
# Anonymous Customer #
######################
Stripe::Customer.find_or_create_by_id(
  'anonymous-customer',
  description: 'Anonymous Customer',
  plan: 'anonymous-plan'
)
#######################
# PlanFeatureSettings #
#######################

# Free
PaidUp::PlanFeatureSetting.create(
  feature: 'posts',
  plan: free_plan,
  setting: 3
)

# Ad Free
PaidUp::PlanFeatureSetting.create(
  feature: 'ad_free',
  plan: no_ads_plan,
  setting: 1
)
PaidUp::PlanFeatureSetting.create(
  feature: 'posts',
  plan: no_ads_plan,
  setting: 5
)

# Group Leader
PaidUp::PlanFeatureSetting.create(
  feature: 'ad_free',
  plan: group_leader_plan,
  setting: 1
)
PaidUp::PlanFeatureSetting.create(
  feature: 'groups',
  plan: group_leader_plan,
  setting: 5
)
PaidUp::PlanFeatureSetting.create(
  feature: 'doodads',
  plan: group_leader_plan,
  setting: 10
)
PaidUp::PlanFeatureSetting.create(
  feature: 'posts',
  plan: group_leader_plan,
  setting: 10
)

# Professional
PaidUp::PlanFeatureSetting.create(
  feature: 'ad_free',
  plan: professional_plan,
  setting: 1
)
PaidUp::PlanFeatureSetting.create(
  feature: 'groups',
  plan: professional_plan,
  setting: PaidUp::Unlimited.to_i(:db)
)
PaidUp::PlanFeatureSetting.create(
  feature: 'doodads',
  plan: professional_plan,
  setting: PaidUp::Unlimited.to_i(:db)
)
PaidUp::PlanFeatureSetting.create(
  feature: 'posts',
  plan: professional_plan,
  setting: 25
)

###############
# Users     #
###############

free_subscriber = FactoryBot.create(
  :user,
  name: 'Free Subscriber',
  plan: free_plan
)

FactoryBot.create(
  :user,
  name: 'No Ads Subscriber',
  plan: no_ads_plan
)

leader_subscriber = FactoryBot.create(
  :user,
  name: 'Group Leader Subscriber',
  plan: group_leader_plan
)

disabling_subscriber = FactoryBot.create(
  :user,
  name: 'Disabling Subscriber',
  plan: group_leader_plan
)

prof_subscriber = FactoryBot.create(
  :user,
  name: 'Professional Subscriber',
  plan: professional_plan
)

FactoryBot.create(
  :user,
  name: 'Blank Subscriber',
  plan: professional_plan
)

past_due_subscriber = FactoryBot.create(
  :user,
  name: 'Past Due Subscriber',
  plan: professional_plan,
  past_due: true
)

###############
# Groups    #
###############

FactoryBot.create(
  :group,
  title: 'First Group',
  owner: leader_subscriber,
  active: true
)

FactoryBot.create(
  :group,
  title: 'Inactive Group',
  owner: leader_subscriber,
  active: false
)

FactoryBot.create(
  :group,
  title: 'Second Group',
  owner: prof_subscriber,
  active: true
)

FactoryBot.create(
  :group,
  title: 'Third Group',
  owner: prof_subscriber,
  active: true
)

FactoryBot.create_list(:group, 5, owner: disabling_subscriber, active: true)
FactoryBot.create_list(:doodad, 10, user: disabling_subscriber)
FactoryBot.create_list(:post, 10, user: disabling_subscriber, active: true)

FactoryBot.create(
  :group,
  title: 'Disabled Group',
  owner: disabling_subscriber,
  active: true
)

FactoryBot.create(
  :group,
  title: 'Past Due Group',
  owner: past_due_subscriber,
  active: true
)

###############
# Posts       #
###############

FactoryBot.create(
  :post,
  title: 'First Post',
  user: free_subscriber,
  active: true
)

FactoryBot.create(
  :post,
  title: 'Active Post',
  user: free_subscriber,
  active: true
)

FactoryBot.create(
  :post,
  title: 'Inactive Post',
  user: free_subscriber,
  active: false
)

FactoryBot.create(
  :post,
  title: 'Still Enabled Post',
  user: free_subscriber,
  active: true
)

FactoryBot.create(
  :post,
  title: 'No Longer Enabled Post',
  user: free_subscriber,
  active: true
)
