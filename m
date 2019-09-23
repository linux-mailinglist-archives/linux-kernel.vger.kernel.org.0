Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C49BB64D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437656AbfIWON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404847AbfIWON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:13:28 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306DF20578;
        Mon, 23 Sep 2019 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569248007;
        bh=kpxPgEg0SUFhUmPgDRXXbOqqrktiGx5C5nmICpq9Cr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=al7D2uFJV6kDW0PM4RbmZTqNkcDYM0cSmAcZ8m5KeEk/bdzTjwbT7IQnEGVAEjukN
         20bxM3VZFkA6JDjphzRiQfERq2Y2pVMdCZ0jNuXE4Ef9IgsDj9dVgFucgMI2MCpGBb
         +cJ+G+3qOLttOylNC03wUoi6FMf4tR5o2YEegfus=
Date:   Mon, 23 Sep 2019 16:13:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 6/6] posix-cpu-timers: Make PID=0 and PID=self handling
 consistent
Message-ID: <20190923141324.GB10778@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120540.162032542@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120540.162032542@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:45PM +0200, Thomas Gleixner wrote:
> If the PID encoded into the clock id is 0 then the target is either the
> calling thread itself or the process to which it belongs.
> 
> If the current thread encodes its own PID on a process wide clock then
> there is no reason not to treat it in the same way as the PID=0 case.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -90,7 +90,14 @@ static struct task_struct *lookup_task(c
>  
>  	} else {
>  		/*
> -		 * For processes require that p is group leader.
> +		 * Timer is going to be attached to a process. If p is
> +		 * current then treat it like the PID=0 case above.
> +		 */
> +		if (p == current)
> +			return current->group_leader;
> +
> +		/*
> +		 * For foreign processes require that p is group leader.
>  		 */
>  		if (!has_group_leader_pid(p))
>  			return NULL;

So, right after you should have that:

                if (same_thread_group(p, current))
                        return p;

Which I suggested to convert as:

                if (p == current)
                        return p;

Either way, you can now remove those lines.

And then:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
