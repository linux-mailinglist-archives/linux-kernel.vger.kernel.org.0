Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3531789EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCDFSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 00:18:04 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38602 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgCDFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:18:03 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MPp-0007RD-8g; Tue, 03 Mar 2020 22:17:53 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MPo-0000FJ-Fj; Tue, 03 Mar 2020 22:17:53 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20200304004336.960-1-cai@lca.pw>
Date:   Tue, 03 Mar 2020 23:15:43 -0600
In-Reply-To: <20200304004336.960-1-cai@lca.pw> (Qian Cai's message of "Tue, 3
        Mar 2020 19:43:36 -0500")
Message-ID: <87eeu8hf9c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9MPo-0000FJ-Fj;;;mid=<87eeu8hf9c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/FMuuJ1tVH9jD5uBGuCXk2Slxsx30rT5M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ******
X-Spam-Status: No, score=6.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubLong,XM_Palau_URI autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  5.0 XM_Palau_URI RAW: Palau .pw URI
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Qian Cai <cai@lca.pw>
X-Spam-Relay-Country: 
X-Spam-Timing: total 261 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.4 (1.3%), b_tie_ro: 2.3 (0.9%), parse: 1.05
        (0.4%), extract_message_metadata: 13 (5.1%), get_uri_detail_list: 1.72
        (0.7%), tests_pri_-1000: 3.9 (1.5%), tests_pri_-950: 1.00 (0.4%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 18 (6.8%), check_bayes: 17
        (6.4%), b_tokenize: 4.6 (1.8%), b_tok_get_all: 6 (2.2%), b_comp_prob:
        1.59 (0.6%), b_tok_touch_all: 2.8 (1.1%), b_finish: 0.62 (0.2%),
        tests_pri_0: 198 (75.9%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.4 (0.9%), poll_dns_idle: 0.75 (0.3%), tests_pri_10:
        2.7 (1.0%), tests_pri_500: 16 (6.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] posix-cpu-timers: fix memory leaks for task_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

> The recent commit removed put_task_struct() in posix_cpu_timer_del()
> results in many memory leaks like this,

Good spotting but no.  The leak is in posix_cpu_timer_create.
There is a strong likely hood but no guarantee that the task
in posix_cpu_timer_del is the same as the task in
posix_cpu_timer_create.

Plus the point of it all is to use pid references instead of task
references.

Thank you very much for catching my braino.

Eric


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
> Fixes: 672ebe8eb017a5 ("posix-cpu-timers: Store a reference to a pid not a task")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/time/posix-cpu-timers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index afd1e959a282..e0b580deb61a 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -446,8 +446,10 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
>  
>  out:
>  	rcu_read_unlock();
> -	if (!ret)
> +	if (!ret) {
>  		put_pid(ctmr->pid);
> +		put_task_struct(p);
> +	}
>  
>  	return ret;
>  }
