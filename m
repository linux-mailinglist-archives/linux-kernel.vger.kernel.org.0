Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3776799832
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfHVPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfHVPcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:32:16 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD57E233FD;
        Thu, 22 Aug 2019 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566487935;
        bh=FenMIIN8efZlIv+jG/NK+H9OQ3jMfcpw2WdlasXBso8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzCth3OmTPsgRWEWytdDhBm8Bxm0ELUBxEptklX/I8s7/IL0usG4Qp9KTphMPFOrX
         3TpQMdV+GB5K4diQ/gvIVC/Bxg8VZx46hkXPAGZN3mf3kqhLy+HkYxgJr6Td7FudB9
         X8b+IBU8Ufl4y22aEIiZ8is5Rd4fjEt4/mrw4BVg=
Date:   Thu, 22 Aug 2019 17:32:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 17/38] posix-cpu-timers: Create a container struct
Message-ID: <20190822153212.GU22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192920.819418976@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192920.819418976@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:04PM +0200, Thomas Gleixner wrote:
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -62,6 +62,40 @@ static inline int clockid_to_fd(const cl
>  	return ~(clk >> 3);
>  }

Shouldn't you start the #ifdef CONFIG_POSIX_TIMERS here?
Because you're redefining struct posix_cputimers otherwise.

> +/**
> + * posix_cputimers - Container for posix CPU timer related data
> + * @cpu_timers:		List heads to queue posix CPU timers
> + *
> + * Used in task_struct and signal_struct
> + */
> +struct posix_cputimers {
> +	struct list_head	cpu_timers[CPUCLOCK_MAX];
> +};
> +
> +static inline void posix_cputimers_init(struct posix_cputimers *pct)
> +{
> +	INIT_LIST_HEAD(&pct->cpu_timers[0]);
> +	INIT_LIST_HEAD(&pct->cpu_timers[1]);
> +	INIT_LIST_HEAD(&pct->cpu_timers[2]);
> +}
> +
> +#ifdef CONFIG_POSIX_TIMERS
> +/* Init task static initializer */
> +#define INIT_CPU_TIMERLISTS(c)	{					\
> +	LIST_HEAD_INIT(c.cpu_timers[0]),				\
> +	LIST_HEAD_INIT(c.cpu_timers[1]),				\
> +	LIST_HEAD_INIT(c.cpu_timers[2]),				\
> +}
> +
> +#define INIT_CPU_TIMERS(s)						\
> +	.posix_cputimers = {						\
> +		.cpu_timers = INIT_CPU_TIMERLISTS(s.posix_cputimers),	\
> +	},
> +#else
> +struct posix_cputimers { };
> +#define INIT_CPU_TIMERS(s)
> +#endif
> +

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
