Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16C99EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfHVS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 14:29:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389402AbfHVS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:29:59 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0rqF-0003JQ-BM; Thu, 22 Aug 2019 20:29:47 +0200
Date:   Thu, 22 Aug 2019 20:29:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH V2] perf/x86: Consider pinned events for group
 validation
In-Reply-To: <20190822182227.GD5447@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1908222029210.1983@nanos.tec.linutronix.de>
References: <1566488866-5975-1-git-send-email-kan.liang@linux.intel.com> <20190822182227.GD5447@tassilo.jf.intel.com>
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

On Thu, 22 Aug 2019, Andi Kleen wrote:

> > +	/*
> > +	 * Disable interrupts to prevent the events in this CPU's cpuc
> > +	 * going away and getting freed.
> > +	 */
> > +	local_irq_save(flags);
> 
> I believe it's also needed to disable preemption. Probably should
> add a comment, or better an explicit preempt_disable() too.

Preemption is implicit disabled by disabling interrupts.

Thanks,

	tglx
