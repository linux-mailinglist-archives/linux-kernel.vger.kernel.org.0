Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF74708C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfGVSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:37:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37886 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbfGVSh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:37:26 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdBY-0001gp-2Q; Mon, 22 Jul 2019 20:37:20 +0200
Date:   Mon, 22 Jul 2019 20:37:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
In-Reply-To: <20190722182159.GB6698@worktop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de>
References: <20190719005837.4150-1-namit@vmware.com> <20190719005837.4150-2-namit@vmware.com> <20190722182159.GB6698@worktop.programming.kicks-ass.net>
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

On Mon, 22 Jul 2019, Peter Zijlstra wrote:

> On Thu, Jul 18, 2019 at 05:58:29PM -0700, Nadav Amit wrote:
> > +/*
> > + * Call a function on all processors.  May be used during early boot while
> > + * early_boot_irqs_disabled is set.
> > + */
> > +static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
> > +{
> > +	on_each_cpu_mask(cpu_online_mask, func, info, wait);
> > +}
> 
> I'm thinking that one if buggy, nothing protects online mask here.

The current implementation has preemption disabled before touching
cpu_online_mask which at least protects against a CPU going away as that
prevents the stomp machine thread from getting on the CPU. But it's not
protected against a CPU coming online concurrently.

Thanks,

	tglx

