Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE659D6409
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfJNNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:22:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfJNNWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:22:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9088B629E7A7AEA2E9A1;
        Mon, 14 Oct 2019 21:22:52 +0800 (CST)
Received: from [127.0.0.1] (10.119.195.53) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 21:22:50 +0800
From:   Chen Wandun <chenwandun@huawei.com>
Subject: [Question] Is there race between swapoff and swapout
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>
Message-ID: <8860e8b1-7bad-0b4a-60d1-4893973b9cb2@huawei.com>
Date:   Mon, 14 Oct 2019 21:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.119.195.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I analysied the code about swapoff and swapout, and I suspected there may be a race.
The kernel version is 4.14 stable.

CPU0						CPU1
swapoff						swap out
						add_to_swap
							get_swap_page
	......							get_swap_pages						
									spin_lock(&swap_avail_lock)
									get swap_info_struct
									spin_unlock(&swap_avail_lock)		
	spin_lock(&swap_avail_lock)									
	__def_from_avail_list(swap_info_struct)								
     	spin_unlock(&swap_avail_lock)					......	
	try_to_unuse  // unuse all slot
									/* get a free slot from swap_info_struct,
									 * and write data to slot later
									 */	
									scan_swap_map_slots
	free swap_info_struct
	.......

	
If CPU1 get the swap_info_struct first, then CPU0 delete it from list and
unuse all slot in swap_info_struct, before CPU0 free swap_info_struct CPU1
call scan_swap_map_slots to alloc a free slot.

I am not sure the analysis above is correct,
Please let me know if there is any mistake

Thanks
ChenWandun

