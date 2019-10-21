Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2ADE361
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 06:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfJUEmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 00:42:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJUEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:42:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54CD660540; Mon, 21 Oct 2019 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571632969;
        bh=LxSPS9povQX36JoqXj8w2x0lEpI8OwX5FPkhEIdxh+s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KKQt4bojppWwJUoZ0NLEKWvLFfpugEEeE7b79dE+7d1FcskMpGxaWE77CNqeFaLQw
         kJ08iecKprhngrNDFz8kvYu8X9bZcFRI6a0ZfcbJrOAecwwbrg1dyKUQeVShU/RwaD
         3TeqVbbBZnaH363tcErZ16V/170n1CvEFeLxYX+8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB9A2602F0;
        Mon, 21 Oct 2019 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571632968;
        bh=LxSPS9povQX36JoqXj8w2x0lEpI8OwX5FPkhEIdxh+s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L/puHcuNyIPs/xGB9ziSAi38nY3K63+HmeyopPk9KwyW9n1eaaS77FXg9V1+qzoic
         0Y0dY4k3yNmpSApLGyRbnXpCHrrGbqoAha7+H9VPoHBHtP+zykddZmUuOgiMVmjb21
         8C4MK6Ijh1qfLzb3ketVyL0tffec2VoHrzHn8Qi8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB9A2602F0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] trace: fix race in perf_trace_buf initialization
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        kaushalk@codeaurora.org, Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
References: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
 <20191018171216.3e446f1e@gandalf.local.home>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <59d02ee4-5329-5cfd-1fc2-790d99fe4b0d@codeaurora.org>
