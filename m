Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C8AA580
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfIEOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:11:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfIEOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:11:15 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5sTf-0002A9-IN; Thu, 05 Sep 2019 16:11:11 +0200
Date:   Thu, 5 Sep 2019 16:11:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 5/6] posix-cpu-timers: Sanitize thread clock
 permissions
In-Reply-To: <20190905122108.GO2349@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909051610200.1902@nanos.tec.linutronix.de>
References: <20190905120339.561100423@linutronix.de> <20190905120540.068959005@linutronix.de> <20190905122108.GO2349@hirez.programming.kicks-ass.net>
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

On Thu, 5 Sep 2019, Peter Zijlstra wrote:

> On Thu, Sep 05, 2019 at 02:03:44PM +0200, Thomas Gleixner wrote:
> > The thread clock permissions are restricted to tasks of the same thread
> > group, but that also prevents a ptracer from reading them. This is
> > inconsistent vs. the process restrictions and unnecessary strict.
> > 
> > Relax it to ptrace permissions in the same way as process permissions are
> > handled.
> 
> More of a meta comment on the added permission checking; so where
> clock_getcpuclockid() is allowed to return -EPERM, it doesn't because
> that's in glibc and it has no clue.
> 
> And these patches implement the ptrace checks and result in -EINVAL for
> timer_create() and clock_gettime(), even though it should arguably be
> -EPERM, but we're not allowed to return that here.

Yeah. Maybe we should nevertheless.

Thanks,

	tglx
