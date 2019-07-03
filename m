Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083845D6AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGBTPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 15:15:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:15:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8A2D607B9; Tue,  2 Jul 2019 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562094923;
        bh=X8Aoljm0LYeyxBEqbEVId7mUQqHptsmMGCGTKktZVAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/PcbyT58Do7LICpzhWUA4B3V217FV7Ad9lbkyim+DNPhlNSr7cWqiwqV7OYKJ4hd
         YQmrx995MCms606pArLo4LiTFwCY/wvGw228u+vz6nw/AMJ7EPyxjWp6WoxSYzuYxz
         CFIii91QxvHmYF7aCBDJVcoU5XwhQbZPo5zJQgQU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C6F8C60746;
        Tue,  2 Jul 2019 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562094922;
        bh=X8Aoljm0LYeyxBEqbEVId7mUQqHptsmMGCGTKktZVAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lHcJ/6o71zHCEADhRs23OU6NF+fNeaAPkCHRI05v5co4mdYEj3f7sPw5dx+lZhLQe
         SRAbtSg4y9iUnsw603C34us7Wsql3rW0zwF1DPBSYa6yBz2BrRNMxmNwCMFDKg2dF4
         gWsdl5907wyfFiDc6aRnjlssZQ3V6wedqenCYRm4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Jul 2019 12:15:22 -0700
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dhar@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        nganji@codeaurora.org, jshekhar@codeaurora.org
Subject: Re: drm/msm/dpu: Correct dpu encoder spinlock initialization
In-Reply-To: <f9a7786cce817c7d1a646b052ba1a679@codeaurora.org>
References: <1561357632-15361-1-git-send-email-dhar@codeaurora.org>
 <efade579f7ba59585b88ecb367422e5c@codeaurora.org>
 <d61d7805b4ac0ec45309bf5b65841262@codeaurora.org>
 <627144af54459a203f1583d2ad9b390c@codeaurora.org>
 <ea91c2c49d73af79bd6eea93a6d00a5a@codeaurora.org>
 <f9a7786cce817c7d1a646b052ba1a679@codeaurora.org>
Message-ID: <87b59fd6d89f4096243770edefc5e97b@codeaurora.org>
X-Sender: jsanka@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-02 11:21, Jeykumar Sankaran wrote:
> On 2019-07-01 03:29, dhar@codeaurora.org wrote:
>> On 2019-06-26 03:10, Jeykumar Sankaran wrote:
>>> On 2019-06-24 22:44, dhar@codeaurora.org wrote:
>>>> On 2019-06-25 03:56, Jeykumar Sankaran wrote:
>>>>> On 2019-06-23 23:27, Shubhashree Dhar wrote:
>>>>>> dpu encoder spinlock should be initialized during dpu encoder
>>>>>> init instead of dpu encoder setup which is part of commit.
>>>>>> There are chances that vblank control uses the uninitialized
>>>>>> spinlock if not initialized during encoder init.
>>>>> Not much can be done if someone is performing a vblank operation
>>>>> before encoder_setup is done.
>>>>> Can you point to the path where this lock is acquired before
>>>>> the encoder_setup?
>>>>> 
>>>>> Thanks
>>>>> Jeykumar S.
>>>>>> 
>>>> 
>>>> When running some dp usecase, we are hitting this callstack.
>>>> 
>>>> Process kworker/u16:8 (pid: 215, stack limit = 0x00000000df9dd930)
>>>> Call trace:
>>>>  spin_dump+0x84/0x8c
>>>>  spin_dump+0x0/0x8c
>>>>  do_raw_spin_lock+0x80/0xb0
>>>>  _raw_spin_lock_irqsave+0x34/0x44
>>>>  dpu_encoder_toggle_vblank_for_crtc+0x8c/0xe8
>>>>  dpu_crtc_vblank+0x168/0x1a0
>>>>  dpu_kms_enable_vblank+0[   11.648998]  vblank_ctrl_worker+0x3c/0x60
>>>>  process_one_work+0x16c/0x2d8
>>>>  worker_thread+0x1d8/0x2b0
>>>>  kthread+0x124/0x134
>>>> 
>>>> Looks like vblank is getting enabled earlier causing this issue and 
>>>> we
>>>> are using the spinlock without initializing it.
>>>> 
>>>> Thanks,
>>>> Shubhashree
>>>> 
>>> DP calls into set_encoder_mode during hotplug before even notifying 
>>> the
>>> u/s. Can you trace out the original caller of this stack?
>>> 
>>> Even though the patch is harmless, I am not entirely convinced to 
>>> move this
>>> initialization. Any call which acquires the lock before encoder_setup
>>> will be a no-op since there will not be any physical encoder to work 
>>> with.
>>> 
>>> Thanks and Regards,
>>> Jeykumar S.
>>> 
>>>>>> Change-Id: I5a18b95fa47397c834a266b22abf33a517b03a4e
>>>>>> Signed-off-by: Shubhashree Dhar <dhar@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 +--
>>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>>> index 5f085b5..22938c7 100644
>>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>>>>>> @@ -2195,8 +2195,6 @@ int dpu_encoder_setup(struct drm_device 
>>>>>> *dev, struct
>>>>>> drm_encoder *enc,
>>>>>>  	if (ret)
>>>>>>  		goto fail;
>>>>>> 
>>>>>> -	spin_lock_init(&dpu_enc->enc_spinlock);
>>>>>> -
>>>>>>  	atomic_set(&dpu_enc->frame_done_timeout, 0);
>>>>>>  	timer_setup(&dpu_enc->frame_done_timer,
>>>>>>  			dpu_encoder_frame_done_timeout, 0);
>>>>>> @@ -2250,6 +2248,7 @@ struct drm_encoder *dpu_encoder_init(struct
>>>>>> drm_device *dev,
>>>>>> 
>>>>>>  	drm_encoder_helper_add(&dpu_enc->base, 
>>>>>> &dpu_encoder_helper_funcs);
>>>>>> 
>>>>>> +	spin_lock_init(&dpu_enc->enc_spinlock);
>>>>>>  	dpu_enc->enabled = false;
>>>>>> 
>>>>>>  	return &dpu_enc->base;
>> 
>> In dpu_crtc_vblank(), we are looping through all the encoders in the
>> present mode_config:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/disp/dpu
>> 1/dpu_crtc.c#L1082
>> and hence calling dpu_encoder_toggle_vblank_for_crtc() for all the
>> encoders. But in dpu_encoder_toggle_vblank_for_crtc(), after acquiring
>> the spinlock, we will do a early return for
>> the encoders which are not currently assigned to our crtc:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/disp/dpu
>> 1/dpu_encoder.c#L1318.
>> Since the encoder_setup for the secondary encoder(dp encoder in this
>> case) is not called until dp hotplug, we are hitting kernel panic
>> while acquiring the lock.
> This is the sequence in which the events are expected to happen:
> 
> 1) DP connector is instantiated with an inactive state
> 2) Hot plug on DP
> 3) DP connector is activated
> 4) User space attaches a CRTC to the activated connector
> 5) CRTC is enabled
> 6) CRTC_VBLANK_ON is called
> 7) dpu_crtc_vblank is called.
> 
> So can you help tracing out why dpu_crtc_vblank is called when the 
> connector
> is not activated yet (no hotplug)?

Overlooked the loop which iterates through *all* the encoders 
irrespective of their
activated status.

Reviewed-by: Jeykumar Sankaran <jsanka@codeaurora.org>

