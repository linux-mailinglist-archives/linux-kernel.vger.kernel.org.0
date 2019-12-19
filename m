Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3991012665B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLSQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfLSQFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:05:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C330324650;
        Thu, 19 Dec 2019 16:05:19 +0000 (UTC)
Date:   Thu, 19 Dec 2019 11:05:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219110517.0dbdb211@gandalf.local.home>
In-Reply-To: <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
        <20191219131242.GK2827@hirez.programming.kicks-ass.net>
        <20191219140252.GS2871@hirez.programming.kicks-ass.net>
        <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
        <20191219094330.0e44c748@gandalf.local.home>
        <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
        <20191219095941.2eebed84@gandalf.local.home>
        <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 18:20:58 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..ff12a422ff19 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -108,6 +108,13 @@
>  #define SBSS_MAIN .sbss
>  #endif

I would also add a comment here:

/*
 * The order of the sched class addresses are important, as they are
 * used to determine the order of the priority of each sched class in
 * relation to each other.
 */

>  
> +#define SCHED_DATA				\
> +	*(__idle_sched_class)			\
> +	*(__fair_sched_class)			\
> +	*(__rt_sched_class)			\
> +	*(__dl_sched_class)			\
> +	*(__stop_sched_class)
> +
>  /*
>   * Align to a 32 byte boundary equal to the
>   * alignment gcc 4.5 uses for a struct
> @@ -308,6 +315,7 @@
>  #define DATA_DATA							\
>  	*(.xiptext)							\
>  	*(DATA_MAIN)							\
> +	SCHED_DATA							\
>  	*(.ref.data)							\
>  	*(.data..shared_aligned) /* percpu related */			\
>  	MEM_KEEP(init.data*)						\
