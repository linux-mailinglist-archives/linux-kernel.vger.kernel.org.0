Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5589714968C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAYQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 11:15:20 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:38626 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgAYQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:15:19 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8E8112E12DF;
        Sat, 25 Jan 2020 19:15:17 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id UeYdkOdi7d-FG0umoYZ;
        Sat, 25 Jan 2020 19:15:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1579968917; bh=B6sdDPyNVdIg67M4l3o5kVQhl9OzerZH56rY3+HDr4I=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=UAKv0n4bO5cnIMTe4niKoA+u7+l3lsZcK6KWcEMUpA7TtjoN7i05ZsU+SatVmu7Pp
         T5Gkaf28T6A//e6DQ6UqDaaPHfaVNjMFmcPxdC6pB5dlixf9MEJFaklsrN8NyZLLIW
         MDW+bfv+qTy48DUVAaAauHuEnXJEGa/h7DWM4+Ho=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6910::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id AJZYip8hK8-FGWmlBa6;
        Sat, 25 Jan 2020 19:15:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] sched/rt: optimize checking group rt scheduler
 constraints
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
 <20200125153211.GP2437@uranus>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <417d11b4-d5a2-96c2-8007-5e8f90a422cb@yandex-team.ru>
Date:   Sat, 25 Jan 2020 19:15:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200125153211.GP2437@uranus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2020 18.32, Cyrill Gorcunov wrote:
> On Sat, Jan 25, 2020 at 05:50:38PM +0300, Konstantin Khlebnikov wrote:
> ...
>> -/* Must be called with tasklist_lock held */
>>   static inline int tg_has_rt_tasks(struct task_group *tg)
>>   {
>> -	struct task_struct *g, *p;
>> +	struct task_struct *task;
>> +	struct css_task_iter it;
>> +	int ret = 0;
>>   
>>   	/*
>>   	 * Autogroups do not have RT tasks; see autogroup_create().
>> @@ -2407,12 +2408,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>>   	if (task_group_is_autogroup(tg))
>>   		return 0;
>>   
>> -	for_each_process_thread(g, p) {
>> -		if (rt_task(p) && task_group(p) == tg)
>> -			return 1;
>> -	}
>> +	css_task_iter_start(&tg->css, 0, &it);
>> +	while (!ret && (task = css_task_iter_next(&it)))
>> +		ret |= rt_task(task);
> 
> Plain 'ret = rt_task(task);' won't work?

Should work too =)

> 
>> +	css_task_iter_end(&it);
>>   
>> -	return 0;
>> +	return ret;
>>   }
