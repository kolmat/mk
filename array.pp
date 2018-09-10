# Class: name
#
#
class joiner (
  $_options = [],
) {
  # resources
}
$_options = [
  '-u chrony',
  '-d dony',
  '-c cool',
]
$options = inline_template("<%=@_options.join(' ')  %>")
notice($options)

include joiner
