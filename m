Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043DB77275
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfGZT5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfGZT5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:57:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ACAE218B8;
        Fri, 26 Jul 2019 19:57:49 +0000 (UTC)
Date:   Fri, 26 Jul 2019 15:57:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 01/12] hrtimer: Remove task argument from
 hrtimer_init_sleeper()
Message-ID: <20190726155747.72dbe27d@gandalf.local.home>
In-Reply-To: <20190726185752.791885290@linutronix.de>
References: <20190726183048.982726647@linutronix.de>
        <20190726185752.791885290@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 20:30:49 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1639,10 +1639,10 @@ static enum hrtimer_restart hrtimer_wake
>  	return HRTIMER_NORESTART;
>  }
>  

Not related to the change of this patch, but I'm surprised that a
global function like this doesn't contain any kerneldoc information.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> -void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
> +void hrtimer_init_sleeper(struct hrtimer_sleeper *sl)
>  {
>  	sl->timer.function = hrtimer_wakeup;
> -	sl->task = task;
> +	sl->task = current;
>  }
>  EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
>  
