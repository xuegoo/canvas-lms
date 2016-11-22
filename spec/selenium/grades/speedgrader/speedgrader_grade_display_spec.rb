require_relative "../../common"
require_relative "../../helpers/speed_grader_common"
require_relative "../page_objects/speedgrader_page"

describe "speed grader - grade display" do
  include_context "in-process server selenium tests"
  include SpeedGraderCommon

  before(:each) do
    course_with_teacher_logged_in
    @assignment = @course.assignments.create(name: 'assignment', points_possible: 10)
  end

  it "displays the score on the sidebar", priority: "1", test_id: 283993 do
    create_and_enroll_students(1)
    submit_and_grade_homework(@students[0], 3)

    Speedgrader.visit(@course, @assignment)
    expect(Speedgrader.grade_value).to eq "3"
  end

  it "displays total number of graded assignments to students", priority: "1", test_id: 283994 do
    create_and_enroll_students(2)
    submit_and_grade_homework(@students[0], 3)

    Speedgrader.visit(@course, @assignment)
    expect(Speedgrader.fraction_graded).to include_text("1/2")
  end

  it "displays average submission grade for total assignment submissions", priority: "1", test_id: 283995
end
