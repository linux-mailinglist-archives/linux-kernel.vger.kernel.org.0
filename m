Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540339E9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfH0NqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:46:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43756 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH0NqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:04 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2bnN-0006j0-IS; Tue, 27 Aug 2019 15:46:01 +0200
Date:   Tue, 27 Aug 2019 15:46:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 38/38] posix-cpu-timers: Utilize timerqueue for
 storage
In-Reply-To: <20190827131727.GA25843@lenoir>
Message-ID: <alpine.DEB.2.21.1908271545070.1939@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192922.835676817@linutronix.de> <20190827004846.GM14309@lenoir> <alpine.DEB.2.21.1908270807080.1939@nanos.tec.linutronix.de> <20190827131727.GA25843@lenoir>
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

On Tue, 27 Aug 2019, Frederic Weisbecker wrote:
> On Tue, Aug 27, 2019 at 08:08:06AM +0200, Thomas Gleixner wrote:
> > On Tue, 27 Aug 2019, Frederic Weisbecker wrote:
> > 
> > > On Wed, Aug 21, 2019 at 09:09:25PM +0200, Thomas Gleixner wrote:
> > > >  /**
> > > > @@ -92,14 +130,10 @@ struct posix_cputimers {
> > > >  
> > > >  static inline void posix_cputimers_init(struct posix_cputimers *pct)
> > > >  {
> > > > -	pct->timers_active = 0;
> > > > -	pct->expiry_active = 0;
> > > 
> > > No more need to initialize these?
> > > 
> > > > +	memset(pct->bases, 0, sizeof(pct->bases));
> > 
> > memset() does that IIRC :)
> 
> But those two fields aren't part of pct->bases, are they? :)

Duh. I wanted to memset() the full pile obviously.

