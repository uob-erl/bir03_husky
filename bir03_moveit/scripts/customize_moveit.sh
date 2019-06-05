if [ $# == 1 ]
then
  echo "Creating Directory <" $PWD"/"$1 ">"
  mkdir "$1"
  cd "$1"

  echo "Copying Single UR Moveit Config"
  cp -r $(catkin_find bir03_moveit)/. .
  echo "Updating Package"
  grep -rli 'bir03_moveit' * | xargs -i@ sed -i 's/bir03_moveit/'$1'/g' @
  echo "Done"

else
  echo "USAGE: customize_moveit.sh [new_moveit_package_name]"
fi
