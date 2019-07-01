Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21B91213D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 13:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58357 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEBRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2E463082E72;
        Thu,  2 May 2019 17:46:17 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7AC17D50;
        Thu,  2 May 2019 17:46:17 +0000 (UTC)
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules to
 finish loading
From:   Prarit Bhargava <prarit@redhat.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <20190430222207.3002-1-prarit@redhat.com>
 <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
 <20190502094813.GA6690@linux-8ccs>
 <f0bc15a4-0f99-c899-b7d7-2d4db86e287e@redhat.com>
Message-ID: <4849a5af-b2bb-95ad-6b58-2f0c403c9ebb@redhat.com>
Date:   Thu, 2 May 2019 13:46:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f0bc15a4-0f99-c899-b7d7-2d4db86e287e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 02 May 2019 17:46:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 8:41 AM, Prarit Bhargava wrote:
> 
> 
> On 5/2/19 5:48 AM, Jessica Yu wrote:
>> +++ Prarit Bhargava [01/05/19 17:26 -0400]:
>>>
>>>
>>> On 4/30/19 6:22 PM, Prarit Bhargava wrote:
>>>> On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>>>> loading the s390_trng.ko module.
>>>>
>>>> Add a reschedule point to the loop that waits for modules to complete
>>>> loading.
>>>>
>>>> v3: cleanup Fixes line.
>>>
>>> Jessica, even with this additional patch there appears to be some other issues
>>> in the module code that are causing significant delays in boot up on large
>>> systems.
>>
>> Is this limited to only s390? Or are you seeing this on other arches
>> as well? And is it limited to specific modules (like s390_trng)?
> 
> Other arches.  We're seeing a hang on a new 192 CPU x86_64 box & the
> acpi_cpufreq driver.  The system is MUCH faster than any other x86_64 box I've
> seen and that's likely why I'm seeing a problem.
> 
>>
>>> FWIW, the logic in the original patch is correct.  It's just that there's, as
>>> Heiko discovered, some poor scheduling, etc., that is impacting the module
>>> loading code after these changes.
>>
>> I am really curious to see what these performance regressions look
>> like :/ Please update us when you find out more.
>>
> 
> I sent Heiko a private v4 RFC last night with this patch (sorry for the
> cut-and-paste)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 1c429d8d2d74..a4ef8628f26f 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3568,12 +3568,12 @@ static int add_unformed_module(struct module *mod)
> 	mutex_lock(&module_mutex);
> 	old = find_module_all(mod->name, strlen(mod->name), true);
> 	if (old != NULL) {
> -		if (old->state == MODULE_STATE_COMING
> -		    || old->state == MODULE_STATE_UNFORMED) {
> +		if (old->state != MODULE_STATE_LIVE) {
> 			/* Wait in case it fails to load. */
> 			mutex_unlock(&module_mutex);
> -			err = wait_event_interruptible(module_wq,
> -					       finished_loading(mod->name));
> +			err = wait_event_interruptible_timeout(module_wq,
> +					       finished_loading(mod->name),
> +					       HZ / 10000);
> 			if (err)
> 				goto out_unlocked;
> 			goto again;
> 
> The original module dependency race issue is fixed simply by changing the
> conditional to checking !MODULE_STATE_LIVE.  This, unfortunately, exposed some
> other problems within the code.
> 
> The module_wq is only run when a module fails to load.  It's possible that
> the time between the module's failed init() call and running module_wq
> (kernel/module.c:3455) takes a while.  Any thread entering the
> add_unformed_module() code while the old module is unloading is put to sleep
> waiting for the module_wq to execute.
> 
> On the 192 thread box I have noticed that the acpi_cpufreq module attempts
> to load 392 times (that is not a typo and I am going to try to figure that
> problem out after this one).  This means 191 cpus are put to sleep, and one
> cpu is executing the acpi_cpufreq module unload which is executing
> do_init_module() and is now at
> 
> fail_free_freeinit:
>         kfree(freeinit);
> fail:
>         /* Try to protect us from buggy refcounters. */
>         mod->state = MODULE_STATE_GOING;
>         synchronize_rcu();
>         module_put(mod);
>         blocking_notifier_call_chain(&module_notify_list,
>                                      MODULE_STATE_GOING, mod);
>         klp_module_going(mod);
>         ftrace_release_mod(mod);
>         free_module(mod);
>         wake_up_all(&module_wq);
>         return ret;
> }
> 
> The 191 threads cannot schedule and the system is effectively stuck.  It *does*
> eventually free itself but in some cases it takes minutes to do so.
> 
> A simple fix for this is to, as I've done above, to add a timeout so that
> the threads can be scheduled which allows other processes to run.  

After taking a much closer look the above patch appears to be correct.  I am not
seeing any boot failures associated with it anywhere.  I would like to hear from
Heiko as to whether or not this works for him though.

P.
