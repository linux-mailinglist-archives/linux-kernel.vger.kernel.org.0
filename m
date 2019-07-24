Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C982972CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGXLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:02:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfGXLCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:02:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqF2G-00053o-Rh; Wed, 24 Jul 2019 13:02:16 +0200
Date:   Wed, 24 Jul 2019 13:02:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
In-Reply-To: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de>
References: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
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

Rui,

On Wed, 24 Jul 2019, Rui Salvaterra wrote:
> I don't know if this has been reported before, but from a cursory
> search it doesn't seem to be the case.
> I have a x86-64 Pentium (4) D machine which always worked perfectly
> with Linux 5.2 using the TSC as the clock source. With Linux 5.3-rc1 I
> can't, for the life of me, boot it with anything other than
> clocksource=jiffies, it completely hangs without even a backtrace.

The obvious candidate for this is the following section:

c8c4076723da ("x86/timer: Skip PIT initialization on modern chipsets")
dde3626f815e ("x86/apic: Use non-atomic operations when possible")
748b170ca19a ("x86/apic: Make apic_bsp_setup() static")
2420a0b1798d ("x86/tsc: Set LAPIC timer period to crystal clock frequency")
52ae346bd26c ("x86/apic: Rename 'lapic_timer_frequency' to 'lapic_timer_period'")
604dc9170f24 ("x86/tsc: Use CPUID.0x16 to calculate missing crystal frequency")

Thanks,

	tglx
