Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABC8EAF30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfJaLyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 07:54:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40658 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:54:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id o28so5906136wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TwM8yoid/pgD+yKWv72AwDDMCTw9mmSq/lBPMO5sbE=;
        b=LyYv3b2zWQ6vOMX83t9UFfN+Zo9lvPjjmkczWP03oq5RkX5Q6JJC8IM1S7QI1mJitC
         aVmy5dOTjfIbgNL9GmkkKhvy34TyWpgA1CwO688EJYIMfmbs9oVpIg8Lf1bsY1yJtm0Q
         z2csHvii0lTTEBUjCEJbbHCLuHfR1juei77i56JkcwbR1AJx/RFkBzkfdqUQFoVX8Nt7
         2g0uB3MUD0+WLolArp2TUGM1lAL42zfhSiY5OHMyo4j4D922lv6XZ/YgsLxRMie3L7ac
         jrlAbuXBhupmYNUm0VOD6dqsq1x6SqisIzU7vwV6q7lcok68hgAeCpbDfHKDzTg/HdLW
         YaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8TwM8yoid/pgD+yKWv72AwDDMCTw9mmSq/lBPMO5sbE=;
        b=H5OPtH7KkgzQo5IgV3Zr1JPAI9P6QQFa6DYqafRsEuwnXekN8HX90bh+PhaBe+3Wkz
         a0FyaLWz/fCUg+iAX/nJLQP0igjE6bCOHACoZa5tufeiwjgYUJjsZB7Va8vJV77gzd/b
         qnNJT0XgX361vRzZaN1Qz+TOsNz92pBUH4bZRpiAKDz84urXBds3HabBXDQPvttDnKaM
         y8hAN6Zy+MwSUwocxhNGafpbJJY5n/qw0UQQ5huQZgrlOoLcoxWJoPO/2LZaP76gaOYg
         jdv8Vq1dDz7+lm1hkQfOS+W1uzaFUPnKvVpGEGsbAMsiObbh5O3XZiYQVyzkqg3QS9KF
         QZrg==
X-Gm-Message-State: APjAAAUGKqEK6Mf555+rzPvBXh+MzDlDTt6OiMBObKJ+ByJ83oU+tdj8
        FmE00ccYYXqOl7TR9pAUadHU6Q==
X-Google-Smtp-Source: APXvYqxQNEs8Vq7lHhVcZ28ETbRuoJhWomcalSmK0VlyivCUQtGpExoekKwntBxLA+2Fc/dkiOLT4Q==
X-Received: by 2002:adf:e488:: with SMTP id i8mr5141797wrm.302.1572522845747;
        Thu, 31 Oct 2019 04:54:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bc1d:8e1f:c99f:e225? ([2a01:e34:ed2f:f020:bc1d:8e1f:c99f:e225])
        by smtp.googlemail.com with ESMTPSA id g5sm3976392wmg.12.2019.10.31.04.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 04:54:05 -0700 (PDT)
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <c6169634-ab1d-6bda-183f-bdd06048736a@linaro.org>
 <20191031100631.GC19197@e108754-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2009bac3-405a-c60e-a1dd-191625ff3fc5@linaro.org>
