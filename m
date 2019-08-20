Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8405195F81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfHTNIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:08:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfHTNIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:08:38 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i03sJ-0005st-Qj; Tue, 20 Aug 2019 15:08:36 +0200
Date:   Tue, 20 Aug 2019 15:08:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 03/44] posix-timer: Use a callback for cancel
 synchronization
In-Reply-To: <20190820022109.GB9594@infradead.org>
Message-ID: <alpine.DEB.2.21.1908201508010.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143801.656864506@linutronix.de> <20190820022109.GB9594@infradead.org>
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

On Mon, 19 Aug 2019, Christoph Hellwig wrote:

> > +	if (!WARN_ON_ONCE(kc->timer_wait_running))
> > +		kc->timer_wait_running(timer);
> 
> This looks weird. The only place calling yor new method only does so
> after checking that it is not set and actually warns if it set?

Yeah, that wants to be;

	if (!WARN_ON_ONCE(!kc->timer_wait_running))
		kc->timer_wait_running(timer);

