Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF491AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHSCHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 22:07:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfHSCHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:07:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 612418B63E9014134CB8;
        Mon, 19 Aug 2019 10:07:32 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.74) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 10:07:25 +0800
Subject: Re: [RESEND][PATCH v3 00/26] drm: Kirin driver cleanups to prep for
 Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>, <xuyiping@hisilicon.com>
References: <20190814184702.54275-1-john.stultz@linaro.org>
 <20190814194508.GA26866@ravnborg.org>
CC:     Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
From:   xinliang <z.liuxinliang@hisilicon.com>
Message-ID: <5D5A045C.5020707@hisilicon.com>
Date:   Mon, 19 Aug 2019 10:07:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20190814194508.GA26866@ravnborg.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/15 3:45, Sam Ravnborg wrote:
> Hi Xinliang, Rongrong, Xinwei, Chen
>
> On Wed, Aug 14, 2019 at 06:46:36PM +0000, John Stultz wrote:
>> Just wanted to resend this patch set so I didn't have to
>> continue carrying it forever to keep the HiKey960 board running.
>>
>> This patchset contains one fix (in the front, so its easier to
>> eventually backport), and a series of changes from YiPing to
>> refactor the kirin drm driver so that it can be used on both
>> kirin620 based devices (like the original HiKey board) as well
>> as kirin960 based devices (like the HiKey960 board).
>>
>> The full kirin960 drm support is still being refactored, but as
>> this base kirin rework was getting to be substantial, I wanted
>> to send out the first chunk, so that the review burden wasn't
>> overwhelming.
> As Maintainers can we please get some feedback from one of you.
> Just an "OK to commit" would do it.
> But preferably an ack or a review on the individual patches.

Hi sam,
So sorry for responding late.
As I have done a pre-review and talked with the  author before sending 
out the patches.
So, for this serial patches,
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>

>
> If the reality is that John is the Maintainer today,
> then we should update MAINTAINERS to reflect this.

I am assuming you are talking about the kirin[1] drm driver not the 
hibmc[2] one, right?
I really appreciate John's awesome work at kirin drm driver all the way.
Honestly, after my work change from mobile to server years ago, I am 
always waiting for some guy who is stably working at kirin drm driver to 
take the maintenance work.
John, surely is a such guy.  Please add up a patch to update the 
maintainer as John, if John agree so.  Then John can push the patch set 
to drm maintainer himself.
*Note* that the maintainer patch should break hisilicon drivers into 
kirin and hibmc two parts, like bellow:

DRM DRIVERS FOR HISILICON HIBMC
M:  Xinliang Liu <z.liuxinliang@hisilicon.com>
...
F:  drivers/gpu/drm/hisilicon/hibmc
...

DRM DRIVERS FOR HISILICON KIRIN
M:  John Stultz <john.stultz@linaro.org>
...
F:  drivers/gpu/drm/hisilicon/kirin
...

[1] drivers/gpu/drm/hisilicon/kirin # for kirin mobile display driver
[2] drivers/gpu/drm/hisilicon/hibmc # for server VGA driver


Thanks,
Xinliang


>
> Thanks!
>
> 	Sam
>
> .
>


