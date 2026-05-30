part of 'add_tasks_view.dart';

class AddTasksViewController extends GetxController {
  var taskSerive = TasksSerevice();
  var nameCtrl = TextEditingController();
  var desCtrl = TextEditingController();

  var isLoading = false.obs;
  var nameFocus = FocusNode();
  var args = Get.arguments;

  var selectedPriority = ''.obs;
  var startDate = Rxn<DateTime>();
  var dueDate = Rxn<DateTime>();

  final List<String> priorities = [
    'High Priority',
    'Medium Priority',
    'Low Priority',
  ];

  String formatDate(DateTime? date) {
    if (date == null) return 'Optional';
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) startDate.value = picked;
  }

  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dueDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) dueDate.value = picked;
  }

  void createTasks() async {
    if (nameCtrl.text.isNotEmpty && desCtrl.text.isNotEmpty) {
      isLoading.value = true;
      var response = await taskSerive.createTasks(
        name: nameCtrl.text,
        description: desCtrl.text,
      );
      isLoading.value = false;
      if (response["result"] == true) {
        nameFocus.requestFocus();
        Get.snackbar("Success", "Tasks Created");
        nameCtrl.clear();
        desCtrl.clear();
        selectedPriority.value = '';
        startDate.value = null;
        dueDate.value = null;
      }
    } else {
      Get.snackbar("Failed", "Tasks Failed");
    }
  }

  void updateTask() async {
    if (nameCtrl.text.isNotEmpty && desCtrl.text.isNotEmpty) {
      try {
        isLoading.value = true;
        var response = await taskSerive.updateTask(
          id: args["id"],
          name: nameCtrl.text,
          description: desCtrl.text,
        );
        if (response["result"] == true) {
          Get.back();
          Get.snackbar("Success", "Tasks Update");
          isLoading.value = false;
        } else {
          Get.snackbar("Failed", "Tasks Failed");
        }
      } catch (e) {
        Get.snackbar("Failed", "Tasks Failed");
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      nameCtrl.text = args["name"];
      desCtrl.text = args["description"];
      if (args["priority"] != null) {
        selectedPriority.value = args["priority"];
      }
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    desCtrl.dispose();
    nameFocus.dispose();
    super.onClose();
  }
}
