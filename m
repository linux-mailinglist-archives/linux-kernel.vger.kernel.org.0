Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DE1512C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 00:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBCXQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 18:16:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60587 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:16:03 -0500
Received: from tmo-110-211.customers.d1-online.com ([80.187.110.211] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iykwZ-0001eB-Qg; Tue, 04 Feb 2020 00:15:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6E26B100720; Mon,  3 Feb 2020 23:15:50 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH V4] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200203192154.GG155875@xz-x1>
References: <20200120091625.17912-1-ming.lei@redhat.com> <87eevrei7h.fsf@nanos.tec.linutronix.de> <20200203192154.GG155875@xz-x1>
Date:   Mon, 03 Feb 2020 23:15:50 +0000
Message-ID: <87a75zz2hl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:
> The new "managed_irq" works for us, thanks for both of your work!
>
> However I just noticed that this new sub-parameter might break users
> if applied incorrectly to old kernels, because iiuc "isolcpus="
> parameter will not apply at all when there's unknown sub-parameters:
>
> static int __init housekeeping_isolcpus_setup(char *str)
> {
> 	unsigned int flags = 0;
>
> 	while (isalpha(*str)) {
>                 ...
>                 pr_warn("isolcpus: Error, unknown flag\n");
>                 return 0;
>         }
>         ...
> }
>
> Then the same kernel parameter will break isolcpus= if the user
> reboots and switches to an older kernel.
>
> A solution to this could be that we introduce an isolated parameter
> for "managed_irq", then on the old kernels only the new parameter will
> be ignored rather than the whole "isolcpus=" parameter, so nothing
> will break.
>
> I'm not sure whether it's already too late for this, or if there's any
> better alternative.  Just raise this question up to see whether we
> still have chance to fix this up.

No, really. The basic guarantee is that your new kernel is going to work
fine with the previous command line, but making a guarantee that new
command line options still work on an old kernel are just creating a
horrible mess. So if that command line interface was not designed to
handle unknown arguments in the first place, you better fix that.

Thanks,

        tglx
