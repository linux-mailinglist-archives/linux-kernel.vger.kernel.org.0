Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D439F16A42F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBXKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:41:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgBXKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:41:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 10C96F9334DF5F66A2DF;
        Mon, 24 Feb 2020 18:41:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Feb
 2020 18:41:04 +0800
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
 <20200222044617.pfrhnz2iavkrtdn6@core.my.home>
 <20200222181721.tzrrohep5l3yklpf@core.my.home>
 <bec3798b-f861-b132-9138-221027bb5195@huawei.com>
Message-ID: <b1eb9b22-b570-41ab-5177-2c89105428a2@huawei.com>
Date:   Mon, 24 Feb 2020 18:41:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bec3798b-f861-b132-9138-221027bb5195@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/24 18:37, Chao Yu wrote:
> Hi,
> 
> Thanks for the report.
> 
> On 2020/2/23 2:17, Ondřej Jirman wrote:
>> Hello,
>>
>> I observe hung background f2fs task on 5.6-rc2+ shortly after boot, leading to
>> panics. I use f2fs as rootfs. See below for stack trace. The reads continue to
>> work (if I disable panic on hung task). But sync blocks, writes block, etc.
>>
>> It does not happen on all my f2fs filesystems, so it may depend on workload
>> or my particular filesystem state. It happens on two separate devices though,
>> both 32-bit, and doesn't happen on a 64-bit device. (might be a false lead,
>> though)
>>
>> I went through the f2fs-for-5.6 tag/branch and reverted each patch right
>> down to:
>>
>>   4c8ff7095bef64fc47e996a938f7d57f9e077da3 f2fs: support data compression
>>
>> I could still reproduce the issue.
>>
>> After reverting the data compression too, I could no longer reproduce the
>> issue. Perhaps not very helpful, since that patch is huge.
>>
>> I tried to collect some information. Some ftrace logs, etc. Not sure what would
>> help debug this. Let me know if I can help debug this more.
>>
>> Symptoms look the same as this issue:
>>
>>   https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15298.html
>>
>> ftrace: https://megous.com/dl/tmp/f2fs-debug-info.txt
>>
>> longer ftrace: https://megous.com/dl/tmp/f2fs-debug-info-full.txt
> 
> I checked the full trace log, however I didn't find any clue to troubleshot this issue.
> 
> [snip]
> 
>> dmesg:
> 
> Could you dump all other task stack info via "echo "t" > /proc/sysrq-trigger"?
> 
>>
>> [  246.758021] INFO: task kworker/u16:1:58 blocked for more than 122 seconds.
>> [  246.758040]       Not tainted 5.6.0-rc2-00590-g9983bdae4974e #11
>> [  246.758044] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  246.758052] kworker/u16:1   D    0    58      2 0x00000000
>> [  246.758090] Workqueue: writeback wb_workfn (flush-179:0)
>> [  246.758099] Backtrace:
>> [  246.758121] [<c0912b90>] (__schedule) from [<c0913234>] (schedule+0x78/0xf4)
>> [  246.758130]  r10:da644000 r9:00000000 r8:da645a60 r7:da283e10 r6:00000002 r5:da644000
>> [  246.758132]  r4:da4d3600
>> [  246.758148] [<c09131bc>] (schedule) from [<c017ec74>] (rwsem_down_write_slowpath+0x24c/0x4c0)
>> [  246.758152]  r5:00000001 r4:da283e00
>> [  246.758161] [<c017ea28>] (rwsem_down_write_slowpath) from [<c0915f2c>] (down_write+0x6c/0x70)
>> [  246.758167]  r10:da283e00 r9:da645d80 r8:d9ed0000 r7:00000001 r6:00000000 r5:eff213b0
>> [  246.758169]  r4:da283e00
>> [  246.758187] [<c0915ec0>] (down_write) from [<c0435b80>] (f2fs_write_single_data_page+0x608/0x7ac)
> 
> I'm not sure what is this semaphore, I suspect this is F2FS_I(inode)->i_sem, in order to make
> sure of this, can you help to add below function, and use them to replace
> all {down,up}_{write,read}(&.i_sem) invoking? then reproduce this issue and catch the log.

Sorry, just forgot attaching below function.

void inode_down_write(struct inode *inode)
{
	printk("%s from %pS\n", __func__, __builtin_return_address(0));
	down_write(&F2FS_I(inode)->i_sem);
}

void inode_up_write(struct inode *inode)
{
	up_write(&F2FS_I(inode)->i_sem);
	printk("%s from %pS\n", __func__, __builtin_return_address(0));
}

