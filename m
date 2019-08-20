Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4A95F78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfHTNHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:07:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfHTNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:07:39 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i03rN-0005q8-C6; Tue, 20 Aug 2019 15:07:37 +0200
Date:   Tue, 20 Aug 2019 15:07:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 44/44] posix-cpu-timers: Expire timers directly
In-Reply-To: <20190819143805.605704599@linutronix.de>
Message-ID: <alpine.DEB.2.21.1908201507100.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143805.605704599@linutronix.de>
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

On Mon, 19 Aug 2019, Thomas Gleixner wrote:

> Moving the posix cpu timers from on list to another and then expiring them
> from the second list is avoiding to drop and reacquire sighand lock for
> each timer expiry, but on the other hand it's more complicated code and
> suboptimal for a small number of timers.
> 
> Remove the extra list and expire them directly from the rbtree. Tests with
> a large number of timers did not show a difference outside of the noise
> range.
> 
> This also allows to switch the crude heuristics of limiting the expiry of
> timers to 20 for each type to a time based limitation which is way more
> sensible.

This one is buggy. I know why so don't waste your time reviewing it.
