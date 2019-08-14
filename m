Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C068D6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfHNOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 10:55:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfHNOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:55:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxugc-0007NW-1N; Wed, 14 Aug 2019 16:55:38 +0200
Date:   Wed, 14 Aug 2019 16:55:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 8/9] x86/fpu: correctly check for kthreads
Message-ID: <20190814145537.fx73fwjvshpgdpue@linutronix.de>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-9-mark.rutland@arm.com>
 <20190814130708.b4lu3d6enkga5p4h@linutronix.de>
 <20190814133910.GC51963@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814133910.GC51963@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-14 14:39:10 [+0100], Mark Rutland wrote:
 > I think this was missed in commit.
> > 	8d3289f2fa1e0 ("x86/fpu: Don't use current->mm to check for a kthread")
> 
> Yup, though if it's a bug it's been a bug since commit:
> 
>   0cecca9d03c964ab ("x86/fpu: Eager switch PKRU state")
> 
> ... which I guess the fixes tag would have to mention.
> 
> > 
> > A kthread with use_mm() would load here non-existing FPU state.
> > 
> > Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Given the above, should I add the fixes tag (for 0cecca9d03c964ab)?

Buh. Either that or hch's commit (8d3289f2fa1e0 ("x86/fpu: Don't use
current->mm to check for a kthread").
That will trigger a stable backport (for 5.2) asking what to do about
is_kthread() so please leave a hint to use the PF_ flag like hch did.

Now that I think about it, even if we end up in kthread with use_mm()
then its FPU state is non-existent which means get_xsave_addr() returns
NULL. This is okay / expected but it triggers the WARN_ONCE().

> Thanks,
> Mark.

Sebastian
