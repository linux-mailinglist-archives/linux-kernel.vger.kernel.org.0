Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2647AF44BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 11:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfKHKiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 05:38:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50762 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:38:13 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iT1ec-0006Q1-18; Fri, 08 Nov 2019 11:38:10 +0100
Date:   Fri, 8 Nov 2019 11:37:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
In-Reply-To: <87o8xm65ar.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911081136450.26566@nanos.tec.linutronix.de>
References: <20191106215534.241796846@linutronix.de> <87zhh78gnf.fsf@oldenburg2.str.redhat.com> <87v9rv8g44.fsf@oldenburg2.str.redhat.com> <87o8xm95rt.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911080912520.27903@nanos.tec.linutronix.de>
 <87o8xm65ar.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Florian Weimer wrote:
> > On Fri, 8 Nov 2019, Florian Weimer wrote:
> > Unpatched 5.4-rc6:
> >
> > FAIL: nptl/tst-thread-affinity-pthread
> > original exit status 1
> > info: Detected CPU set size (in bits): 225
> > info: Maximum test CPU: 255
> > error: pthread_create for thread 253 failed: Resource temporarily unavailable
> 
> Huh.  Reverting your patches (at commit 26bc672134241a080a83b2ab9aa8abede8d30e1c)
> fixes the test for me.
> 
> > TBH, the futex changes have absolutely nothing to do with that resource
> > fail.
> 
> I suspect that there are some changes to task exit latency, which
> triggers the latent resource management bug.

Right, and depending on which hardware you run, this changes. On the big
testbox I use the failure is also bouncing around between thread 252 and
254.

Thanks,

	tglx
