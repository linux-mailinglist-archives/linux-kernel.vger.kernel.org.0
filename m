Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2B193F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 13:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgCZM4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 08:56:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49528 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgCZM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:56:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jHS3q-0004mY-VW; Thu, 26 Mar 2020 06:56:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jHS3q-0002Ox-5s; Thu, 26 Mar 2020 06:56:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
        <20200324200932.GB24230@redhat.com>
Date:   Thu, 26 Mar 2020 07:54:04 -0500
In-Reply-To: <20200324200932.GB24230@redhat.com> (Oleg Nesterov's message of
        "Tue, 24 Mar 2020 21:09:32 +0100")
Message-ID: <87v9mr1dlf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jHS3q-0002Ox-5s;;;mid=<87v9mr1dlf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FQNW6El1vkn/O9+aq6uzvW1DZho99q7U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4958]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 334 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (4.3%), b_tie_ro: 13 (3.8%), parse: 1.16
        (0.3%), extract_message_metadata: 4.8 (1.4%), get_uri_detail_list: 2.4
        (0.7%), tests_pri_-1000: 3.7 (1.1%), tests_pri_-950: 1.44 (0.4%),
        tests_pri_-900: 1.22 (0.4%), tests_pri_-90: 70 (20.9%), check_bayes:
        68 (20.4%), b_tokenize: 12 (3.6%), b_tok_get_all: 9 (2.7%),
        b_comp_prob: 2.4 (0.7%), b_tok_touch_all: 40 (11.9%), b_finish: 1.28
        (0.4%), tests_pri_0: 218 (65.5%), check_dkim_signature: 0.84 (0.3%),
        check_dkim_adsp: 2.9 (0.9%), poll_dns_idle: 1.23 (0.4%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V2] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
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
>
> This needs the additional notify.sigev_signo != 0 check, shouldn't we
> change do_mq_notify() to deny sigev_signo == 0 ?
>
> Test-case:
>
> 	#include <signal.h>
> 	#include <mqueue.h>
> 	#include <unistd.h>
> 	#include <sys/wait.h>
> 	#include <assert.h>
>
> 	static int notified;
>
> 	static void sigh(int sig)
> 	{
> 		notified = 1;
> 	}
>
> 	int main(void)
> 	{
> 		signal(SIGIO, sigh);
>
> 		int fd = mq_open("/mq", O_RDWR|O_CREAT, 0666, NULL);
> 		assert(fd >= 0);
>
> 		struct sigevent se = {
> 			.sigev_notify	= SIGEV_SIGNAL,
> 			.sigev_signo	= SIGIO,
> 		};
> 		assert(mq_notify(fd, &se) == 0);
>
> 		if (!fork()) {
> 			assert(setuid(1) == 0);
> 			mq_send(fd, "",1,0);
> 			return 0;
> 		}
>
> 		wait(NULL);
> 		mq_unlink("/mq");
> 		assert(notified);
> 		return 0;
> 	}
>
> Reported-by: Yoji <yoji.fujihar.min@gmail.com>
> Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  ipc/mqueue.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 49a05ba3000d..63b164932ffd 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -774,28 +774,40 @@ static void __do_notify(struct mqueue_inode_info *info)
>  	 * synchronously. */
>  	if (info->notify_owner &&
>  	    info->attr.mq_curmsgs == 1) {
> -		struct kernel_siginfo sig_i;
>  		switch (info->notify.sigev_notify) {
>  		case SIGEV_NONE:
>  			break;
> -		case SIGEV_SIGNAL:
> -			/* sends signal */
> +		case SIGEV_SIGNAL: {
> +			struct kernel_siginfo sig_i;
> +			struct task_struct *task;
> +
> +			/* do_mq_notify() accepts sigev_signo == 0, why?? */
> +			if (!info->notify.sigev_signo)
> +				break;
>  
>  			clear_siginfo(&sig_i);
>  			sig_i.si_signo = info->notify.sigev_signo;
>  			sig_i.si_errno = 0;
>  			sig_i.si_code = SI_MESGQ;
>  			sig_i.si_value = info->notify.sigev_value;
> -			/* map current pid/uid into info->owner's namespaces */
>  			rcu_read_lock();
> +			/* map current pid/uid into info->owner's namespaces */
>  			sig_i.si_pid = task_tgid_nr_ns(current,
>  						ns_of_pid(info->notify_owner));
> -			sig_i.si_uid = from_kuid_munged(info->notify_user_ns, current_uid());
> +			sig_i.si_uid = from_kuid_munged(info->notify_user_ns,
> +						current_uid());
> +			/*
> +			 * We can't use kill_pid_info(), this signal should
> +			 * bypass check_kill_permission(). It is from kernel
> +			 * but si_fromuser() can't know this.
> +			 */
> +			task = pid_task(info->notify_owner, PIDTYPE_PID);
                                                            ^^^^^^^^^^^^
Minor nit:  If we are doing the task lookup ourselves that can and
            should be PIDTYPE_TGID.  Because the code captures the TGID
            itself none of the very valid backwards compatibility
            reasons for using PIDTYPE_PID come into play.

> +			if (task)
> +				do_send_sig_info(info->notify.sigev_signo,
> +						&sig_i, task, PIDTYPE_TGID);
>  			rcu_read_unlock();
> -
> -			kill_pid_info(info->notify.sigev_signo,
> -				      &sig_i, info->notify_owner);
>  			break;
> +		}
>  		case SIGEV_THREAD:
>  			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
>  			netlink_sendskb(info->notify_sock, info->notify_cookie);
Eric
