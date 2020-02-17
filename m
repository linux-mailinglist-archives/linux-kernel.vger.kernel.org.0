Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B73160795
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 02:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgBQBDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 20:03:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgBQBDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:03:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 406B710D8A15A8CBDBB6;
        Mon, 17 Feb 2020 09:03:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Feb
 2020 09:03:29 +0800
Subject: Re: [PATCH 3/4] f2fs: clean up lfs/adaptive mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200214094413.12784-1-yuchao0@huawei.com>
 <20200214094413.12784-3-yuchao0@huawei.com>
 <20200214184150.GB60913@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c0436553-a1b6-8124-a096-15d2c3d5bd79@huawei.com>
Date:   Mon, 17 Feb 2020 09:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214184150.GB60913@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/15 2:41, Jaegeuk Kim wrote:
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 5152e9bf432b..d2d50827772c 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -91,8 +91,6 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>>  #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
>>  #define F2FS_MOUNT_DATA_FLUSH		0x00008000
>>  #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
>> -#define F2FS_MOUNT_ADAPTIVE		0x00020000
>> -#define F2FS_MOUNT_LFS			0x00040000
> 
> I don't think we can remove this simply.
> 
>>  #define F2FS_MOUNT_USRQUOTA		0x00080000
>>  #define F2FS_MOUNT_GRPQUOTA		0x00100000
>>  #define F2FS_MOUNT_PRJQUOTA		0x00200000

You mean getting rid of this change or we need to fill F2FS_MOUNT_* hole as below:

#define F2FS_MOUNT_FAULT_INJECTION	0x00010000
-#define F2FS_MOUNT_ADAPTIVE		0x00020000
-#define F2FS_MOUNT_LFS			0x00040000
+#define F2FS_MOUNT_USRQUOTA		0x00020000
+#define F2FS_MOUNT_GRPQUOTA		0x00040000
...

Thanks,