Date:   Mon, 21 Oct 2019 10:12:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191018171216.3e446f1e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/19 2:42 AM, Steven Rostedt wrote:
> 
> Peter told me it was fine, but I'm also adding Song who is the author
> of the code.
> 
> Also needs the tags (which I'll add)
> 
> Cc: stable@vger.kernel.org
> Fixes: e12f03d7031a9 ("perf/core: Implement the 'perf_kprobe' PMU")
> 
> -- Steve
> 
> 
> On Tue, 15 Oct 2019 11:47:25 +0530
> Prateek Sood <prsood@codeaurora.org> wrote:
> 
>> [  943.034988] Unable to handle kernel paging request at virtual address 0000003106f2003c
>> [  943.043653] Mem abort info:
>> [  943.046679]   ESR = 0x96000045
>> [  943.050428]   Exception class = DABT (current EL), IL = 32 bits
>> [  943.056643]   SET = 0, FnV = 0
>> [  943.060168]   EA = 0, S1PTW = 0
>> [  943.063449] Data abort info:
>> [  943.066474]   ISV = 0, ISS = 0x00000045
>> [  943.070856]   CM = 0, WnR = 1
>> [  943.074016] user pgtable: 4k pages, 39-bit VAs, pgdp = ffffffc034b9b000
>> [  943.081446] [0000003106f2003c] pgd=0000000000000000, pud=0000000000000000
>> [  943.088862] Internal error: Oops: 96000045 [#1] PREEMPT SMP
>> [  943.141700] Process syz-executor (pid: 18393, stack limit = 0xffffffc093190000)
>> [  943.164146] pstate: 80400005 (Nzcv daif +PAN -UAO)
>> [  943.169119] pc : __memset+0x20/0x1ac
>> [  943.172831] lr : memset+0x3c/0x50
>> [  943.176269] sp : ffffffc09319fc50
>>
>> [  943.557593]  __memset+0x20/0x1ac
>> [  943.560953]  perf_trace_buf_alloc+0x140/0x1a0
>> [  943.565472]  perf_trace_sys_enter+0x158/0x310
>> [  943.569985]  syscall_trace_enter+0x348/0x7c0
>> [  943.574413]  el0_svc_common+0x11c/0x368
>> [  943.578394]  el0_svc_handler+0x12c/0x198
>> [  943.582459]  el0_svc+0x8/0xc
>>
>> In Ramdumps:
>> total_ref_count = 3
>> perf_trace_buf = (
>>     0x0 -> NULL,
>>     0x0 -> NULL,
>>     0x0 -> NULL,
>>     0x0 -> NULL)
>>
>> event_call in perf_trace_sys_enter()
>> event_call = 0xFFFFFF900CB511D8 -> (
>>     list = (next = 0xFFFFFF900CB4E2E0, prev = 0xFFFFFF900CB512B0),
>>     class = 0xFFFFFF900CDC8308,
>>     name = 0xFFFFFF900CDDA1D8,
>>     tp = 0xFFFFFF900CDDA1D8,
>>     event = (
>>       node = (next = 0x0, pprev = 0xFFFFFF900CB80210),
>>       list = (next = 0xFFFFFF900CB512E0, prev = 0xFFFFFF900CB4E310),
>>       type = 21,
>>       funcs = 0xFFFFFF900CB51130),
>>     print_fmt = 0xFFFFFF900CB51150,
>>     filter = 0x0,
>>     mod = 0x0,
>>     data = 0x0,
>>     flags = 18,
>>     perf_refcount = 1,
>>     perf_events = 0xFFFFFF8DB8E54158,
>>     prog_array = 0x0,
>>     perf_perm = 0x0)
>>
>> perf_events added on CPU0
>> (struct hlist_head *)(0xFFFFFF8DB8E54158+__per_cpu_offset[0]) -> (
>>     first = 0xFFFFFFC0980FD0E0 -> (
>>       next = 0x0,
>>       pprev = 0xFFFFFFBEBFD74158))
>>
>> Could you please confirm:
>> 1) the race mentioned below exists or not.
>> 2) if following patch fixes it.
>>
>>
>>> 8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8  
>>
>> A race condition exists while initialiazing perf_trace_buf from
>> perf_trace_init() and perf_kprobe_init().
>>
>>       CPU0                                        CPU1
>> perf_trace_init()
>>   mutex_lock(&event_mutex)
>>     perf_trace_event_init()
>>       perf_trace_event_reg()
>>         total_ref_count == 0
>> 	buf = alloc_percpu()
>>         perf_trace_buf[i] = buf
>>         tp_event->class->reg() //fails       perf_kprobe_init()
>> 	goto fail                              perf_trace_event_init()
>>                                                  perf_trace_event_reg()
>>         fail:
>> 	  total_ref_count == 0
>>
>>                                                    total_ref_count == 0
>>                                                    buf = alloc_percpu()
>>                                                    perf_trace_buf[i] = buf
>>                                                    tp_event->class->reg()
>>                                                    total_ref_count++
>>
>>           free_percpu(perf_trace_buf[i])
>>           perf_trace_buf[i] = NULL
>>
>> Any subsequent call to perf_trace_event_reg() will observe total_ref_count > 0,
>> causing the perf_trace_buf to be NULL always. This can result in perf_trace_buf
>> getting accessed from perf_trace_buf_alloc() without being initialized. Acquiring
>> event_mutex in perf_kprobe_init() before calling perf_trace_event_init() should
>> fix this race.
>>
>> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
>> ---
>>  kernel/trace/trace_event_perf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
>> index 4629a61..48ee92c 100644
>> --- a/kernel/trace/trace_event_perf.c
>> +++ b/kernel/trace/trace_event_perf.c
>> @@ -272,9 +272,11 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>>  		goto out;
>>  	}
>>  
>> +	mutex_lock(&event_mutex);
>>  	ret = perf_trace_event_init(tp_event, p_event);
>>  	if (ret)
>>  		destroy_local_trace_kprobe(tp_event);
>> +	mutex_unlock(&event_mutex);
>>  out:
>>  	kfree(func);
>>  	return ret;
>> @@ -282,8 +284,10 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>>  
>>  void perf_kprobe_destroy(struct perf_event *p_event)
>>  {
>> +	mutex_lock(&event_mutex);
>>  	perf_trace_event_close(p_event);
>>  	perf_trace_event_unreg(p_event);
>> +	mutex_unlock(&event_mutex);
>>  
>>  	destroy_local_trace_kprobe(p_event->tp_event);
>>  }
> 

Hi Song,

Could you please help in this query.


Thanks
Prateek

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
