Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D99B589
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403824AbfHWRdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 13:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389882AbfHWRdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:33:43 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF43D206DD;
        Fri, 23 Aug 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566581622;
        bh=94RX8Vqgfb7MEDIB8FPZqdl8Vii0/A5/FbL6pBjOnH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PshLJnEHQZalu73RYtFPsHig0dozCCKriuCSEuWJRIfkOBE/mCyLmAE+xN5aTcU4Q
         KXIaZeZyAUCW877VntFkydybUeO5XcR309rHSvbr6YZOH76tRvZ6gaHIXY+xL6HTHn
         LQnmnRIB7Vd2HRK3lt/F66cnhcZ3s4vGkfchZYhI=
Date:   Fri, 23 Aug 2019 19:33:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 20/38] posix-cpu-timers: Provide array based access to
 expiry cache
Message-ID: <20190823173338.GA18880@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192921.105793824@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192921.105793824@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:07PM +0200, Thomas Gleixner wrote:
> Using struct task_cputime for the expiry cache is a pretty odd choice and
> comes with magic defines to rename the fields for usage in the expiry
> cache.
> 
> struct task_cputime is basically a u64 array with 3 members, but it has
> distinct members.
> 
> The expiry cache content is different than the content of task_cputime
> because
> 
>   expiry[PROF]  = task_cputime.stime + task_cputime.utime
>   expiry[VIRT]  = task_cputime.utime
>   expiry[SCHED] = task_cputime.sum_exec_runtime
> 
> So there is no direct mapping between task_cputime and the expiry cache and
> the #define based remapping is just a horrible hack.
> 
> Having the expiry cache array based allows further simplification of the
> expiry code.
> 
> To avoid an all in one cleanup which is hard to review add a temporary
> anonymous union into struct task_cputime which allows array based access to
> it. That requires to reorder the members. Add a build time sanity check to
> validate that the members are at the same place.
> 
> The union and the build time checks will be removed after conversion.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
