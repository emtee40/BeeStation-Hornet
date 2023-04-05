//LISTS - CAN NOT DO VV_DO_TOPIC BECAUSE LISTS AREN'T DATUMS :(
/client/proc/vv_do_list(list/target, href_list)
	var/target_index = text2num(GET_VV_VAR_TARGET)
	if(check_rights(R_VAREDIT))
		if(target_index)
			if(href_list[VV_HK_LIST_EDIT])
				mod_list(target, null, "list", "contents", target_index, autodetect_class = TRUE)
			if(href_list[VV_HK_LIST_CHANGE])
				mod_list(target, null, "list", "contents", target_index, autodetect_class = FALSE)
			if(href_list[VV_HK_LIST_REMOVE])
				var/variable = target[target_index]
				var/prompt = alert("Do you want to remove item number [target_index] from list?", "Confirm", "Yes", "No")
				if (prompt != "Yes")
					return
				target.Cut(target_index, target_index+1)
				log_world("### ListVarEdit by [src]: /list's contents: REMOVED=[html_encode("[variable]")]")
				log_admin("[key_name(src)] modified list's contents: REMOVED=[variable]")
				message_admins("[key_name_admin(src)] modified list's contents: REMOVED=[variable]")
		if(href_list[VV_HK_LIST_ADD])
			mod_list_add(target, null, "list", "contents")
		if(href_list[VV_HK_LIST_ERASE_DUPES])
			unique_list_in_place(target)
			log_world("### ListVarEdit by [src]: /list contents: CLEAR DUPES")
			log_admin("[key_name(src)] modified list's contents: CLEAR DUPES")
			message_admins("[key_name_admin(src)] modified list's contents: CLEAR DUPES")
		if(href_list[VV_HK_LIST_ERASE_NULLS])
			list_clear_nulls(target)
			log_world("### ListVarEdit by [src]: /list contents: CLEAR NULLS")
			log_admin("[key_name(src)] modified list's contents: CLEAR NULLS")
			message_admins("[key_name_admin(src)] modified list's contents: CLEAR NULLS")
		if(href_list[VV_HK_LIST_SET_LENGTH])
			var/value = vv_get_value(VV_NUM)
			if (value["class"] != VV_NUM || value["value"] > max(50000, target.len))			//safety - would rather someone not put an extra 0 and erase the server's memory lmao.
				return
			target.len = value["value"]
			log_world("### ListVarEdit by [src]: /list len: [target.len]")
			log_admin("[key_name(src)] modified list's len: [target.len]")
			message_admins("[key_name_admin(src)] modified list's len: [target.len]")
		if(href_list[VV_HK_LIST_SHUFFLE])
			shuffle_inplace(target)
			log_world("### ListVarEdit by [src]: /list contents: SHUFFLE")
			log_admin("[key_name(src)] modified list's contents: SHUFFLE")
			message_admins("[key_name_admin(src)] modified list's contents: SHUFFLE")
