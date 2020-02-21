Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62847168787
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUTj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 14:39:59 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38984 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgBUTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:39:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5E9V-0004rL-Qy; Fri, 21 Feb 2020 12:39:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5E9V-0004U8-19; Fri, 21 Feb 2020 12:39:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk
References: <20200217183627.4099690-1-gscrivan@redhat.com>
Date:   Fri, 21 Feb 2020 13:37:57 -0600
In-Reply-To: <20200217183627.4099690-1-gscrivan@redhat.com> (Giuseppe
        Scrivano's message of "Mon, 17 Feb 2020 19:36:27 +0100")
Message-ID: <87lfov68a2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j5E9V-0004U8-19;;;mid=<87lfov68a2.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hbbZqknfDn39SoIooqGEcoP9YtOWFd30=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4715]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Giuseppe Scrivano <gscrivan@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 377 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.6%), b_tie_ro: 1.71 (0.5%), parse: 0.75
        (0.2%), extract_message_metadata: 10 (2.6%), get_uri_detail_list: 1.98
        (0.5%), tests_pri_-1000: 9 (2.4%), tests_pri_-950: 1.05 (0.3%),
        tests_pri_-900: 0.78 (0.2%), tests_pri_-90: 25 (6.6%), check_bayes: 24
        (6.3%), b_tokenize: 7 (2.0%), b_tok_get_all: 9 (2.4%), b_comp_prob:
        1.98 (0.5%), b_tok_touch_all: 3.9 (1.0%), b_finish: 0.55 (0.1%),
        tests_pri_0: 318 (84.3%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 3.6 (0.9%), poll_dns_idle: 2.2 (0.6%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ipc: use a work queue to free_ipc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> it avoids blocking on synchronize_rcu() in kern_umount().
>
> the code:
>
> \#define _GNU_SOURCE
> \#include <sched.h>
> \#include <error.h>
> \#include <errno.h>
> \#include <stdlib.h>
> int main()
> {
>   int i;
>   for (i  = 0; i < 1000; i++)
>     if (unshare (CLONE_NEWIPC) < 0)
>       error (EXIT_FAILURE, errno, "unshare");
> }
>
> gets from:
>
> 	Command being timed: "./ipc-namespace"
> 	User time (seconds): 0.00
> 	System time (seconds): 0.06
> 	Percent of CPU this job got: 0%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05
>
> to:
>
> 	Command being timed: "./ipc-namespace"
> 	User time (seconds): 0.00
> 	System time (seconds): 0.02
> 	Percent of CPU this job got: 96%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03

I have a question.  You create 1000 namespaces in a single process
and then free them.  So I expect that single process is busy waiting
for that kern_umount 1000 types, and waiting for 1000 synchronize_rcu's.

Does this ever show up in a real world work-load?

Is the cost of a single synchronize_rcu a problem?

The code you are working to avoid is this.

void kern_unmount(struct vfsmount *mnt)
{
	/* release long term mount so mount point can be released */
	if (!IS_ERR_OR_NULL(mnt)) {
		real_mount(mnt)->mnt_ns = NULL;
		synchronize_rcu();	/* yecchhh... */
		mntput(mnt);
	}
}

Which makes me wonder if perhaps there might be a simpler solution
involving just that code.  But I do realize such a solution
would require analyzing all of the code after kern_unmount
to see if any of it depends upon the synchronize_rcu.


In summary, I see no correctness problems with your code.
Code that runs faster is always nice.  In this case I just
see the cost being shifted somewhere else not eliminated.
I also see a slight increase in complexity.

So I am wondering if this was an exercise to speed up a toy
benchmark or if this is an effort to speed of real world code.

At the very least some version of the motivation needs to be
recorded so that the next time some one comes in an reworks
the code they can look in the history and figure out what
they need to do to avoid introducing a regeression.

Eric

> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v2:
> - comment added in free_ipc_ns()
>
> v1: https://lkml.org/lkml/2020/2/11/692
>
>  include/linux/ipc_namespace.h |  2 ++
>  ipc/namespace.c               | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index c309f43bde45..a06a78c67f19 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -68,6 +68,8 @@ struct ipc_namespace {
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
>  
> +	struct llist_node mnt_llist;
> +
>  	struct ns_common ns;
>  } __randomize_layout;
>  
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index b3ca1476ca51..7b9922244891 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -117,6 +117,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>  
>  static void free_ipc_ns(struct ipc_namespace *ns)
>  {
> +	/* mq_put_mnt() waits for a grace period as kern_unmount()
> +	 * uses synchronize_rcu().
> +	 */
> +	mq_put_mnt(ns);
>  	sem_exit_ns(ns);
>  	msg_exit_ns(ns);
>  	shm_exit_ns(ns);
> @@ -127,6 +131,17 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>  	kfree(ns);
>  }
>  
> +static LLIST_HEAD(free_ipc_list);
> +static void free_ipc(struct work_struct *unused)
> +{
> +	struct llist_node *node = llist_del_all(&free_ipc_list);
> +	struct ipc_namespace *n, *t;
> +
> +	llist_for_each_entry_safe(n, t, node, mnt_llist)
> +		free_ipc_ns(n);
> +}
> +static DECLARE_WORK(free_ipc_work, free_ipc);
> +
>  /*
>   * put_ipc_ns - drop a reference to an ipc namespace.
>   * @ns: the namespace to put
> @@ -148,8 +163,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
>  	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
>  		mq_clear_sbinfo(ns);
>  		spin_unlock(&mq_lock);
> -		mq_put_mnt(ns);
> -		free_ipc_ns(ns);
> +
> +		if (llist_add(&ns->mnt_llist, &free_ipc_list))
> +			schedule_work(&free_ipc_work);
>  	}
>  }
