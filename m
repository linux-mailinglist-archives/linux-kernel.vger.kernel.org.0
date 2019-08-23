Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBF9B364
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394270AbfHWPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 11:34:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35979 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbfHWPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:34:35 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1BaD-0005CZ-Hx; Fri, 23 Aug 2019 17:34:33 +0200
Date:   Fri, 23 Aug 2019 17:34:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 17/38] posix-cpu-timers: Create a container struct
In-Reply-To: <20190822153212.GU22020@lenoir>
Message-ID: <alpine.DEB.2.21.1908231734180.1896@nanos.tec.linutronix.de>
References: <20190821190847.665673890@linutronix.de> <20190821192920.819418976@linutronix.de> <20190822153212.GU22020@lenoir>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019, Frederic Weisbecker wrote:

> On Wed, Aug 21, 2019 at 09:09:04PM +0200, Thomas Gleixner wrote:
> > --- a/include/linux/posix-timers.h
> > +++ b/include/linux/posix-timers.h
> > @@ -62,6 +62,40 @@ static inline int clockid_to_fd(const cl
> >  	return ~(clk >> 3);
> >  }
> 
> Shouldn't you start the #ifdef CONFIG_POSIX_TIMERS here?
> Because you're redefining struct posix_cputimers otherwise.

Yeah...

