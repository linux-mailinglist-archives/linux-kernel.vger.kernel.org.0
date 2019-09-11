Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0710B02B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfIKRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 13:32:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40357 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfIKRco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:32:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i86Tw-0002nA-MY; Wed, 11 Sep 2019 11:32:40 -0600
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i86Tv-0005Lh-OI; Wed, 11 Sep 2019 11:32:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20190910175852.GA15572@asgard.redhat.com>
Date:   Wed, 11 Sep 2019 12:32:17 -0500
In-Reply-To: <20190910175852.GA15572@asgard.redhat.com> (Eugene
        Syromiatnikov's message of "Tue, 10 Sep 2019 18:58:52 +0100")
Message-ID: <87d0g691su.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i86Tv-0005Lh-OI;;;mid=<87d0g691su.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=213.30.8.110;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Q8+CvTzcoLi+RF1BzgBUOMruIPSj6/JI=
X-SA-Exim-Connect-IP: 213.30.8.110
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Eugene Syromiatnikov <esyr@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 372 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.2 (0.9%), b_tie_ro: 2.2 (0.6%), parse: 0.94
        (0.3%), extract_message_metadata: 15 (3.9%), get_uri_detail_list: 2.00
        (0.5%), tests_pri_-1000: 13 (3.6%), tests_pri_-950: 1.33 (0.4%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 24 (6.6%), check_bayes: 23
        (6.1%), b_tokenize: 7 (2.0%), b_tok_get_all: 7 (2.0%), b_comp_prob:
        2.7 (0.7%), b_tok_touch_all: 3.1 (0.8%), b_finish: 0.68 (0.2%),
        tests_pri_0: 301 (80.9%), check_dkim_signature: 0.99 (0.3%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] fork: check exit_signal passed in clone3() call
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Syromiatnikov <esyr@redhat.com> writes:

> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Moreover, as Oleg has noted[1], exit_signal is used
> unchecked, so it has to be checked for sanity before use; for the legacy
> syscalls, applying CSIGNAL mask guarantees that it is at least non-negative;
> however, there's no such thing is done in clone3() code path, and that can
> break at least thread_group_leader.
>
> Checking user-passed exit_signal against ~CSIGNAL mask solves both
> of these problems.
>
> [1] https://lkml.org/lkml/2019/9/10/467
>
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal has bits set outside CSIGNAL mask.
> (_do_fork): Note that exit_signal is expected to be checked for the
> sanity by the caller.
>
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  kernel/fork.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e..9dee2ab 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2338,6 +2338,8 @@ struct mm_struct *copy_init_mm(void)
>   *
>   * It copies the process, and if successful kick-starts
>   * it and waits for it to finish using the VM if required.
> + *
> + * args->exit_signal is expected to be checked for sanity by the caller.
>   */
>  long _do_fork(struct kernel_clone_args *args)
>  {
> @@ -2562,6 +2564,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  	if (copy_from_user(&args, uargs, size))
>  		return -EFAULT;
>  
> +	/*
> +	 * exit_signal is confined to CSIGNAL mask in legacy syscalls,
> +	 * so it is used unchecked deeper in syscall handling routines;
> +	 * moreover, copying to struct kernel_clone_args.exit_signals
> +	 * trims higher 32 bits, so it is has to be checked that they
> +	 * are zero.
> +	 */
> +	if (unlikely(args.exit_signal & ~((u64)CSIGNAL)))
> +		return -EINVAL;
> +
>  	*kargs = (struct kernel_clone_args){
>  		.flags		= args.flags,
>  		.pidfd		= u64_to_user_ptr(args.pidfd),
