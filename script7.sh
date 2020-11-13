#! /big/bash

#11111
function Show_all_disk(){
        ls -l /dev/sd*
}

#222222

function Show_disk_space(){

        df -Th | grep -Eo "Filesystem.*" && df -Th | grep sd.*
}


#33333

function Add_new_portition_on_disk(){
   
         exit=true
    while [[ $exit == true ]]
    do
        echo -e "a. Add portition\nb. Make file system\nc. Mount to folder\n0. Exit"
        read item
        case $item in
        a) 
    read -r -p "Which disk you add portition (exampel - sdb): " disk
    re='^[a-z]+$'
        if ! [[ $disk =~ $re ]]; then
        echo " error " 
        fi
    read -r -p "Enter what kind of portions you wont(p - primery e-extendent l -logicoll) " portition
    if ! [[ $portition =~ p || $portition =~ e || $portition =~ l ]]; then
    scho " Not correct kind of partitions "
    fi
    read -r -p "Enter size off portions " size

    echo "n
    $portition
    
    
    +$size
    w" | sudo fdisk /dev/$disk
        ;;
        b) 

        read -r -p "Enter portition " portition
        echo " btrfs, xfs , reiserfs , reiser4 , jfs , ext3, ext4, btrfs "
        read -r -p "Enter file system " fill
        if [[ $fill == btrfs || $fill == xfs || $fill == reiserfs || $fill == reiser4 || $fill == jfs || $fill == ext3 || $fill == ext4 || $fill == btrfs ]];
        then
        mkfs.$fill /dev/$portition
        else
        echo " Default  ext4"
         mkfs.$fill /dev/ext4
        fi
        ;;
        c)

        read -r -p "Enter mount portition  for mount (exampl - sdb1) " part
        read -r -p "Enter name of folder to  mount ( exampl - /homa/doc1 ) " folder
        mount /dev/$part $folder
         ;;
        0) exit=false
            echo "Good bay";;
        *) echo "Eroor invalid item"
            exit 1
        esac
    done
}

#444444
function Edit_fstab(){
     read -r -p "Enter portition " portition
q="$(blkid | grep $portition | awk '{ print $2 }' | sed 's/\"//g')"
s="$(blkid | grep $portition | grep "TYPE=" | awk '{ print $3 }' | sed 's/\TYPE="//g' | sed 's/\"//g')"
c="$(df -Th | grep $portition | awk '{ print $7 }')"
 if cat /etc/fstab | grep -Eo "$q";
 then
 echo " This UUID alredy available"
 else

echo "$q $c       $s    defaults     0 0" >> /etc/fstab
 fi
}
#5
function Restart_system(){
     
    reboot
}

function Menu(){
    exit=true
    while [[ $exit == true ]]
    do
        echo -e "1. Show all disk (ls -l /dev/sd*)\n2.Show disk space\n3. Add new portition on disk\n4. Edit fstab\n5.Restart system\n6. Exit"
        read -r -p "  " item
        case $item in
        1) Show_all_disk $Show_all_disk;
        ;;
        2)Show_disk_space $Show_disk_space
    # echo "function user dell"
        ;;
        3)Add_new_portition_on_disk $Add_new_portition
        ;;
        4)Edit_fstab $Edit_fstab

        #echo "Create group (with gid)"
        ;;
        5)Restart_system $Restart_system
         #echo "Add user to group"
        ;;
        6) exit=false
            echo "Good bay";;
        *) echo "Eroor invalid item"
            exit 1
        esac
    done
}

Menu;