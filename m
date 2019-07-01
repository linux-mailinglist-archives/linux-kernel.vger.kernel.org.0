Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC559922
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 13:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfF1LVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 07:21:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF1LVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:21:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgowr-00021l-Ax; Fri, 28 Jun 2019 13:21:45 +0200
Message-Id: <20190628111148.828731433@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 13:11:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch V2 0/6] x86/irq: Cure various interrupt issues
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses a few long standing issues:

  1) The spurious interrupt warning which is emitted occasionally for
     no obvious reason. Partially harmless but annoying

  2) The spurious system vector detection which got wreckaged quite some
     time ago and can completely wedge a machine. Posted yesterday already
     in a preliminary version. Now actually verified that it does what it
     claims to do.

Details in the various patches.

For your conveniance the series is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.irq

Changes vs. V1: Use the existing irq_get_irqchip_state() callback
	    	Fixup misleading comments
		Use the sync scheme in synchronize_irq() as well.

Thanks,

        tglx

8<--------------
 arch/x86/entry/entry_32.S      |   24 ++++++++++
 arch/x86/entry/entry_64.S      |   30 +++++++++++--
 arch/x86/include/asm/hw_irq.h  |    5 +-
 arch/x86/kernel/apic/apic.c    |   33 ++++++++++-----
 arch/x86/kernel/apic/io_apic.c |   46 ++++++++++++++++++++
 arch/x86/kernel/apic/vector.c  |    4 -
 arch/x86/kernel/idt.c          |    3 -
 arch/x86/kernel/irq.c          |    2 
 kernel/irq/autoprobe.c         |    6 +-
 kernel/irq/chip.c              |    6 ++
 kernel/irq/cpuhotplug.c        |    2 
 kernel/irq/internals.h         |    5 ++
 kernel/irq/manage.c            |   90 +++++++++++++++++++++++++++++++----------
 13 files changed, 211 insertions(+), 45 deletions(-)




    

