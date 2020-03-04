Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25543178A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 06:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCDFXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 00:23:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59444 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgCDFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:23:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MVJ-00082y-7k; Tue, 03 Mar 2020 22:23:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MV6-0003OP-Vb; Tue, 03 Mar 2020 22:23:33 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20200304004336.960-1-cai@lca.pw>
Date:   Tue, 03 Mar 2020 23:21:11 -0600
In-Reply-To: <20200304004336.960-1-cai@lca.pw> (Qian Cai's message of "Tue, 3
        Mar 2020 19:43:36 -0500")
Message-ID: <877e00hf08.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9MV6-0003OP-Vb;;;mid=<877e00hf08.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+dbHGiv/ztm3INrbnp2Mweg4CvI0F3KI=
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
        *      [score: 0.5000]
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
X-Spam-Combo: *******;Qian Cai <cai@lca.pw>
X-Spam-Relay-Country: 
X-Spam-Timing: total 11831 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 4.3 (0.0%), b_tie_ro: 2.7 (0.0%), parse: 1.40
        (0.0%), extract_message_metadata: 18 (0.2%), get_uri_detail_list: 2.1
        (0.0%), tests_pri_-1000: 13 (0.1%), tests_pri_-950: 1.59 (0.0%),
        tests_pri_-900: 1.19 (0.0%), tests_pri_-90: 23 (0.2%), check_bayes: 21
        (0.2%), b_tokenize: 7 (0.1%), b_tok_get_all: 7 (0.1%), b_comp_prob:
        2.2 (0.0%), b_tok_touch_all: 3.2 (0.0%), b_finish: 0.72 (0.0%),
        tests_pri_0: 247 (2.1%), check_dkim_signature: 0.81 (0.0%),
        check_dkim_adsp: 2.5 (0.0%), poll_dns_idle: 11463 (96.9%),
        tests_pri_10: 2.1 (0.0%), tests_pri_500: 11514 (97.3%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH timers/core] posix-cpu-timers: Put the task_struct in posix_cpu_timers_create
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qian Cai <cai@lca.pw> writes:
> The recent commit removed put_task_struct() in posix_cpu_timer_del()
> results in many memory leaks like this,
>
> unreferenced object 0xc0000016d9b44480 (size 8192):
>   comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000056aca129>] copy_process+0x26c/0x18e0
>     alloc_task_struct_node at kernel/fork.c:169
>     (inlined by) dup_task_struct at kernel/fork.c:877
>     (inlined by) copy_process at kernel/fork.c:1929
>     [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
>     [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
>     __do_sys_clone at kernel/fork.c:2591
>     [<000000006c059205>] ppc_clone+0x8/0xc
>     ppc_clone at arch/powerpc/kernel/entry_64.S:479
>

I forgot that get_task_for_clock called by posix_cpu_timer_create
returns a reference to a task_struct.  Put that reference
to avoid the leak.

Link: https://lore.kernel.org/lkml/20200304004336.960-1-cai@lca.pw/
Fixes: 672ebe8eb017a5 ("posix-cpu-timers: Store a reference to a pid not a task")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 1c21f2fd3d9b..cd88c1217224 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -405,6 +405,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
+	put_task_struct(p);
 	return 0;
 }
 
-- 
2.20.1

