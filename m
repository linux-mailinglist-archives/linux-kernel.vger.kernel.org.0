Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE61BF56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEMWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 18:06:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36849 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfEMWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:06:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so9097691qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:message-id;
        bh=OcPH4TpzUP5EwA7HOvYuzACS4sFjGeY4yoQKOJgL8Pk=;
        b=q5S6EmpxjoofIYnVX3wdH2qUCgksis4+/o/d3YDivQqceD7BEXNAlC2hggfRocUnRN
         hjOAIBrGNYXsmCikU0MKhMy5pNcn2HYhrIHbl8CHwbw50DEqKhlAH0RPAlZj3VZUtTpf
         OeYQYBmsVbDZtl+vBnl2VuTYbAVlz7J7/ig2KA2qZ+RME5EjHCq92H0407yL2gg6VH83
         py9cCCwJ+lWM8c2bfZIblBRN8uzhYWLCE4EjIcMTTwpyIsuRQTFK8ypLVpJomSpKdbAC
         797RdlFvLy8YUD5AOYW7raXUh/rYlNhyjEc3sOxURcENHYIA2TPBQdfjkdL89UjWOtOH
         0qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:message-id;
        bh=OcPH4TpzUP5EwA7HOvYuzACS4sFjGeY4yoQKOJgL8Pk=;
        b=Fh8ElSfm6oMo/rle5Ui+VrQ4gwySYrrj5iK5S/Aty494Vg3JHr1ssK6KXzvAm8jt6E
         0hb3BBQox49abW6kqCJjTAIsqKnJyf1ywZIx3IixS1kBFCuZKprsCOQ8bzhj3NOD4ykQ
         QmyMGf9rh+9PmQsbI+T90IfWYZmY8+H8GKVH6UK8X6+eJXACiVJg/rQDCb+B4c3adYsj
         Fof27y6Wo5A/kQAexaSrOg+2D8aydEzYs54m8BhvV6ynPPGLIFpJknWnapJJSB+oaQ6p
         o5A87zJc3+mwOrL1jAaklucoV6hIl24RuuRFBNM0SNyUmRycv/lxrsw9nwG6liXOWdtd
         e1zA==
X-Gm-Message-State: APjAAAWQhxyLp7lqWvSxvc+zz75fyT6Q8fVB5LF+o3qE2qdB9jSofV1D
        pWw2vsxk+WVgvDeaQ4/t/GI=
X-Google-Smtp-Source: APXvYqxWQXHAdfUdQ6GJTUNeOgHZmIR2VZ3tbLy6weX8AJjmrg1ykuzk7Ws8YQPQ9MhR3MQ1Poy4vw==
X-Received: by 2002:ae9:e316:: with SMTP id v22mr21598546qkf.256.1557785175354;
        Mon, 13 May 2019 15:06:15 -0700 (PDT)
Received: from [10.83.170.89] (179-240-184-89.3g.claro.net.br. [179.240.184.89])
        by smtp.gmail.com with ESMTPSA id q5sm9710153qtj.3.2019.05.13.15.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:06:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Mon, 13 May 2019 19:05:12 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com> <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf vendor events intel: Add uncore_upi JSON support
To:     "Liang, Kan" <kan.liang@linux.intel.com>, jolsa@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
CC:     ak@linux.intel.com
Message-ID: <23EB4484-49C2-47CE-BE31-1E83DBA29B87@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 13, 2019 6:29:30 PM GMT-03:00, "Liang, Kan" <kan=2Eliang@linux=2Eint=
el=2Ecom> wrote:
>Hi Arnaldo,
>
>Could you please apply this fix?

I think I merged this today, will check=2E

Thanks

- Arnaldo
>
>Thanks,
>Kan
>
>On 5/7/2019 9:16 AM, kan=2Eliang@linux=2Eintel=2Ecom wrote:
>> From: Kan Liang <kan=2Eliang@linux=2Eintel=2Ecom>
>>=20
>> Perf cannot parse UPI events=2E
>>=20
>>      #perf stat -e UPI_DATA_BANDWIDTH_TX
>>      event syntax error: 'UPI_DATA_BANDWIDTH_TX'
>>                       \___ parser error
>>      Run 'perf list' for a list of valid events
>>=20
>> The JSON lists call the box UPI LL, while perf calls it upi=2E
>> Add conversion support to json to convert the unit properly=2E
>>=20
>> Signed-off-by: Kan Liang <kan=2Eliang@linux=2Eintel=2Ecom>
>> ---
>>   tools/perf/pmu-events/jevents=2Ec | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/perf/pmu-events/jevents=2Ec
>b/tools/perf/pmu-events/jevents=2Ec
>> index 68c92bb=2E=2Edaaea50 100644
>> --- a/tools/perf/pmu-events/jevents=2Ec
>> +++ b/tools/perf/pmu-events/jevents=2Ec
>> @@ -235,6 +235,7 @@ static struct map {
>>   	{ "iMPH-U", "uncore_arb" },
>>   	{ "CPU-M-CF", "cpum_cf" },
>>   	{ "CPU-M-SF", "cpum_sf" },
>> +	{ "UPI LL", "uncore_upi" },
>>   	{}
>>   };
>>  =20
>>=20

