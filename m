Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7936B06E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbfGPU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 16:29:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfGPU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:29:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnU5B-0003QB-QZ; Tue, 16 Jul 2019 22:29:54 +0200
Date:   Tue, 16 Jul 2019 22:29:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Clark Williams <williams@redhat.com>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PREEMPT_RT] bogus lockdep assert from i915 on v5.2-rt1
In-Reply-To: <20190716145043.1929f50e@torg>
Message-ID: <alpine.DEB.2.21.1907162228030.1767@nanos.tec.linutronix.de>
References: <20190716145043.1929f50e@torg>
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

Clark,

On Tue, 16 Jul 2019, Clark Williams wrote:

> Thomas,
> 
> When looking at a problem on v5.2-rt1, I turned on lockdep and started getting warnings
> from lockdep_assert_irqs_disabled() in the i915 driver. They're making these calls inside
> a spin_lock_irqsave/spin_lock_irqrestore block, which of course doesn't fiddle with IRQs
> when PREEMPT_RT is configured. The attached patch places the three calls inside
> if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) blocks, so should avoid the bogus warning on RT.

AFAICT, all three asserts are pointless because there are already the lock
held asserts and lockdep will warn anyway when these locks are taken with
interrupts enabled.

Thanks,

	tglx
