Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB55218991A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 11:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCRKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 06:17:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47052 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:17:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so13141294wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZv7ZiJnYy7O+GspruPLZPhOyD1QHibwiiuuPjwmjfc=;
        b=tG8MpyL6ip0jayv+CXaJlVaRd5HgA1qR/4b+55UZ2uoBZKzP0i4mdRsGPWflruCh8h
         Z4Su8dabGO7KAYuUeSgkhX41G7jrE0sQKhrg+QJad0wiw4imlQCSjJY8tz2v/qA0Vawq
         AAjGr8TzviBLI5VE1jkH2nOIq2uDPHBANs3F78aoZIsVGdaCYaYjYGEtZM7uR79K2keO
         jrLxXukPkeI8FtUAfgY2RwG5b+FPCmt7CwhsSTBL+g5KwODu+Dohm+pldupvQf4p09Tj
         AVGZumq8hq1CR3J6FQG8CUjWiINeAU6WrICTgrikc2CaMghK7JG1Gw6dHQOONacjoj77
         HVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fZv7ZiJnYy7O+GspruPLZPhOyD1QHibwiiuuPjwmjfc=;
        b=Nfyp9w7BL3KTH1WypeJTWkypHEF/TS9mzJ/STtMOC2ylI4/QUeOh2T45G8ZQe6+VXZ
         CFGOYz/1YcAZAo/xuNbljf2Ojc0ncf7w/MnZErUnrpAfCVPL7PjxfEG1KC5qhQnMCnKf
         lrxu17TcTcrO85X7hBuRLaEtzyrHAOS/lLJ6MBWsIElf2lNw1aqToLfNuOdc4DKgEtM+
         il6eUzJqOpF05O7KZGK1IKSCyrS115oYtF3tLmYpA0MA4nqF4Z5K761QDTZCY77puPRB
         wFOxlRAU7DPXgu30CV6ckd9UG3jVYun1QxVHVscvU6kVAV49RElRJLeyLKqdILTEfFLf
         +BZA==
X-Gm-Message-State: ANhLgQ0afww8OKZKzFd1/5yPL+7qIo7HBK7M0PMCw3t8cMcTNdAMHPUX
        n/y9gFJseUTjqer5eInDLb/T/g==
X-Google-Smtp-Source: ADFU+vvSK5NaXiIvy0T6X3a51DECnK2CKf5W7AZySyBmQld/b7l+IqfRs7A1OXV20GLUt9YhYz/lqQ==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr5083707wre.105.1584526674510;
        Wed, 18 Mar 2020 03:17:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bd37:618d:f415:31ea? ([2a01:e34:ed2f:f020:bd37:618d:f415:31ea])
        by smtp.googlemail.com with ESMTPSA id q13sm8674887wrs.91.2020.03.18.03.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:17:53 -0700 (PDT)
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org>
 <20200317075607.GE10914@e105550-lin.cambridge.arm.com>
 <3520b762-08f5-0db8-30cb-372709188bb9@linaro.org>
 <20200317143053.GF10914@e105550-lin.cambridge.arm.com>
 <7cd04d35-3522-30fb-82e9-82fdf53d0957@linaro.org>
 <20200318082452.GA6103@e123083-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <798e9bde-a207-3a0e-0f13-0e27d60fd286@linaro.org>
Date:   Wed, 18 Mar 2020 11:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318082452.GA6103@e123083-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2020 09:24, Morten Rasmussen wrote:
> On Tue, Mar 17, 2020 at 06:07:43PM +0100, Daniel Lezcano wrote:
>> On 17/03/2020 15:30, Morten Rasmussen wrote:
>>> On Tue, Mar 17, 2020 at 02:48:51PM +0100, Daniel Lezcano wrote:
>>>> On 17/03/2020 08:56, Morten Rasmussen wrote:
>>>>> On Thu, Mar 12, 2020 at 11:04:19AM +0100, Daniel Lezcano wrote:
>>>>>>>> In order to be more energy efficient but without impacting the
>>>>>>>> performances, let's use another criteria: the break even deadline.
>>>>>>>>
>>>>>>>> At idle time, when we store the idle state the CPU is entering in, we
>>>>>>>> compute the next deadline where the CPU could be woken up without
>>>>>>>> spending more energy to sleep.
>>>>>
>>>>> I don't follow the argument that sleeping longer should improve energy
>>>>> consumption. 
>>>>
>>>> May be it is not explained correctly.
>>>>
>>>> The patch is about selecting a CPU with the smallest break even deadline
>>>> value. In a group of idle CPUs in the same idle state, we will pick the
>>>> one with the smallest break even dead line which is the one with the
>>>> highest probability it already reached its target residency.
>>>>
>>>> It is best effort.
>>>
>>> Indeed. I get what the patch does, I just don't see how the patch
>>> improves energy efficiency.
>>
>> If the CPU is woken up before it reached the break even, the idle state
>> cost in energy is greater than the energy it saved.
>>
>> Am I misunderstanding your point?
> 
> Considering just the waking then yes, it reaches energy break-even.
> However, considering all the CPUs in the system, it just moves the idle
> entry/exit energy cost to a different CPU, it doesn't go away.
> 
> Whether you have:
> 
>                |-BE-|
>            ____    ____
> CPU0:  ___/    \__/    \___
> 
> CPU1:  ____________________
> 
> Or:
>                |-BE-|
>            ____
> CPU0:  ___/    \___________
>                    ____
> CPU1:  ___________/    \___
> 
> _
>   = CPU busy = P_{busy}
> _ = CPU idle = P_{idle}
> / = CPU idle exit = P_{exit}
> \ = CPU idle entry = P_{entry}
> 
> The sum of areas under the curves is the same, i.e. the total energy is
> unchanged.

It is a counter-intuitive comment, now I get it, thanks for the
clarification. It is a good point.

Taking into consideration the dynamic, in the case #1, the break even is
not reached, the idle duration is smaller and that leads the governor to
choose shallower idle states after and consequently CPU0 will be used in
priority. We end up with CPU0 in a shallow state and CPU1 in a deep state.

With the case #2, we can have the CPUs in both deep state and the
governor should be keeping choosing the same idle state.

I don't know what is more energy/perf efficient. IMO this is very
workload dependent. The only way to check is to test. Hopefully I can
find a platform for that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

