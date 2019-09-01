Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E54A47E2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 08:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfIAGXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 02:23:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55200 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfIAGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 02:23:06 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i4JGR-0007Uc-B9; Sun, 01 Sep 2019 08:23:03 +0200
Date:   Sun, 1 Sep 2019 08:23:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Changbin Du <changbin.du@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] genirq: move debugfs option to kernel hacking
In-Reply-To: <20190901035539.2957-1-changbin.du@gmail.com>
Message-ID: <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
References: <20190901035539.2957-1-changbin.du@gmail.com>
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

On Sun, 1 Sep 2019, Changbin Du wrote:

> Just like the other generic debug options, move the irq one to
> 'Kernel hacking' menu.

Why?

Kernel hacking is a inscrutable mess where you can waste a lot of time to
find what you are looking for.

If I want to debug interrupts then having the option right there where all
other interrupt related configuration is makes tons of sense.

I would be less opposed to this when the kernel hacking menu would be
halfways well structured, but you just chose another random place for that
option which is worse than what we have now.

Thanks,

	tglx



