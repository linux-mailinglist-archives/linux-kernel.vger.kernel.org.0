Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD0318E95D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCVOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 10:19:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33144 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCVOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:19:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jG1Rz-00049b-UJ; Sun, 22 Mar 2020 08:19:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jG1Ry-0007dq-Qh; Sun, 22 Mar 2020 08:19:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
Date:   Sun, 22 Mar 2020 09:17:09 -0500
In-Reply-To: <20200322110901.GA25108@redhat.com> (Oleg Nesterov's message of
        "Sun, 22 Mar 2020 12:09:01 +0100")
Message-ID: <87lfnsh3tm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jG1Ry-0007dq-Qh;;;mid=<87lfnsh3tm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19D7N4FQckUDhpdn9b+Q+LIEGx2niM643k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 636 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 10 (1.5%), parse: 1.14
        (0.2%), extract_message_metadata: 6 (0.9%), get_uri_detail_list: 3.3
        (0.5%), tests_pri_-1000: 3.8 (0.6%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 99 (15.6%), check_bayes:
        97 (15.2%), b_tokenize: 11 (1.7%), b_tok_get_all: 9 (1.4%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 70 (11.0%), b_finish: 1.17
        (0.2%), tests_pri_0: 495 (77.7%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
> changed the value of SI_FROMUSER(SI_MESGQ), this means that mq_notify()
> no longer works if the sender doesn't have rights to send a signal.
>
> Change __do_notify() to use do_send_sig_info() instead of kill_pid_info()
> to avoid check_kill_permission().

I totally see why you are doing this.  To avoid the permission check,
and since this process requested the signal it makes sense to bypass the
permission checks.  The code needs to make certain that this signal is
canceled or otherwise won't be sent after an exec.

That said I don't like it.  I would really like to remove the signal
sending interfaces that take a task_struct.

Looking at the code I currently see several places where we have this
kind of semantic (sending a requested signal to a process from the
context of another process): do_notify_parent, pdeath_signal, f_setown,
and mq_notify.

When 4 different pieces of code are doing effectively the same thing and
have very similar if not the exact same concerns and they are all doing
things differently then we have a maintenance problem.

Especially with the concerns about being able to send a signal after
exec, and cause havoc.

Oleg is there any chance you can see if you can find a common helper
or a common idiom that all three cases can and should use?  Espeically
with concerns about being able to send signals to a suid process that
would normally fail I think there is an issue here.

At the very least can you add a big fat comment about the semantics
that userspace expects in this case?

> This needs the additional notify.sigev_signo != 0 check, shouldn't we
> change do_mq_notify() to deny sigev_signo == 0 ?

I wonder if the author of the code simply did not realize that
valid_signal allows 0.  As this is a posix interface we should be able
to check the posix spec and see if it gives any useful guidance about
signal 0.

Eric



> Reported-by: Yoji <yoji.fujihar.min@gmail.com>
> Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  ipc/mqueue.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 49a05ba3000d..3145fae162c1 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -775,12 +775,15 @@ static void __do_notify(struct mqueue_inode_info *info)
>  	if (info->notify_owner &&
>  	    info->attr.mq_curmsgs == 1) {
>  		struct kernel_siginfo sig_i;
> +		struct task_struct *task;
>  		switch (info->notify.sigev_notify) {
>  		case SIGEV_NONE:
>  			break;
>  		case SIGEV_SIGNAL:
> +			/* do_mq_notify() accepts sigev_signo == 0, why?? */
> +			if (!info->notify.sigev_signo)
> +				break;
>  			/* sends signal */
> -
>  			clear_siginfo(&sig_i);
>  			sig_i.si_signo = info->notify.sigev_signo;
>  			sig_i.si_errno = 0;
> @@ -790,11 +793,13 @@ static void __do_notify(struct mqueue_inode_info *info)
>  			rcu_read_lock();
>  			sig_i.si_pid = task_tgid_nr_ns(current,
>  						ns_of_pid(info->notify_owner));
> -			sig_i.si_uid = from_kuid_munged(info->notify_user_ns, current_uid());
> +			sig_i.si_uid = from_kuid_munged(info->notify_user_ns,
> +						current_uid());
> +			task = pid_task(info->notify_owner, PIDTYPE_PID);
> +			if (task)
> +				do_send_sig_info(info->notify.sigev_signo,
> +						&sig_i, task, PIDTYPE_TGID);
>  			rcu_read_unlock();
> -
> -			kill_pid_info(info->notify.sigev_signo,
> -				      &sig_i, info->notify_owner);
>  			break;
>  		case SIGEV_THREAD:
>  			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
