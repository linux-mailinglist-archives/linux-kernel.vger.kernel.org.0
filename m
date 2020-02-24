Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD016B21E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 16:22:38 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46662 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBXVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:22:37 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LBT-0007lJ-1K; Mon, 24 Feb 2020 14:22:35 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LBR-0002HL-BN; Mon, 24 Feb 2020 14:22:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Feng Tang <feng.tang@intel.com>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang\, Ying" <ying.huang@intel.com>
References: <20200205123216.GO12867@shao2-debian>
        <20200205125804.GM14879@hirez.programming.kicks-ass.net>
        <20200221080325.GA67807@shbuild999.sh.intel.com>
        <20200221132048.GE652992@krava>
        <20200223141147.GA53531@shbuild999.sh.intel.com>
        <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
        <20200224003301.GA5061@shbuild999.sh.intel.com>
        <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
        <20200224021915.GC5061@shbuild999.sh.intel.com>
        <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
        <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
        <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
Date:   Mon, 24 Feb 2020 15:20:26 -0600
In-Reply-To: <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 24 Feb 2020 12:47:14 -0800")
Message-ID: <87a757znqd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6LBR-0002HL-BN;;;mid=<87a757znqd.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SSyf6yZIP/k5uVMtCOs9svimc0568GaY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 707 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 3.1 (0.4%), parse: 1.64
        (0.2%), extract_message_metadata: 12 (1.8%), get_uri_detail_list: 2.0
        (0.3%), tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.38 (0.2%),
        tests_pri_-900: 1.32 (0.2%), tests_pri_-90: 35 (4.9%), check_bayes: 33
        (4.6%), b_tokenize: 10 (1.4%), b_tok_get_all: 11 (1.5%), b_comp_prob:
        3.6 (0.5%), b_tok_touch_all: 5 (0.7%), b_finish: 1.51 (0.2%),
        tests_pri_0: 627 (88.7%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 12 (1.7%), poll_dns_idle: 0.48 (0.1%), tests_pri_10:
        4.0 (0.6%), tests_pri_500: 10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5% regression
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Adding a few more people that tend to be involved in signal
> handling. Just in case - even if they probably don't care ]
>
> On Mon, Feb 24, 2020 at 12:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> TOTALLY UNTESTED patch attached. It may be completely buggy garbage,
>> but it _looks_ trivial enough.
>
> I've tested it, and the profiles on the silly microbenchmark look much
> nicer. Now it's just the sigpending update shows up, the refcount case
> clearly still occasionally happens, but it's now in the noise.
>
> I made slight changes to the __sigqueue_alloc() case to generate
> better code: since we now use that atomic_inc_return() anyway, we
> might as well then use the value that is returned for the
> RLIMIT_SIGPENDING check too, instead of reading it again.
>
> That might avoid another potential cacheline bounce, plus the
> generated code just looks better.
>
> Updated (and now slightly tested!) patch attached.
>
> It would be interesting if this is noticeable on your benchmark
> numbers. I didn't actually _time_ anything, I just looked at profiles.
>
> But my setup clearly isn't going to see the horrible contention case
> anyway, so my timing numbers wouldn't be all that interesting.
>
>              Linus

I keep looking at your patch and wondering if there isn't a way
to remove the uid refcount entirely on this path.

Linus I might be wrong but I have this sense that your change will only
help when signal delivery is backed up.  I expect in the common case
there won't be any pending signals outstanding for the user.

Not that I see anything bad jumping out at me from your patch.

Eric



>  kernel/signal.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9ad8dea93dbb..5b2396350dd1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -413,27 +413,32 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
>  {
>  	struct sigqueue *q = NULL;
>  	struct user_struct *user;
> +	int sigpending;
>  
>  	/*
>  	 * Protect access to @t credentials. This can go away when all
>  	 * callers hold rcu read lock.
> +	 *
> +	 * NOTE! A pending signal will hold on to the user refcount,
> +	 * and we get/put the refcount only when the sigpending count
> +	 * changes from/to zero.
>  	 */
>  	rcu_read_lock();
> -	user = get_uid(__task_cred(t)->user);
> -	atomic_inc(&user->sigpending);
> +	user = __task_cred(t)->user;
> +	sigpending = atomic_inc_return(&user->sigpending);
> +	if (sigpending == 1)
> +		get_uid(user);
>  	rcu_read_unlock();
>  
> -	if (override_rlimit ||
> -	    atomic_read(&user->sigpending) <=
> -			task_rlimit(t, RLIMIT_SIGPENDING)) {
> +	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
>  		q = kmem_cache_alloc(sigqueue_cachep, flags);
>  	} else {
>  		print_dropped_signal(sig);
>  	}
>  
>  	if (unlikely(q == NULL)) {
> -		atomic_dec(&user->sigpending);
> -		free_uid(user);
> +		if (atomic_dec_and_test(&user->sigpending))
> +			free_uid(user);
>  	} else {
>  		INIT_LIST_HEAD(&q->list);
>  		q->flags = 0;
> @@ -447,8 +452,8 @@ static void __sigqueue_free(struct sigqueue *q)
>  {
>  	if (q->flags & SIGQUEUE_PREALLOC)
>  		return;
> -	atomic_dec(&q->user->sigpending);
> -	free_uid(q->user);
> +	if (atomic_dec_and_test(&q->user->sigpending))
> +		free_uid(q->user);
>  	kmem_cache_free(sigqueue_cachep, q);
>  }
>  
