Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188A997516
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHUIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 04:35:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54832 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfHUIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:35:16 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0M59-0007Ah-6x; Wed, 21 Aug 2019 10:35:03 +0200
Date:   Wed, 21 Aug 2019 10:34:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        x86@kernel.org, andriy.shevchenko@intel.com, alan@linux.intel.com,
        rppt@linux.ibm.com, linux-kernel@vger.kernel.org,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
In-Reply-To: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
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

On Wed, 21 Aug 2019, Rahul Tanwar wrote:

> 'ioapic_dynirq_base' contains the virtual IRQ base number. Presently, it is
> updated to the end of hardware IRQ numbers but this is done only when IOAPIC
> configuration type is IOAPIC_DOMAIN_LEGACY or IOAPIC_DOMAIN_STRICT. There is
> a third type IOAPIC_DOMAIN_DYNAMIC which applies when IOAPIC configuration
> comes from devicetree.
> Please see dtb_add_ioapic() in arch/x86/kernel/devicetree.c

We know how DT based ioapics are added. No need to point to it.

> In case of IOAPIC_DOMAIN_DYNAMIC (DT/OF based system), 'ioapic_dynirq_base'
> remains to zero initialized value. This means that for OF based systems,
> virtual IRQ base will get set to zero. Zero value for a virtual IRQ is a
> invalid value.
> Please see https://yarchive.net/comp/linux/zero.html for more details.

First of all, please do not use random archive links. See
Documentation/process/ how links to LKML archives should look like

Secondly, this link is irrelevant. ioapic_dynirq_base has nothing to do
with virtual IRQ number 0. It's a boundary for the dynamic allocation of
virtual interrupt numbers so that the core allocator does not pick
interrupts out of the IOAPIC's fixed interrupt number space.

This can be legitimately 0 when IOAPIC is not enabled at all.

Can you please explain what kind of problem you were seing and what this
really fixes?
 
Thanks,

	tglx
