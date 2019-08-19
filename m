Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6049D94F01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfHSU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 16:29:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49375 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfHSU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:29:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzoHq-00042s-Nw; Mon, 19 Aug 2019 22:29:54 +0200
Date:   Mon, 19 Aug 2019 22:29:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 42/44] posix-cpu-timers: Move state tracking to struct
 posix_cputimers
In-Reply-To: <20190819191327.GC68079@gmail.com>
Message-ID: <alpine.DEB.2.21.1908192229380.4008@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143805.419809496@linutronix.de> <20190819191327.GC68079@gmail.com>
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

On Mon, 19 Aug 2019, Ingo Molnar wrote:

> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Put it where it belongs and cleanup the ifdeffery in fork completely.
> 
> s/cleanup
>  /clean up
> 
> >   * posix_cputimers - Container for posix CPU timer related data
> >   * @expiries:		Earliest-expiration cache array based
> > + * @timers_active:	Timers are queued.
> > + * @expiry_active:	Timer expiry is active. Used for
> > + *			process wide timers to avoid multiple
> > + *			trying to handle expiry
> 
> 'to avoid multiple trying to handle expiry'?
> 
> Should this be: 'to avoid multiple tasks trying to handle expiry'?

Yup.

