Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09247AADA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404152AbfIEVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:13:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404139AbfIEVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:13:50 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5z4e-00026r-Ki; Thu, 05 Sep 2019 23:13:48 +0200
Date:   Thu, 5 Sep 2019 23:13:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch 0/6] posix-cpu-timers: Fallout fixes and permission
 tightening
In-Reply-To: <201909051329.A630E97F@keescook>
Message-ID: <alpine.DEB.2.21.1909052310590.1902@nanos.tec.linutronix.de>
References: <20190905120339.561100423@linutronix.de> <201909051329.A630E97F@keescook>
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

On Thu, 5 Sep 2019, Kees Cook wrote:
> On Thu, Sep 05, 2019 at 02:03:39PM +0200, Thomas Gleixner wrote:
> > Sysbot triggered an issue in the posix timer rework which was trivial to
> > fix, but after running another test case I discovered that the rework broke
> > the permission checks subtly. That's also a straightforward fix.
> > 
> > Though when staring at it I discovered that the permission checks for
> > process clocks and process timers are completely bonkers. The only
> > requirement is that the target PID is a group leader. Which means that any
> > process can read the clocks and attach timers to any other process without
> > priviledge restrictions.
> > 
> > That's just wrong because the clocks and timers can be used to observe
> > behaviour and both reading the clocks and arming timers adds overhead and
> > influences runtime performance of the target process.
> > 
> > The last 4 patches deal with that and introduce ptrace based permission
> > checks and also make the behaviour consistent between thread and process
> > timers/clocks.
> 
> I like these changes! Thanks for working on it. :)
> 
> Since this is a subtle bit of checking and there are concerns about ABI
> breaks, can you also write some selftests for this area just to nail
> down what should work and what should be blocked, etc?

Sigh, yes. /me adds it to that append only todo list thingy :)

