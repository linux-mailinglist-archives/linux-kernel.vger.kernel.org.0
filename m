Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A8181C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgCKPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:40:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgCKPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2wDqbzy4p+ADOIQGPx6abUEnpO1J3QKNv3y9EsiIDN8=; b=fJxv1glQSnLEFtVQ1j8y4taKtP
        juvNwosAsFEOa6+kHG7CAUec4kiQ1D0EQiMjkdu1ecbHYQw/w9YlgrG2wzla974SEcC5w0a0QpycO
        VmJzQygTBKwjwRNgxd3L/SjKaTftghHStcR3jBmlIFhIh+4ZvH5IsHvdv3Hob/PYXlsoTiHXhQ4eV
        Gqc346Bq8gMhpLkydrWdf5B3e3Ja4uO821t20sfeEfSLLSK1bfZ59pV9nzVEdsiKUy4M9s9EPVY05
        ywRvs/Mx0v6FuGZCV9nUp+GD7iN0bVsymGGZxuwXShQ5uRaCyIluBhE5hMNpKEFlqtooXzcmlCvUi
        exXHcvKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jC3SI-0002RI-27; Wed, 11 Mar 2020 15:39:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFB7F30066E;
        Wed, 11 Mar 2020 16:39:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8997020225666; Wed, 11 Mar 2020 16:39:29 +0100 (CET)
Date:   Wed, 11 Mar 2020 16:39:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: Re: [PATCH v3 1/1] kthread: do not preempt current task if it is
 going to call schedule()
Message-ID: <20200311153929.GQ12561@hirez.programming.kicks-ass.net>
References: <20200306070133.18335-1-cl@rock-chips.com>
 <20200306070133.18335-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306070133.18335-2-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:01:33PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> when we create a kthread with ktrhead_create_on_cpu(),the child thread
> entry is ktread.c:ktrhead() which will be preempted by the parent after
> call complete(done) while schedule() is not called yet,then the parent
> will call wait_task_inactive(child) but the child is still on the runqueue,
> so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
> time,especially on startup.
> 
>   parent                             child
> ktrhead_create_on_cpu()
>   wait_fo_completion(&done) -----> ktread.c:ktrhead()
>                              |----- complete(done);--wakeup and preempted by parent
>  kthread_bind() <------------|  |-> schedule();--dequeue here
>   wait_task_inactive(child)     |
>    schedule_hrtimeout(1 jiffy) -|
> 
> So we hope the child just wakeup parent but not preempted by parent, and the
> child is going to call schedule() soon,then the parent will not call
> schedule_hrtimeout(1 jiffy) as the child is already dequeue.
> 
> The same issue for ktrhead_park()&&kthread_parkme().
> This patch can save 120ms on rk312x startup with CONFIG_HZ=300.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

Thanks!
