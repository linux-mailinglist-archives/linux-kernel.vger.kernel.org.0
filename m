Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB93EFB934
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKMTzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 14:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfKMTzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:55:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51006206DA;
        Wed, 13 Nov 2019 19:55:22 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:55:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        akaher@vmware.com, bordoloih@vmware.com, srivatsab@vmware.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Kconfig: Fix spelling mistake in user-visible help text
Message-ID: <20191113145519.161e9597@gandalf.local.home>
In-Reply-To: <157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu>
References: <157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 16:02:07 -0700
"Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:

> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> Fix a spelling mistake in the help text for PREEMPT_RT.

I guess this should go in via the scheduler tree?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> 
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> ---
> 
>  kernel/Kconfig.preempt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index deff972..bf82259 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -65,7 +65,7 @@ config PREEMPT_RT
>  	  preemptible priority-inheritance aware variants, enforcing
>  	  interrupt threading and introducing mechanisms to break up long
>  	  non-preemptible sections. This makes the kernel, except for very
> -	  low level and critical code pathes (entry code, scheduler, low
> +	  low level and critical code paths (entry code, scheduler, low
>  	  level interrupt handling) fully preemptible and brings most
>  	  execution contexts under scheduler control.
>  

