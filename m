Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04D7D6E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfHAIFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 04:05:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfHAIFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:05:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E83CA1EA9312ABEAB26;
        Thu,  1 Aug 2019 16:04:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 16:04:39 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix livelock in swapfile writes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190731204353.62056-1-jaegeuk@kernel.org>
 <f500dafa-19f4-78ff-2645-2239fbf43eab@huawei.com>
 <20190801042650.GD84433@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cd771dfe-19bd-c183-101b-d6d0327a76c2@huawei.com>
Date:   Thu, 1 Aug 2019 16:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190801042650.GD84433@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/1 12:26, Jaegeuk Kim wrote:
> On 08/01, Chao Yu wrote:
>> On 2019/8/1 4:43, Jaegeuk Kim wrote:
>>> This patch fixes livelock in the below call path when writing swap pages.
>>>
>>> [46374.617256] c2    701  __switch_to+0xe4/0x100
>>> [46374.617265] c2    701  __schedule+0x80c/0xbc4
>>> [46374.617273] c2    701  schedule+0x74/0x98
>>> [46374.617281] c2    701  rwsem_down_read_failed+0x190/0x234
>>> [46374.617291] c2    701  down_read+0x58/0x5c
>>> [46374.617300] c2    701  f2fs_map_blocks+0x138/0x9a8
>>> [46374.617310] c2    701  get_data_block_dio_write+0x74/0x104
>>> [46374.617320] c2    701  __blockdev_direct_IO+0x1350/0x3930
>>> [46374.617331] c2    701  f2fs_direct_IO+0x55c/0x8bc
>>> [46374.617341] c2    701  __swap_writepage+0x1d0/0x3e8
>>> [46374.617351] c2    701  swap_writepage+0x44/0x54
>>> [46374.617360] c2    701  shrink_page_list+0x140/0xe80
>>> [46374.617371] c2    701  shrink_inactive_list+0x510/0x918
>>> [46374.617381] c2    701  shrink_node_memcg+0x2d4/0x804
>>> [46374.617391] c2    701  shrink_node+0x10c/0x2f8
>>> [46374.617400] c2    701  do_try_to_free_pages+0x178/0x38c
>>> [46374.617410] c2    701  try_to_free_pages+0x348/0x4b8
>>> [46374.617419] c2    701  __alloc_pages_nodemask+0x7f8/0x1014
>>> [46374.617429] c2    701  pagecache_get_page+0x184/0x2cc
>>> [46374.617438] c2    701  f2fs_new_node_page+0x60/0x41c
>>> [46374.617449] c2    701  f2fs_new_inode_page+0x50/0x7c
>>> [46374.617460] c2    701  f2fs_init_inode_metadata+0x128/0x530
>>> [46374.617472] c2    701  f2fs_add_inline_entry+0x138/0xd64
>>> [46374.617480] c2    701  f2fs_do_add_link+0xf4/0x178
>>> [46374.617488] c2    701  f2fs_create+0x1e4/0x3ac
>>> [46374.617497] c2    701  path_openat+0xdc0/0x1308
>>> [46374.617507] c2    701  do_filp_open+0x78/0x124
>>> [46374.617516] c2    701  do_sys_open+0x134/0x248
>>> [46374.617525] c2    701  SyS_openat+0x14/0x20
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index abbf14e9bd72..f49f243fd54f 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1372,7 +1372,7 @@ static int get_data_block_dio_write(struct inode *inode, sector_t iblock,
>>>  	return __get_data_block(inode, iblock, bh_result, create,
>>>  				F2FS_GET_BLOCK_DIO, NULL,
>>>  				f2fs_rw_hint_to_seg_type(inode->i_write_hint),
>>> -				true);
>>> +				IS_SWAPFILE(inode) ? false : true);
>>
>> I suspect that we should use node_change for swapfile rather than just changing
>> may_write field to skip lock.
> 
> Swap write should not change the node page.

You're right.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> __do_map_lock()
>> if (flag == F2FS_GET_BLOCK_PRE_AIO || IS_SWAPFILE(inode)) {
>> 	...
>> } else {
>> 	...
>> }
>>
>> Thanks,
>>
>>
>>>  }
>>>  
>>>  static int get_data_block_dio(struct inode *inode, sector_t iblock,
>>>
> .
> 
