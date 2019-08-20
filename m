Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7EE95F63
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfHTNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:03:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:03:12 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i03n3-0005fQ-Ld; Tue, 20 Aug 2019 15:03:09 +0200
Date:   Tue, 20 Aug 2019 15:03:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 01/44] posix-timers: Cleanup forward declarations and
 includes
In-Reply-To: <20190820122049.GB2093@lenoir>
Message-ID: <alpine.DEB.2.21.1908201502360.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143801.472005793@linutronix.de> <20190820122049.GB2093@lenoir>
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

On Tue, 20 Aug 2019, Frederic Weisbecker wrote:

> On Mon, Aug 19, 2019 at 04:31:42PM +0200, Thomas Gleixner wrote:
> >  - Rename struct siginfo to kernel_siginfo
> 
> That's fine because struct siginfo isn't actually used in that
> header, right?

Yes, just kernel_siginfo needs a forward declaration.

