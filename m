Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80095E43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfHTMUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 08:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:53 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54EA22CE3;
        Tue, 20 Aug 2019 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566303652;
        bh=G5xwXtXC6eKSccjeQBgi5kYARnoflqjoRRwzQum4r2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U98zb5kYCZL5UIJpBwBFu63Pis+PAk6FYfIHxPHQ7bMubLguLBKzwRjH9xyn8a7ub
         O99g9etExoI5qQGDYngsmJx6OtZHGEHFkz5Ko/D0r2BoUrU51ZKGt5v56z45rXcEKI
         1HO405m3sW5FZLLB//ihdQMIiP0oA9Pg1Hs7TOfw=
Date:   Tue, 20 Aug 2019 14:20:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 01/44] posix-timers: Cleanup forward declarations and
 includes
Message-ID: <20190820122049.GB2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.472005793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.472005793@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:42PM +0200, Thomas Gleixner wrote:
>  - Rename struct siginfo to kernel_siginfo

That's fine because struct siginfo isn't actually used in that
header, right?

>  - Add a forward declaration for task_struct and remove sched.h include
>  - Remove timex.h include as it is not needed
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/posix-timers.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -4,11 +4,10 @@
>  
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> -#include <linux/sched.h>
> -#include <linux/timex.h>
>  #include <linux/alarmtimer.h>
>  
> -struct siginfo;
> +struct kernel_siginfo;
> +struct task_struct;
>  
>  struct cpu_timer_list {
>  	struct list_head entry;
> 
> 
