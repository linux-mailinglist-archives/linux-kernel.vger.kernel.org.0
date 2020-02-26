Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4B16FBD3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgBZKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 05:15:23 -0500
Received: from foss.arm.com ([217.140.110.172]:33262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgBZKPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:15:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D4C1FB;
        Wed, 26 Feb 2020 02:15:22 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2B553F9E6;
        Wed, 26 Feb 2020 02:15:21 -0800 (PST)
Subject: Re: [PATCH 2/3] sched/debug: Bunch up printing formats in common
 macros
To:     Tao Zhou <t1zhou@aliyun.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com
References: <20200225175227.22090-1-valentin.schneider@arm.com>
 <20200225175227.22090-3-valentin.schneider@arm.com>
 <20200226072121.GA8957@geo.homenetwork>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <32939f53-3916-07d5-c92b-1b57339dfe65@arm.com>
Date:   Wed, 26 Feb 2020 10:15:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226072121.GA8957@geo.homenetwork>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/02/2020 07:21, Tao Zhou wrote:
>> @@ -963,8 +962,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>>  
>>  		t0 = cpu_clock(this_cpu);
>>  		t1 = cpu_clock(this_cpu);
>> -		SEQ_printf(m, "%-45s:%21Ld\n",
>> -			   "clock-delta", (long long)(t1-t0));
>> +		__PS("clock-delta", t1-t0);
> 
>         __PS("clock-delta", (t1-t0));

Oh snap indeed! I think I may just as well shove parentheses in the macro
definitions.

Thanks.

> 
> Thanks,
> Tao
>>  	}
>>  
>>  	sched_show_numa(p, m);
>> -- 
>> 2.24.0
>>
