Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C678138E10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:44:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:44:09 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iqwG8-0003DP-1q; Mon, 13 Jan 2020 09:43:44 +0000
Date:   Mon, 13 Jan 2020 10:43:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        oleg@redhat.com, elena.reshetova@intel.com, jgg@ziepe.ca,
        christian@kellner.me, aarcange@redhat.com, viro@zeniv.linux.org.uk,
        cyphar@cyphar.com, ldv@altlinux.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] kernel/fork: put some fork variables into read-mostly
 section
Message-ID: <20200113094342.5ghlgttmhuxfqv2v@wittgenstein>
References: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:23:13AM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Since total_forks/nr_threads/max_threads global variables are
> frequently used for process fork, putting these variables into
> read_mostly section can avoid unnecessary cache line bouncing.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  kernel/fork.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0808095..163e152 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -120,10 +120,10 @@
>  /*
>   * Protected counters by write_lock_irq(&tasklist_lock)
>   */
> -unsigned long total_forks;	/* Handle normal Linux uptimes. */
> -int nr_threads;			/* The idle threads do not count.. */
> +unsigned long total_forks __read_mostly; /* Handle normal Linux uptimes. */
> +int nr_threads __read_mostly;  /* The idle threads do not count.. */

total_forks is incremented at every ~CLONE_THREAD and nr_threads at
CLONE_THREAD I wouldn't exactly say that this qualifies as mostly
reading.

>  
> -static int max_threads;		/* tunable limit on nr_threads */
> +static int max_threads __read_mostly; /* tunable limit on nr_threads */

That make sense.

Christian
