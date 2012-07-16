class TestCourses < ActiveRecord::Migration
  def change
    execute "INSERT INTO `courses` VALUES ('116', 'Analytical Mechanics I', 'FALL 2012', 'APSC', '36846', 'OPEN', 'APSC2057', '11', '3.00', 'Li, T', 'FNGR208', 'Tue, Thu', '15:45:00', '17:00:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('117', 'Engineering Analysis I', 'FALL 2012', 'APSC', '30043', 'OPEN', 'APSC2113', '10', '3.00', '', 'PHILB152', 'Mon, Wed', '15:45:00', '17:00:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('118', 'Engineering Analysis I', 'FALL 2012', 'APSC', '34015', 'OPEN', 'APSC2113', '12', '3.00', 'Haque, M', 'ROME204', 'Wed, Fri', '14:20:00', '15:35:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('119', 'Engineering Analysis III', 'FALL 2012', 'APSC', '30044', 'CLOSED', 'APSC3115', '10', '3.00', 'Blackford, J', '1776 G104', 'Mon, Wed', '11:10:00', '12:25:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('120', 'Analytical Mechanics I', 'FALL 2012', 'APSC', '31377', 'CLOSED', 'APSC2057', '10', '3.00', 'Silva, P', 'ROME351', 'Tue, Thu', '15:45:00', '17:00:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('121', 'Analytical Mechanics II', 'FALL 2012', 'APSC', '34443', 'OPEN', 'APSC2058', '10', '3.00', '', 'COR106', 'Tue', '11:10:00', '12:00:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('122', 'Engineering Analysis I', 'FALL 2012', 'APSC', '30042', 'OPEN', 'APSC2113', '11', '3.00', 'Haque, M', 'ROME204', 'Tue, Thu', '09:35:00', '10:50:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('123', 'Materials Science', 'FALL 2012', 'APSC', '33285', 'OPEN', 'APSC2130', '10', '3.00', 'Imam, M', 'TOMP204', 'Wed', '18:10:00', '20:40:00', '2012-08-28', '2012-12-07', '');"
	execute "INSERT INTO `courses` VALUES ('124', 'Engineering Analysis III', 'FALL 2012', 'APSC', '33231', 'OPEN', 'APSC3115', '11', '3.00', 'van Dorp, J', '1776 G101', 'Tue, Thu', '14:20:00', '15:35:00', '2012-08-28', '2012-12-07', '');"
	
  end
end
