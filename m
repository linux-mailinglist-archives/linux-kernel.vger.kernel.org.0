Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2414EB18
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgAaKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:41:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgAaKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:41:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so8093493wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 02:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WZop4bdwwGLO+EHfABQjAxDwhkz6UEFKkDSsUCMxnGI=;
        b=x3C9KHV3dsuebpyTMEa658xzfgYeOafa4rxar9/uPB6IHwukAWRbBfChhel6mE2liX
         VueNN7HDIkRtL7UYhcG/OL1s5wMYFgSrxjZMIchbpqNkDQxsoLVZDJVUzzwP57NyKGyN
         G0hjEhz9uuaj7H2WwBYs0pj7+QnbxYwwh/qjBoVSSQIyEx+IJNay8ZMjyk0kfoG6ruea
         onTQXickJmwVdIQwkDygb0uu9Sb7hh0Hj1SSYNL6XIfgMdJC4de38xu47E9DzbLYpVAV
         FfMbfvZ1dtVDVT+EJnLpDovbJ3wmntmjwB91Ebr3veuJrHcQmzb2ryN2fS8I6fpGIixW
         jlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WZop4bdwwGLO+EHfABQjAxDwhkz6UEFKkDSsUCMxnGI=;
        b=h5TqBeZoAfFqE8LAIzfjWC5K51LwKej+qCJ9Z72L967wl/dI1KMdgPCRZ0qH/yS7LT
         R6U1yYB2+cLYBLLaJWho7LASB2H1ZDZFgLxfOkH0S6/YuIbCMACOvUepQ2RZjN4dlxz4
         uTB7GFK/oHgZmr/jH+KGbiW1or1/qFmm1ZXOfX6XM/pgZqnA328ydjdy55F3WRgH1+ez
         emvkICAGSFzKeM277Tmu0S2VsV6EVlGou46XBgiK8jrflZtwTBOojAL3ZlOBr6zXQPUH
         3qv1slFnpOhkZ9FD68hs9/hFHvnWVr2jzLEw7c6ImRkPrtb+T0N37hDurbfrYXemtMxr
         rELA==
X-Gm-Message-State: APjAAAWiBepXptNKWKupNqQL25Wh6tSAMqUw5YGd0zLAtgaS3kjliJ3o
        v9Rtg/oxbV5l9d9SwU4XR/arKQ==
X-Google-Smtp-Source: APXvYqx7ZVm9hQ9hoVigAiJxyvIb0rHBteqCvOFhLesfY0gz8mAbf4HPdpFD1DAt4Kcm4NCKKQRM5g==
X-Received: by 2002:a1c:9849:: with SMTP id a70mr11079056wme.76.1580467286817;
        Fri, 31 Jan 2020 02:41:26 -0800 (PST)
Received: from [192.168.0.103] (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id m7sm10871957wrr.40.2020.01.31.02.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 02:41:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX 3/6] block, bfq: get extra ref to prevent a queue
 from being freed during a group move
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <784c55c0f37a1a448c31e73e28bef6f8@natalenko.name>
Date:   Fri, 31 Jan 2020 11:41:24 +0100
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bfq-iosched@googlegroups.com,
        patdung100@gmail.com, cevich@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D4E431C-D4B7-43DD-AB66-67ED5EA807DE@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
 <20200131092409.10867-4-paolo.valente@linaro.org>
 <784c55c0f37a1a448c31e73e28bef6f8@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[RESENDING, BECAUSE BOUNCED OFF]

> Il giorno 31 gen 2020, alle ore 11:20, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hello.
>=20
> On 31.01.2020 10:24, Paolo Valente wrote:
>> In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
>> may happen to be deactivated in the scheduling data structures of the
>> source group (and then activated in the destination group). If Q is
>> referred only by the data structures in the source group when the
>> deactivation happens, then Q is freed upon the deactivation.
>> This commit addresses this issue by getting an extra reference before
>> the possible deactivation, and releasing this extra reference after Q
>> has been moved.
>> Tested-by: Chris Evich <cevich@redhat.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-cgroup.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index e1419edde2ec..8ab7f18ff8cb 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq,
>> 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
>> 				false, BFQQE_PREEMPTED);
>> +	/*
>> +	 * get extra reference to prevent bfqq from being freed in
>> +	 * next possible deactivate
>> +	 */
>> +	bfqq->ref++;
>=20
> Shouldn't this be hidden under some macro (bfq_get_queue_ref(), for =
instance) and also converted from int into refcount_t?
>=20

Yeah, that's in my (long) todo list.  Unfortunately, all BFQ code
handles that ref increment in that rustic way (inherited from CFQ).
It would take a little time to fix and check all occurrences.  This
fix is probably more critical, as this bug is crashing machines in some
configurations.  But I promise I won't forget your right suggestion.


Thanks,
Paolo

>> +
>> 	if (bfq_bfqq_busy(bfqq))
>> 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>> 	else if (entity->on_st)
>> @@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct
>> bfq_queue *bfqq,
>> 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
>> 		bfq_schedule_dispatch(bfqd);
>> +	/* release extra ref taken above */
>> +	bfq_put_queue(bfqq);
>> }
>> /**
>=20
> --=20
>  Oleksandr Natalenko (post-factum)

