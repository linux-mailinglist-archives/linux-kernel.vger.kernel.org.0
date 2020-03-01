Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB45174A4C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 00:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgB2Xzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 18:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbgB2Xzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:55:52 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDE220828;
        Sat, 29 Feb 2020 23:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583020551;
        bh=57pjLIdDLUk9S2PfQjRdf7cFBHHnPkLkabDFV/izoe8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fIQvYaKc6HbXXdSjKhx+utVy/QwfSmTVY+IBNC8HC0tyf0/Yqat7CNmumrnFKHMrh
         rgV0RggE6JEVHmjfV8oXJlVW7jt3Z2q2k6XWgwJFMTX6PKzLi9zuxDFI9Au7rhvTh2
         pbAca+ovCtDnHaRAQuSCjfdz8WSCiDdO5jCnAtc0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 550253522719; Sat, 29 Feb 2020 15:55:51 -0800 (PST)
Date:   Sat, 29 Feb 2020 15:55:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] ipc: use a work queue to free_ipc
Message-ID: <20200229235551.GP2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200225145419.527994-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225145419.527994-1-gscrivan@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:54:19PM +0100, Giuseppe Scrivano wrote:
> the reason is to avoid a delay caused by the synchronize_rcu() call in
> kern_umount() when the mqueue mount is freed.
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
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> v3:
> - added comment for free_ipc_work
> - commit message rephrased
> 
> v2: https://lkml.org/lkml/2020/2/17/839
> - comment added in free_ipc_ns()
> 
> v1: https://lkml.org/lkml/2020/2/11/692
> 
>  include/linux/ipc_namespace.h |  2 ++
>  ipc/namespace.c               | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
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
> index b3ca1476ca51..c0470aef41a0 100644
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
> @@ -127,6 +131,21 @@ static void free_ipc_ns(struct ipc_namespace *ns)
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
> +
> +/*
> + * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
> + */
> +static DECLARE_WORK(free_ipc_work, free_ipc);
> +
>  /*
>   * put_ipc_ns - drop a reference to an ipc namespace.
>   * @ns: the namespace to put
> @@ -148,8 +167,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
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
>  
> -- 
> 2.24.1
> 
