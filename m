Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5428C181A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgCKOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 10:00:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgCKOAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:00:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83F2831B;
        Wed, 11 Mar 2020 07:00:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F28E3F67D;
        Wed, 11 Mar 2020 07:00:18 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:00:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Salter <msalter@redhat.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround Cavium erratum 38539 when
 reading GICD_TYPER2
Message-ID: <20200311140016.GF3216816@arrakis.emea.arm.com>
References: <20200311115649.26060-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311115649.26060-1-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:56:49AM +0000, Marc Zyngier wrote:
> Despite the architecture spec requiring that reserved registers in the GIC
> distributor memory map are RES0 (and thus are not allowed to generate
> an exception), the Cavium ThunderX (aka TX1) SoC explodes as such:
> 
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 128 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Internal error: synchronous external abort: 96000210 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc4-00035-g3cf6a3d5725f #7956
> [    0.000000] Hardware name: cavium,thunder-88xx (DT)
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : __raw_readl+0x0/0x8
> [    0.000000] lr : gic_init_bases+0x110/0x560
> [    0.000000] sp : ffff800011243d90
> [    0.000000] x29: ffff800011243d90 x28: 0000000000000000
> [    0.000000] x27: 0000000000000018 x26: 0000000000000002
> [    0.000000] x25: ffff8000116f0000 x24: ffff000fbe6a2c80
> [    0.000000] x23: 0000000000000000 x22: ffff010fdc322b68
> [    0.000000] x21: ffff800010a7a208 x20: 00000000009b0404
> [    0.000000] x19: ffff80001124dad0 x18: 0000000000000010
> [    0.000000] x17: 000000004d8d492b x16: 00000000f67eb9af
> [    0.000000] x15: ffffffffffffffff x14: ffff800011249908
> [    0.000000] x13: ffff800091243ae7 x12: ffff800011243af4
> [    0.000000] x11: ffff80001126e000 x10: ffff800011243a70
> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff80001069c828
> [    0.000000] x7 : 0000000000000059 x6 : ffff8000113fb4d1
> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
> [    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
> [    0.000000] x1 : 0000000000000000 x0 : ffff8000116f000c
> [    0.000000] Call trace:
> [    0.000000]  __raw_readl+0x0/0x8
> [    0.000000]  gic_of_init+0x188/0x224
> [    0.000000]  of_irq_init+0x200/0x3cc
> [    0.000000]  irqchip_init+0x1c/0x40
> [    0.000000]  init_IRQ+0x160/0x1d0
> [    0.000000]  start_kernel+0x2ec/0x4b8
> [    0.000000] Code: a8c47bfd d65f03c0 d538d080 d65f03c0 (b9400000)
> 
> when reading the GICv4.1 GICD_TYPER2 register, which is unexpected...
> 
> Work around it by adding a new quirk for the following variants:
> 
>  ThunderX: CN88xx
>  OCTEON TX: CN83xx, CN81xx
>  OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
> 
> and use this flag to avoid accessing GICD_TYPER2. Note that all
> reserved registers (including redistributors and ITS) are impacted
> by this erratum, but that only GICD_TYPER2 has to be worked around
> so far.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Robert Richter <rrichter@marvell.com>
> ---
> This is a respin of [1], with the erratum number and affected
> platform list provided by Robert.
> 
> [1] https://lore.kernel.org/lkml/20191027144234.8395-11-maz@kernel.org/
> 
>  Documentation/arm64/silicon-errata.rst |  2 ++

For the arm64 documentation:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