Date:   Thu, 31 Oct 2019 12:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031100631.GC19197@e108754-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On 31/10/2019 11:07, Ionela Voinescu wrote:
> Hi Daniel,
> 
> On Tuesday 29 Oct 2019 at 16:34:11 (+0100), Daniel Lezcano wrote:
>> Hi Thara,
>>
>> On 22/10/2019 22:34, Thara Gopinath wrote:
>>> Thermal governors can respond to an overheat event of a cpu by
>>> capping the cpu's maximum possible frequency. This in turn
>>> means that the maximum available compute capacity of the
>>> cpu is restricted. But today in the kernel, task scheduler is 
>>> not notified of capping of maximum frequency of a cpu.
>>> In other words, scheduler is unware of maximum capacity
>>> restrictions placed on a cpu due to thermal activity.
>>> This patch series attempts to address this issue.
>>> The benefits identified are better task placement among available
>>> cpus in event of overheating which in turn leads to better
>>> performance numbers.
>>>
>>> The reduction in the maximum possible capacity of a cpu due to a 
>>> thermal event can be considered as thermal pressure. Instantaneous
>>> thermal pressure is hard to record and can sometime be erroneous
>>> as there can be mismatch between the actual capping of capacity
>>> and scheduler recording it. Thus solution is to have a weighted
>>> average per cpu value for thermal pressure over time.
>>> The weight reflects the amount of time the cpu has spent at a
>>> capped maximum frequency. Since thermal pressure is recorded as
>>> an average, it must be decayed periodically. Exisiting algorithm
>>> in the kernel scheduler pelt framework is re-used to calculate
>>> the weighted average. This patch series also defines a sysctl
>>> inerface to allow for a configurable decay period.
>>>
>>> Regarding testing, basic build, boot and sanity testing have been
>>> performed on db845c platform with debian file system.
>>> Further, dhrystone and hackbench tests have been
>>> run with the thermal pressure algorithm. During testing, due to
>>> constraints of step wise governor in dealing with big little systems,
>>> trip point 0 temperature was made assymetric between cpus in little
>>> cluster and big cluster; the idea being that
>>> big core will heat up and cpu cooling device will throttle the
>>> frequency of the big cores faster, there by limiting the maximum available
>>> capacity and the scheduler will spread out tasks to little cores as well.
>>>
>>> Test Results
>>>
>>> Hackbench: 1 group , 30000 loops, 10 runs       
>>>                                                Result         SD             
>>>                                                (Secs)     (% of mean)     
>>>  No Thermal Pressure                            14.03       2.69%           
>>>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%         
>>>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%           
>>>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%         
>>>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%           
>>>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%  
>>>
>>> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>>>                                                  Result      SD             
>>>                                                  (Secs)    (% of mean)     
>>>  No Thermal Pressure                              9.452      4.49%
>>>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>>>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>>>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>>>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>>>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%  
>>
>> I took the opportunity to try glmark2 on the db845c platform with the
>> default decay and got the following glmark2 scores:
>>
>> Without thermal pressure:
>>
>> # NumSamples = 9; Min = 790.00; Max = 805.00
>> # Mean = 794.888889; Variance = 19.209877; SD = 4.382907; Median 794.000000
>> # each ∎ represents a count of 1
>>   790.0000 -   791.5000 [     2]: ∎∎
>>   791.5000 -   793.0000 [     2]: ∎∎
>>   793.0000 -   794.5000 [     2]: ∎∎
>>   794.5000 -   796.0000 [     1]: ∎
>>   796.0000 -   797.5000 [     0]:
>>   797.5000 -   799.0000 [     1]: ∎
>>   799.0000 -   800.5000 [     0]:
>>   800.5000 -   802.0000 [     0]:
>>   802.0000 -   803.5000 [     0]:
>>   803.5000 -   805.0000 [     1]: ∎
>>
>>
>> With thermal pressure:
>>
>> # NumSamples = 9; Min = 933.00; Max = 960.00
>> # Mean = 940.777778; Variance = 64.172840; SD = 8.010795; Median 937.000000
>> # each ∎ represents a count of 1
>>   933.0000 -   935.7000 [     3]: ∎∎∎
>>   935.7000 -   938.4000 [     2]: ∎∎
>>   938.4000 -   941.1000 [     2]: ∎∎
>>   941.1000 -   943.8000 [     0]:
>>   943.8000 -   946.5000 [     0]:
>>   946.5000 -   949.2000 [     1]: ∎
>>   949.2000 -   951.9000 [     0]:
>>   951.9000 -   954.6000 [     0]:
>>   954.6000 -   957.3000 [     0]:
>>   957.3000 -   960.0000 [     1]: ∎
>>
> 
> Interesting! If I'm interpreting these correctly there seems to be
> significant improvement when applying thermal pressure.
>
> I'm not familiar with glmark2, can you tell me more about the process
> and the work that the benchmark does?

glmark2 is a 3D benchmark. I ran it without parameters, so all tests are
run. At the end, it gives a score which are the values given above.

> I assume this is a GPU benchmark,
> but not knowing more about it I fail to see the correlation between
> applying thermal pressure to CPU capacities and the improvement of GPU
> performance.
> Do you happen to know more about the behaviour that resulted in these
> benchmark scores?

My hypothesis is glmark2 makes the GPU to contribute a lot to the
heating effect, thus increasing the temperature to the CPU close to it.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

