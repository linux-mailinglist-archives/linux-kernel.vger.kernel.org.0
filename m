Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB4179262
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 15:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgCDOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 09:36:12 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45264 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:36:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9V86-0007Lq-7y; Wed, 04 Mar 2020 07:36:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9V6V-0005fb-RG; Wed, 04 Mar 2020 07:36:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qian Cai <cai@lca.pw>, oleg@redhat.com,
        linux-kernel@vger.kernel.org
References: <87wo80lcqi.fsf@nanos.tec.linutronix.de>
Date:   Wed, 04 Mar 2020 08:32:22 -0600
In-Reply-To: <87wo80lcqi.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Wed, 04 Mar 2020 09:56:37 +0100")
Message-ID: <87lfogfax5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9V6V-0005fb-RG;;;mid=<87lfogfax5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZxI6RGtjE7slLwFYskhXIghFEN64IuMA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *******
X-Spam-Status: No, score=7.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMSubLong,XM_Palau_URI
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  5.0 XM_Palau_URI RAW: Palau .pw URI
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3628 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.1%), b_tie_ro: 2.00 (0.1%), parse: 1.52
        (0.0%), extract_message_metadata: 24 (0.7%), get_uri_detail_list: 2.2
        (0.1%), tests_pri_-1000: 25 (0.7%), tests_pri_-950: 1.80 (0.0%),
        tests_pri_-900: 1.52 (0.0%), tests_pri_-90: 21 (0.6%), check_bayes: 19
        (0.5%), b_tokenize: 7 (0.2%), b_tok_get_all: 6 (0.2%), b_comp_prob:
        1.81 (0.0%), b_tok_touch_all: 2.6 (0.1%), b_finish: 0.63 (0.0%),
        tests_pri_0: 321 (8.9%), check_dkim_signature: 0.48 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 3211 (88.5%),
        tests_pri_10: 3.2 (0.1%), tests_pri_500: 3223 (88.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH timers/core] posix-cpu-timers: Put the task_struct in posix_cpu_timers_create
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Qian Cai <cai@lca.pw> writes:
>>> The recent commit removed put_task_struct() in posix_cpu_timer_del()
>>> results in many memory leaks like this,
>>>
>>> unreferenced object 0xc0000016d9b44480 (size 8192):
>>>   comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
>>>   hex dump (first 32 bytes):
>>>     02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   backtrace:
>>>     [<0000000056aca129>] copy_process+0x26c/0x18e0
>>>     alloc_task_struct_node at kernel/fork.c:169
>>>     (inlined by) dup_task_struct at kernel/fork.c:877
>>>     (inlined by) copy_process at kernel/fork.c:1929
>>>     [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
>>>     [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
>>>     __do_sys_clone at kernel/fork.c:2591
>>>     [<000000006c059205>] ppc_clone+0x8/0xc
>>>     ppc_clone at arch/powerpc/kernel/entry_64.S:479
>>>
>>
>> I forgot that get_task_for_clock called by posix_cpu_timer_create
>> returns a reference to a task_struct.  Put that reference
>> to avoid the leak.
>
> I took the liberty to fold this back into the affected commit and add a
> comment why this put_task_struct() is actually required.

Good enough.

We should be able to use rcu and remove the reference entirely.
But that is a change for another day.

Eric
