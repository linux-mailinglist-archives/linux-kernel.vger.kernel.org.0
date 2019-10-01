Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF5CC3D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfJAQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:57:17 -0400
Received: from foss.arm.com ([217.140.110.172]:54326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfJAQ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:57:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15EA71570;
        Tue,  1 Oct 2019 09:57:13 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9613F706;
        Tue,  1 Oct 2019 09:57:11 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <46e81a81-f88e-c935-d452-9b746bde492b@arm.com>
 <CAKfTPtA7E5p1VZ+Ujbw4Sgp2fw8+TmSiLR-fGuUAdk=R8cQ9VQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <36d904ff-44fa-a561-677d-4858d5921b69@arm.com>
Date:   Tue, 1 Oct 2019 18:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA7E5p1VZ+Ujbw4Sgp2fw8+TmSiLR-fGuUAdk=R8cQ9VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2019 11:14, Vincent Guittot wrote:
> group_asym_packing
> 
> On Tue, 1 Oct 2019 at 10:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 19/09/2019 09:33, Vincent Guittot wrote:
>>
>>
>> [...]
>>
>>> @@ -8042,14 +8104,24 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>>               }
>>>       }
>>>
>>> -     /* Adjust by relative CPU capacity of the group */
>>> +     /* Check if dst cpu is idle and preferred to this group */
>>> +     if (env->sd->flags & SD_ASYM_PACKING &&
>>> +         env->idle != CPU_NOT_IDLE &&
>>> +         sgs->sum_h_nr_running &&
>>> +         sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
>>> +             sgs->group_asym_packing = 1;
>>> +     }
>>> +
>>
>> Since asym_packing check is done per-sg rather per-CPU (like misfit_task), can you
>> not check for asym_packing in group_classify() directly (like for overloaded) and
>> so get rid of struct sg_lb_stats::group_asym_packing?
> 
> asym_packing uses a lot of fields of env to set group_asym_packing but
> env is not statistics and i'd like to remove env from
> group_classify() argument so it will use only statistics.
> At now, env is an arg of group_classify only for imbalance_pct field
> and I have replaced env by imabalnce_pct in a patch that is under
> preparation.
> With this change, I can use group_classify outside load_balance()

OK, I see. This relates to the 'update find_idlest_group() to be more
aligned with load_balance()' point mentioned in the cover letter I
assume. To make sure we can use load instead of runnable_load there as well.

[...]
