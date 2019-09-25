Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96901BD6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411542AbfIYD1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 23:27:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406280AbfIYD1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:27:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0548C48A6231B1F8B4AB;
        Wed, 25 Sep 2019 11:27:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.224.82) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 11:27:35 +0800
Subject: Re: [PATCH xfstests v2] overlay: Enable character device to be the
 base fs partition
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <guaneryu@gmail.com>, <amir73il@gmail.com>,
        <david.oberhollenzer@sigma-star.at>, <ebiggers@google.com>,
        <yi.zhang@huawei.com>, <fstests@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
 <20190925030550.GA9913@magnolia> <20190925031733.GB9913@magnolia>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
Date:   Wed, 25 Sep 2019 11:27:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190925031733.GB9913@magnolia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.224.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are indeed many '-b' options in xfstests. I only confirmed the line of overlay test. Other -b test options I need to reconfirm later.

ÔÚ 2019/9/25 11:17, Darrick J. Wong Ð´µÀ:
> On Tue, Sep 24, 2019 at 08:05:50PM -0700, Darrick J. Wong wrote:
>> On Wed, Sep 25, 2019 at 09:54:08AM +0800, Zhihao Cheng wrote:
>>> There is a message in _supported_fs():
>>>     _notrun "not suitable for this filesystem type: $FSTYP"
>>> for when overlay usecases are executed on a chararcter device based base
>>
>> You can do that?
>>
>> What does that even look like?
> 
> OH, ubifs.  Ok.
> 
> /me wonders if there are more places in xfstests with test -b that needs
> fixing...
> 
> --D
> 
>> --D
>>
>>> fs. _overay_config_override() detects that the current base fs partition
>>> is not a block device, and FSTYP won't be overwritten as 'overlay' before
>>> executing usecases which results in all overlay usecases become 'notrun'.
>>> In addition, all generic usecases are based on base fs rather than overlay.
>>>
>>> We want to rewrite FSTYP to 'overlay' before running the usecases. To do
>>> this, we need to add additional character device judgments for TEST_DEV
>>> and SCRATCH_DEV in _overay_config_override().
>>>
>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> ---
>>>  common/config | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/config b/common/config
>>> index 4c86a49..a22acdb 100644
>>> --- a/common/config
>>> +++ b/common/config
>>> @@ -550,7 +550,7 @@ _overlay_config_override()
>>>  	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>>>  	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>>>  	#    overlayfs base and mount dirs inside base fs mount.
>>> -	[ -b "$TEST_DEV" ] || return 0
>>> +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>>>  
>>>  	# Config file may specify base fs type, but we obay -overlay flag
>>>  	[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>>> @@ -570,7 +570,7 @@ _overlay_config_override()
>>>  	export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>>>  	export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>>>  
>>> -	[ -b "$SCRATCH_DEV" ] || return 0
>>> +	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>>>  
>>>  	# Store original base fs vars
>>>  	export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
>>> -- 
>>> 2.7.4
>>>
> 
> .
> 

