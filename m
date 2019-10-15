Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AEBD6F82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJOGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 02:18:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfJOGS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:18:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78EA37BF91BCA7785E15;
        Tue, 15 Oct 2019 14:18:25 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 14:18:21 +0800
Subject: Re: Regression in longterm 4.19: f2fs: use generic
 EFSBADCRC/EFSCORRUPTED
To:     Andrew Macks <andypoo@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, <stable@kernel.org>,
        Greg KH <greg@kroah.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <CAFeYvHWC=RZJr2ZSAvRy=r1kAJU8YW-hxkZ3uBAd2OQEerKmag@mail.gmail.com>
 <CAFeYvHXQQPfu+r0kLpTXWRZJr8SFF1QyUWzOkjJYFE2_UVSrUA@mail.gmail.com>
 <20191013214440.GA20196@amd>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bd176ce3-6a76-9d09-c555-f6fb549afe9f@huawei.com>
Date:   Tue, 15 Oct 2019 14:18:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191013214440.GA20196@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/14 5:44, Pavel Machek wrote:
> On Sat 2019-10-12 21:55:24, Andrew Macks wrote:
>> Sorry for version typo in the previous message.
>>
>> In addition to 4.19, the issue was also backported to 4.14 and 5.2.
>>
>> 4.14, 4.19 and 5.2 are all missing the EINVAL fix from 5.3.
> 
> Ouch.
> 
> Well, when I seen the patch, I thought "looks like the bug is not
> serious enough for -stable". I guess I should have spoken up.
> 
> Anyway, I guess we need to either revert  59a5cea41dd0a or backport
> 38fb6d0ea34299d97b too....
> 
> So I guess Greg and lists need to be cc-ed... and 
> 
> Thanks for the report and sorry for the trouble....

I'm so sorry to introduce original bug, the fixing patch ("f2fs: use EINVAL for
superblock with invalid magic") should be backported to stable kernel as soon as
possible.

Thanks,

> 
> 								Pavel
> 
> 
>> Andrew.
>>
>> On Sat, 12 Oct 2019 at 21:39, Andrew Macks <andypoo@gmail.com> wrote:
>>
>>> Hi - there is a nasty regression which was recently introduced into
>>> longterm 4.19.76.
>>>
>>> 59a5cea41dd0ae706ab83f8ecd64199aadefb493 was committed to 4.19, however it
>>> introduces a regression that filesystems no longer mount if do_mounts
>>> iterates through them after F2FS.  This surfaced on one of my servers as
>>> F2FS superblock check happens before btrfs mount is attempted.
>>>
>>> With this code, my server panicked after kernel upgrade as btrfs mount
>>> wasn't attempted.
>>>
>>> This issue has already been fixed in 5.3 with this patch in July, but it
>>> was missed from the 4.19 backport.
>>>
>>> 38fb6d0ea34299d97b031ed64fe994158b6f8eb3
>>> f2fs: use EINVAL for superblock with invalid magic
>>>
>>> Andypoo.
>>>
> 
