Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4ECF42F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfKHJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 04:18:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:18:16 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iT0PC-000543-33; Fri, 08 Nov 2019 10:18:10 +0100
Date:   Fri, 8 Nov 2019 10:18:08 +0100 (CET)
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
In-Reply-To: <87o8xm95rt.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911080912520.27903@nanos.tec.linutronix.de>
References: <20191106215534.241796846@linutronix.de> <87zhh78gnf.fsf@oldenburg2.str.redhat.com> <87v9rv8g44.fsf@oldenburg2.str.redhat.com> <87o8xm95rt.fsf@oldenburg2.str.redhat.com>
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

On Fri, 8 Nov 2019, Florian Weimer wrote:
> * Florian Weimer:
> > * Florian Weimer:
> >> I ran the glibc upstream test suite (which has some robust futex tests)
> >> against b21be7e942b49168ee15a75cbc49fbfdeb1e6a97 on x86-64, both native
> >> and 32-bit/i386 compat mode.
> >>
> >> compat mode seems broken, nptl/tst-thread-affinity-pthread fails.  This
> >> is probably *not* due to
> >> <https://bugzilla.kernel.org/show_bug.cgi?id=154011> because the failure
> >> is non-sporadic, but reliable fails for thread 253:
> >>
> >> info: Detected CPU set size (in bits): 225
> >> info: Maximum test CPU: 255
> >> error: pthread_create for thread 253 failed: Resource temporarily unavailable
> >>
> >> I'm running this on a large box as root, so ulimits etc. do not apply.
> >>
> >> I did not see this failure with the x86-64 test.
> >>
> >> You should be able to reproduce with (assuming you've got a multilib gcc):
> >>
> >> git clone git://sourceware.org/git/glibc.git git
> >> mkdir build
> >> cd build
> >> ../git/configure --prefix=/usr CC="gcc -m32" CXX="g++ -m32" --build=i686-linux
> >> make -j`nproc`
> >> make test t=nptl/tst-thread-affinity-pthread
> >
> > Sorry, I realized that I didn't actually verify that this is a
> > regression caused by your patches.  Maybe I can do that tomorrow.
> 
> Confirmed as a regression caused by the patches.  Depending on the
> nature of the bug, you need a machine which has or pretends to have many
> CPUs (this one has 256 CPUs).

Sure I can do that, but I completely fail to see how that's a
regression.

Unpatched 5.4-rc6:

FAIL: nptl/tst-thread-affinity-pthread
original exit status 1
info: Detected CPU set size (in bits): 225
info: Maximum test CPU: 255
error: pthread_create for thread 253 failed: Resource temporarily unavailable

TBH, the futex changes have absolutely nothing to do with that resource
fail.

Thanks,

	tglx



