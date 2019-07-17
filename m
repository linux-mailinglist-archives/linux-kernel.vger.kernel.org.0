Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF76B9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGQKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 06:05:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52834 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfGQKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:05:00 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hngnw-0002Pa-HU; Wed, 17 Jul 2019 12:04:56 +0200
Date:   Wed, 17 Jul 2019 12:04:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arm64: Avoid pointless schedule_preempt_irq()
 invocations
In-Reply-To: <e47e8298-af21-64fa-eac3-6fdfbf11c502@arm.com>
Message-ID: <alpine.DEB.2.21.1907171203280.1767@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907171036490.1767@nanos.tec.linutronix.de> <e47e8298-af21-64fa-eac3-6fdfbf11c502@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019, Valentin Schneider wrote:

> On 17/07/2019 09:43, Thomas Gleixner wrote:
> > When preempt_count is zero on return from interrupt then
> > schedule_preempt_irq() is invoked even if TIF_NEED_RESCHED is not set.
> > 
> > That does not make sense because schedule_preempt_irq() has to go through a
> > full __schedule() for nothing in that case.
> > 
> > Check TIF_NEED_RESCHED and invoke schedule_preempt_irq() only if set.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Don't we have NEED_RESCHED squashed into preempt count?
> 
>   396244692232 ("arm64: preempt: Provide our own implementation of asm/preempt.h")
> 
> So the existing check should cover that, unless I'm missing something?

Right. Ignore me.