void inode_down_read(struct inode *inode)
{
	printk("%s from %pS\n", __func__, __builtin_return_address(0));
	down_read(&F2FS_I(inode)->i_sem);
}

void inode_up_read(struct inode *inode)
{
	up_read(&F2FS_I(inode)->i_sem);
	printk("%s from %pS\n", __func__, __builtin_return_address(0));
}

> 
> Thanks,
> 
>> [  246.758190]  r5:eff213b0 r4:da283c60
>> [  246.758198] [<c0435578>] (f2fs_write_single_data_page) from [<c0435fd8>] (f2fs_write_cache_pages+0x2b4/0x7c4)
>> [  246.758204]  r10:da645c28 r9:da283d60 r8:da283c60 r7:0000000f r6:da645d80 r5:00000001
>> [  246.758206]  r4:eff213b0
>> [  246.758214] [<c0435d24>] (f2fs_write_cache_pages) from [<c043682c>] (f2fs_write_data_pages+0x344/0x35c)
>> [  246.758220]  r10:00000000 r9:d9ed002c r8:d9ed0000 r7:00000004 r6:da283d60 r5:da283c60
>> [  246.758223]  r4:da645d80
>> [  246.758238] [<c04364e8>] (f2fs_write_data_pages) from [<c0267ee8>] (do_writepages+0x3c/0xd4)
>> [  246.758244]  r10:0000000a r9:c0e03d00 r8:00000c00 r7:c0264ddc r6:da645d80 r5:da283d60
>> [  246.758246]  r4:da283c60
>> [  246.758254] [<c0267eac>] (do_writepages) from [<c0310cbc>] (__writeback_single_inode+0x44/0x454)
>> [  246.758259]  r7:da283d60 r6:da645eac r5:da645d80 r4:da283c60
>> [  246.758266] [<c0310c78>] (__writeback_single_inode) from [<c03112d0>] (writeback_sb_inodes+0x204/0x4b0)
>> [  246.758272]  r10:0000000a r9:c0e03d00 r8:da283cc8 r7:da283c60 r6:da645eac r5:da283d08
>> [  246.758274]  r4:d9dc9848
>> [  246.758281] [<c03110cc>] (writeback_sb_inodes) from [<c03115cc>] (__writeback_inodes_wb+0x50/0xe4)
>> [  246.758287]  r10:da3797a8 r9:c0e03d00 r8:d9dc985c r7:da645eac r6:00000000 r5:d9dc9848
>> [  246.758289]  r4:da5a8800
>> [  246.758296] [<c031157c>] (__writeback_inodes_wb) from [<c03118f4>] (wb_writeback+0x294/0x338)
>> [  246.758302]  r10:fffbf200 r9:da644000 r8:c0e04e64 r7:d9dc9848 r6:d9dc9874 r5:da645eac
>> [  246.758305]  r4:d9dc9848
>> [  246.758312] [<c0311660>] (wb_writeback) from [<c0312dac>] (wb_workfn+0x35c/0x54c)
>> [  246.758318]  r10:da5f2005 r9:d9dc984c r8:d9dc9948 r7:d9dc9848 r6:00000000 r5:d9dc9954
>> [  246.758321]  r4:000031e6
>> [  246.758334] [<c0312a50>] (wb_workfn) from [<c014f2b8>] (process_one_work+0x214/0x544)
>> [  246.758340]  r10:da5f2005 r9:00000200 r8:00000000 r7:da5f2000 r6:ef044400 r5:da5eb000
>> [  246.758343]  r4:d9dc9954
>> [  246.758350] [<c014f0a4>] (process_one_work) from [<c014f634>] (worker_thread+0x4c/0x574)
>> [  246.758357]  r10:ef044400 r9:c0e03d00 r8:ef044418 r7:00000088 r6:ef044400 r5:da5eb014
>> [  246.758359]  r4:da5eb000
>> [  246.758368] [<c014f5e8>] (worker_thread) from [<c01564fc>] (kthread+0x144/0x170)
>> [  246.758374]  r10:ec9e5e90 r9:dabf325c r8:da5eb000 r7:da644000 r6:00000000 r5:da5fe000
>> [  246.758377]  r4:dabf3240
>> [  246.758386] [<c01563b8>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> [  246.758391] Exception stack(0xda645fb0 to 0xda645ff8)
>> [  246.758397] 5fa0:                                     00000000 00000000 00000000 00000000
>> [  246.758402] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [  246.758407] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [  246.758413]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b8
>> [  246.758416]  r4:da5fe000
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
