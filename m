Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D60138CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 03:21:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:50458 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAMIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:21:06 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00D8L3x4061832;
        Mon, 13 Jan 2020 17:21:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Mon, 13 Jan 2020 17:21:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00D8KvJP061816
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 13 Jan 2020 17:21:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] sched/core: fix illegal RCU from offline CPUs
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, paulmck@kernel.org,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200112161752.10492-1-cai@lca.pw>
 <3ffaaf32-88b6-fdf1-c7c7-ab56292c047f@I-love.SAKURA.ne.jp>
 <7168A4A4-E735-4809-B80A-389990603EB8@lca.pw>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <66e33eb5-e958-6dc8-2327-4168afdd9e1e@i-love.sakura.ne.jp>
Date:   Mon, 13 Jan 2020 17:20:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7168A4A4-E735-4809-B80A-389990603EB8@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/13 15:30, Qian Cai wrote:
>>> -	mmdrop(mm);
>>> +	smp_call_function_single(cpumask_first(cpu_online_mask),
>>> +				(void (*)(void *))mmdrop, mm, 0);
>>
>> mmdrop() might sleep, but
> 
> If that is the case, and then the commit e78a7614f387 (“idle: Prevent
> late-arriving interrupts from disrupting offline”) is incorrect because it
> will disable local irq before calling mmdrop() which will trigger
> the might_sleep() warning. Can you prove it?

Is commit 7283094ec3db318e ("kernel, oom: fix potential pgd_lock deadlock from
__mmdrop") about only softirq? Is it guaranteed that smp_call_function_single()
does not hit such race? Then just my overcareful...
