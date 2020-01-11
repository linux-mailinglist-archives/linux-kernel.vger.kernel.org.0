Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119D1137C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 10:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAKJ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 04:26:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbgAKJ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:26:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5A99D26524B0229798D5;
        Sat, 11 Jan 2020 17:26:54 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 11 Jan
 2020 17:26:51 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a way to turn off ipu bio cache
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200107020709.73568-1-jaegeuk@kernel.org>
 <afddac87-b7c5-f68c-4e55-3705be311cf6@huawei.com>
 <20200108120444.GC28331@jaegeuk-macbookpro.roam.corp.google.com>
 <d5555fd8-736f-cc2f-1e57-d9ac01b3d012@huawei.com>
 <20200108231840.GB42219@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bdd79445-cf45-4841-bfcd-f66260ef8bd3@huawei.com>
Date:   Sat, 11 Jan 2020 17:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200108231840.GB42219@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/9 7:18, Jaegeuk Kim wrote:
> On 01/08, Chao Yu wrote:
>> On 2020/1/8 20:04, Jaegeuk Kim wrote:
>>> On 01/08, Chao Yu wrote:
>>>> On 2020/1/7 10:07, Jaegeuk Kim wrote:
>>>>> Setting 0x40 in /sys/fs/f2fs/dev/ipu_policy gives a way to turn off
>>>>> bio cache, which is useufl to check whether block layer using hardware
>>>>> encryption engine merges IOs correctly.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  Documentation/filesystems/f2fs.txt | 1 +
>>>>>  fs/f2fs/segment.c                  | 2 +-
>>>>>  fs/f2fs/segment.h                  | 1 +
>>>>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
>>>>> index 41b5aa94b30f..cd93bcc34726 100644
>>>>> --- a/Documentation/filesystems/f2fs.txt
>>>>> +++ b/Documentation/filesystems/f2fs.txt
>>>>> @@ -335,6 +335,7 @@ Files in /sys/fs/f2fs/<devname>
>>>>>                                 0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
>>>>>                                 0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
>>>>>                                 0x10: F2FS_IPU_FSYNC.
>>>>
>>>> . -> ,
>>>
>>> Actually, we can't do it. I revised it a bit instead.
>>
>> One more question, why skipping 0x20 bit position?
> 
> It seems original patch missed to add comment.
> 
>>From f9447095de55a3cda1023a37a5e1cb6dd2f54ebb Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 8 Jan 2020 15:10:02 -0800
> Subject: [PATCH] f2fs: update f2fs document regarding to fsync_mode
> 
> This patch adds missing fsync_mode entry in f2fs document.
> 
> Fixes: 04485987f053 ("f2fs: introduce async IPU policy")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
