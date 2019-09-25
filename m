Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58E9BD6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411510AbfIYDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 23:21:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728522AbfIYDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:21:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E97B3CAC57776CCE6E27;
        Wed, 25 Sep 2019 11:21:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 11:20:58 +0800
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
To:     Eryu Guan <eguan@linux.alibaba.com>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>,
        Eric Biggers <ebiggers@google.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
 <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
 <b215554a-092b-fcf3-e0a3-36fab291b4ff@huawei.com>
 <20190925031554.GA67926@e18g06458.et15sqa>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <41aa4398-5269-f9c5-3415-ed788ab45ffb@huawei.com>
Date:   Wed, 25 Sep 2019 11:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190925031554.GA67926@e18g06458.et15sqa>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, You are right, I understood it wrong. Thanks for reminding.

在 2019/9/25 11:15, Eryu Guan 写道:
> On Tue, Sep 24, 2019 at 10:19:38PM +0800, Zhihao Cheng wrote:
>> As far as I know, _require_scratch_shutdown() is called after _overay_config_override(), at this moment, FSTYP equals to base fs. According the implementation of _require_scratch_shutdown:
>> 3090 _require_scratch_shutdown()
>> 3091 {
>> 3092     [ -x src/godown ] || _notrun "src/godown executable not found"
>> 3093
>> 3094     _scratch_mkfs > /dev/null 2>&1 || _notrun "_scratch_mkfs failed on $SCRATCH_DEV"
>> 3095     _scratch_mount
>> 3096
>> 3097     if [ $FSTYP = "overlay" ]; then                                            # FSTYP = base fs
>> 3098         if [ -z $OVL_BASE_SCRATCH_DEV ]; then
>> 3099             # In lagacy overlay usage, it may specify directory as
>> 3100             # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
>> 3101             # will be null, so check OVL_BASE_SCRATCH_DEV before
>> 3102             # running shutdown to avoid shutting down base fs accidently.
>> 3103             _notrun "$SCRATCH_DEV is not a block device"
>> 3104         else
>> 3105             src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
>> 3106             || _notrun "Underlying filesystem does not support shutdown"
>> 3107         fi
>> 3108     else
>> 3109         src/godown -f $SCRATCH_MNT 2>&1 \
>> 3110             || _notrun "$FSTYP does not support shutdown"                      # Executes this path
>> 3111     fi
>> 3112
>> 3113     _scratch_unmount
>> 3114 }
>> So, we can't get output: _notrun "$SCRATCH_DEV is not a block device". Instead, the verbose should like:
>>   after _overlay_config_override FSTYP=ubifs    # Additional print message
>>   FSTYP         -- ubifs
>>   PLATFORM      -- Linux/x86_64
>>   MKFS_OPTIONS  -- /dev/ubi0_1
>>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
>>
>>   generic/042	[not run] ubifs does not support shutdown
>>
>> But I'll consider describing error more concisely in v2.
>>
>> 在 2019/9/24 20:33, Amir Goldstein 写道:
>>> On Tue, Sep 24, 2019 at 12:34 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>>>
>>>> When running overlay tests using character devices as base fs partitions,
>>>> all overlay usecase results become 'notrun'. Function
>>>> '_overay_config_override' (common/config) detects that the current base
>>>> fs partition is not a block device and will set FSTYP to base fs. The
>>>> overlay usecase will check the current FSTYP, and if it is not 'overlay'
>>>> or 'generic', it will skip the execution.
>>>>
>>>> For example, using UBIFS as base fs skips all overlay usecases:
>>>>
>>>>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
>>>>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
>>>>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
>>>>
>>>>   overlay/001   [not run] not suitable for this filesystem type: ubifs
>>>>   overlay/002   [not run] not suitable for this filesystem type: ubifs
>>>>   overlay/003   [not run] not suitable for this filesystem type: ubifs
>>>>   ...
>>>>
>>>> When checking that the base fs partition is a block/character device,
>>>> FSTYP is overwritten as 'overlay'. This patch allows the base fs
>>>> partition to be a character device that can also execute overlay
>>>> usecases (such as ubifs).
>>>>
>>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>>> ---
>>>>  common/config | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/common/config b/common/config
>>>> index 4c86a49..a22acdb 100644
>>>> --- a/common/config
>>>> +++ b/common/config
>>>> @@ -550,7 +550,7 @@ _overlay_config_override()
>>>>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>>>>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>>>>         #    overlayfs base and mount dirs inside base fs mount.
>>>> -       [ -b "$TEST_DEV" ] || return 0
>>>> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>>>>
>>>>         # Config file may specify base fs type, but we obay -overlay flag
>>>>         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>>>> @@ -570,7 +570,7 @@ _overlay_config_override()
>>>>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>>>>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>>>>
>>>> -       [ -b "$SCRATCH_DEV" ] || return 0
>>>> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>>>>
>>>>         # Store original base fs vars
>>>>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> Looks fine.
>>>
>>> One nit: there is a message in _require_scratch_shutdown():
>>> _notrun "$SCRATCH_DEV is not a block device"
>>> for when $OVL_BASE_SCRATCH_DEV is not defined.
>>>
>>> Could probably use a better describing error anyway.
> 
> I think what Amir suggested is that, as you add char device support to
> overlay base device, the message in _require_scratch_shutdown() should
> be updated accordingly, not the commit log.
> 
> Thanks,
> Eryu
> 
> .
> 

