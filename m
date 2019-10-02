Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF9C8B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJBOom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:44:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfJBOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:44:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so7534544wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LKzMTTB8XV2AJkzo5S/56DrG6y6U1OC2/G5Z8Cw0zJE=;
        b=N5wcQz6tmc0QNH2OOHLHL1cfArP/bC7kbYrThjsiadXH3X4OjM8HrimpMIh0iNpxM9
         SVM7vpkt1agIkPjijOFf9O1qBIaT9IykydKmfy3OzE8LFpjorWWC3fzu/AoHNkUTsjB8
         vvX7LKpJrFH0/4kHC8arM7S99H/IFF2IegBPb1jsRZPWk8z5p0ZJAj6G+9l8eXPdKwWr
         92k8sgElo21Y48o4pG6T7uyrjN77rnTFe1uigBAria5xOT3NEsfYufy8KFAM9hXy235K
         uauIVQKo+KdheuHYY9w/aUGWOhRm4co/ngPyhJUjLZAu1mTCmvoiVjRCwELzbsymiKnK
         lftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LKzMTTB8XV2AJkzo5S/56DrG6y6U1OC2/G5Z8Cw0zJE=;
        b=LkG2EQc9E7try3u3BkIv1UYViGuXIuDTde9w/v6Iwl7d+n7J8PTF/coapn0KMnGENx
         Z2CK2XYGwBKQZMmXyHkg4WFbYe//DVWfFBk9I/ZYNCreNnBzZwpNjaVHsG+izvZ1hMZL
         42Ho4VnfCYnUV4DhiUd7giV0GyxaGAYlnSEE9y5oO/oideu9nxuY/Y2Q+wHLbtKVIpUC
         8GaW2oc/s5SpdlnXV+3ho6QxKkiD3bFzPsR2bEYuEJ6pj6kfwhLkObIESKFcI9ajuw9e
         uM5pXcFcLxNtnc+ap7plJFuqs7o0FDpdGYeokk6f0J7shPtQxpeil7SI7BriXKNr7t/W
         0tpg==
X-Gm-Message-State: APjAAAXKVJRhHI/FvG78HRB/4qCSaRKtwlyEpBUpYtbnXhUTfBV8N0KG
        JEmVeDwPdBnrUedxk16KfhOFLA==
X-Google-Smtp-Source: APXvYqw5vtCHPqtCkgw9ZdxQdx3eNIPI89zqupQVrUgJSgf01qmh1DfG369DRIKsrte1anj4Ed6h5Q==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr3132435wmj.21.1570027473707;
        Wed, 02 Oct 2019 07:44:33 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h17sm11313874wme.6.2019.10.02.07.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:44:32 -0700 (PDT)
Subject: Re: drm_sched with panfrost crash on T820
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <f0ab487e-8d49-987b-12b8-7a115a6543e1@amd.com>
 <20190930145228.14000-1-hdanton@sina.com>
 <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <81694dcc-0bb5-0c47-dab2-ed61a65a5845@baylibre.com>
Date:   Wed, 2 Oct 2019 16:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,


On 02/10/2019 16:40, Grodzovsky, Andrey wrote:
> 
> On 9/30/19 10:52 AM, Hillf Danton wrote:
>> On Mon, 30 Sep 2019 11:17:45 +0200 Neil Armstrong wrote:
>>> Did a new run from 5.3:
>>>
>>> [   35.971972] Call trace:
>>> [   35.974391]  drm_sched_increase_karma+0x5c/0xf0
>>> 			ffff000010667f38	FFFF000010667F94
>>> 			drivers/gpu/drm/scheduler/sched_main.c:335
>>>
>>> The crashing line is :
>>>                                  if (bad->s_fence->scheduled.context ==
>>>                                      entity->fence_context) {
>>>
>>> Doesn't seem related to guilty job.
>> Bail out if s_fence is no longer fresh.
>>
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -333,6 +333,10 @@ void drm_sched_increase_karma(struct drm
>>   
>>   			spin_lock(&rq->lock);
>>   			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
>> +				if (!smp_load_acquire(&bad->s_fence)) {
>> +					spin_unlock(&rq->lock);
>> +					return;
>> +				}
>>   				if (bad->s_fence->scheduled.context ==
>>   				    entity->fence_context) {
>>   					if (atomic_read(&bad->karma) >
>> @@ -543,7 +547,7 @@ EXPORT_SYMBOL(drm_sched_job_init);
>>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>>   {
>>   	dma_fence_put(&job->s_fence->finished);
>> -	job->s_fence = NULL;
>> +	smp_store_release(&job->s_fence, 0);
>>   }
>>   EXPORT_SYMBOL(drm_sched_job_cleanup);
> 
> 
> Does this change help the problem ? Note that drm_sched_job_cleanup is 
> called from scheduler thread which is stopped at all times when work_tdr 
> thread is running and anyway the 'bad' job is still in the 
> ring_mirror_list while it's being accessed from  
> drm_sched_increase_karma so I don't think drm_sched_job_cleanup can be 
> called for it BEFORE or while drm_sched_increase_karma is executed.

I'm running it right now, will post results when finished.

Thanks,
Neil

> 
> Andrey
> 
> 
>>   
>> --
>>

