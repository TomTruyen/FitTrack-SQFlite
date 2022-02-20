/// *** GENERATED FILE - ANY CHANGES WOULD BE OBSOLETE ON NEXT GENERATION *** ///
/// Helper to test coverage for all project files
// ignore_for_file: unused_import
import 'package:fitoryx/data/category_list.dart';
import 'package:fitoryx/data/equipment_list.dart';
import 'package:fitoryx/data/exercise_list.dart';
import 'package:fitoryx/data/type_list.dart';
import 'package:fitoryx/firebase_options.dart';
import 'package:fitoryx/graphs/exercise_detail_graph.dart';
import 'package:fitoryx/graphs/measurement_graph.dart';
import 'package:fitoryx/graphs/models/exercise_graph_type.dart';
import 'package:fitoryx/graphs/models/nutrition_tooltip.dart';
import 'package:fitoryx/graphs/nutrition_calories_graph.dart';
import 'package:fitoryx/graphs/nutrition_graph.dart';
import 'package:fitoryx/graphs/nutrition_macro_graph.dart';
import 'package:fitoryx/graphs/placeholder_graph.dart';
import 'package:fitoryx/graphs/volume_graph.dart';
import 'package:fitoryx/graphs/workouts_per_week_graph.dart';
import 'package:fitoryx/main.dart';
import 'package:fitoryx/models/body_weight.dart';
import 'package:fitoryx/models/exercise.dart';
import 'package:fitoryx/models/exercise_filter.dart';
import 'package:fitoryx/models/exercise_set.dart';
import 'package:fitoryx/models/exercise_type.dart';
import 'package:fitoryx/models/fat_percentage.dart';
import 'package:fitoryx/models/graph_goal.dart';
import 'package:fitoryx/models/graph_type.dart';
import 'package:fitoryx/models/nutrition.dart';
import 'package:fitoryx/models/popup_option.dart';
import 'package:fitoryx/models/settings.dart';
import 'package:fitoryx/models/settings_item.dart';
import 'package:fitoryx/models/settings_type.dart';
import 'package:fitoryx/models/subscription.dart';
import 'package:fitoryx/models/unit_type.dart';
import 'package:fitoryx/models/workout.dart';
import 'package:fitoryx/models/workout_history.dart';
import 'package:fitoryx/providers/subscription_provider.dart';
import 'package:fitoryx/providers/workout_change_notifier.dart';
import 'package:fitoryx/revenue_cat_keys.dart';
import 'package:fitoryx/screens/exercises/add_exercise_page.dart';
import 'package:fitoryx/screens/exercises/exercises_page.dart';
import 'package:fitoryx/screens/exercises/exercise_detail_page.dart';
import 'package:fitoryx/screens/exercises/exercise_filter_page.dart';
import 'package:fitoryx/screens/exercises/exercise_graphs_view.dart';
import 'package:fitoryx/screens/exercises/exercise_records_view.dart';
import 'package:fitoryx/screens/history/history_calendar_page.dart';
import 'package:fitoryx/screens/history/history_detail_page.dart';
import 'package:fitoryx/screens/history/history_page.dart';
import 'package:fitoryx/screens/measurement/add_nutrition_page.dart';
import 'package:fitoryx/screens/measurement/body_weight_page.dart';
import 'package:fitoryx/screens/measurement/fat_percentage_page.dart';
import 'package:fitoryx/screens/measurement/measurement_page.dart';
import 'package:fitoryx/screens/measurement/nutrition_page.dart';
import 'package:fitoryx/screens/profile/profile_page.dart';
import 'package:fitoryx/screens/settings/nutrition_goals_page.dart';
import 'package:fitoryx/screens/settings/settings_page.dart';
import 'package:fitoryx/screens/sign_in.dart';
import 'package:fitoryx/screens/sign_up.dart';
import 'package:fitoryx/screens/subscription/subscription_overview_page.dart';
import 'package:fitoryx/screens/subscription/subscription_page.dart';
import 'package:fitoryx/screens/subscription/subscription_pricing_page.dart';
import 'package:fitoryx/screens/workout/build_workout_page.dart';
import 'package:fitoryx/screens/workout/complete_workout_page.dart';
import 'package:fitoryx/screens/workout/rest_timer_page.dart';
import 'package:fitoryx/screens/workout/start_workout_page.dart';
import 'package:fitoryx/screens/workout/workout_page.dart';
import 'package:fitoryx/screens/wrapper.dart';
import 'package:fitoryx/services/auth_service.dart';
import 'package:fitoryx/services/cache_service.dart';
import 'package:fitoryx/services/connection_service.dart';
import 'package:fitoryx/services/firestore_service.dart';
import 'package:fitoryx/services/purchase_service.dart';
import 'package:fitoryx/services/settings_service.dart';
import 'package:fitoryx/utils/datetime_extension.dart';
import 'package:fitoryx/utils/double_extension.dart';
import 'package:fitoryx/utils/graph_type_extension.dart';
import 'package:fitoryx/utils/history_list_extension.dart';
import 'package:fitoryx/utils/int_extension.dart';
import 'package:fitoryx/utils/string_extension.dart';
import 'package:fitoryx/utils/utils.dart';
import 'package:fitoryx/widgets/alert.dart';
import 'package:fitoryx/widgets/complete_button.dart';
import 'package:fitoryx/widgets/complete_workout_card.dart';
import 'package:fitoryx/widgets/confirm_alert.dart';
import 'package:fitoryx/widgets/delete_button.dart';
import 'package:fitoryx/widgets/dropdown.dart';
import 'package:fitoryx/widgets/exercise_item.dart';
import 'package:fitoryx/widgets/exercise_record_row.dart';
import 'package:fitoryx/widgets/exercise_row.dart';
import 'package:fitoryx/widgets/filter_item.dart';
import 'package:fitoryx/widgets/filter_list.dart';
import 'package:fitoryx/widgets/form_input.dart';
import 'package:fitoryx/widgets/google_button.dart';
import 'package:fitoryx/widgets/gradient_button.dart';
import 'package:fitoryx/widgets/gradient_floating_action_button.dart';
import 'package:fitoryx/widgets/graph_card.dart';
import 'package:fitoryx/widgets/list_divider.dart';
import 'package:fitoryx/widgets/loader.dart';
import 'package:fitoryx/widgets/macro_progress.dart';
import 'package:fitoryx/widgets/manage_subscription_button.dart';
import 'package:fitoryx/widgets/nutrition_history_card.dart';
import 'package:fitoryx/widgets/popup_menu.dart';
import 'package:fitoryx/widgets/popup_menu_option.dart';
import 'package:fitoryx/widgets/settings_group.dart';
import 'package:fitoryx/widgets/sort_button.dart';
import 'package:fitoryx/widgets/subscription_card.dart';
import 'package:fitoryx/widgets/subscription_feature.dart';
import 'package:fitoryx/widgets/subscription_icon.dart';
import 'package:fitoryx/widgets/time_header_row.dart';
import 'package:fitoryx/widgets/time_set_row.dart';
import 'package:fitoryx/widgets/weight_header_row.dart';
import 'package:fitoryx/widgets/weight_set_row.dart';
import 'package:fitoryx/widgets/workout_exercise_card.dart';
import 'package:fitoryx/widgets/workout_timer.dart';
void main() {}
