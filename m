Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512B1F51B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKHQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:58:12 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:34028 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfKHQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aL-0002sR-LW; Fri, 08 Nov 2019 17:58:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 00/11] irqchip/gic-v3-its: Cleanup and fixes for Linux 5.5
Date:   Fri,  8 Nov 2019 16:57:54 +0000
Message-Id: <20191108165805.3071-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a mix of early GICv4.1 cleanups, fixes coming out of
discussions with Zenghui Yu, and a couple of stashed bug fixes that I
recently rediscovered (oops).

Hopefully nothing controvertial here, but please shout if you think
anything looks wrong. I've given it a good shake on my D05, and
everything was fine.

As $SUBJECT says, I plan to take this into 5.5.

Thanks,

	M.

* From v1:
  - Moved the collection map freeing from the irqdomain dtor
    into the device teardown function (noticed by Zenghui)

Marc Zyngier (11):
  irqchip/gic-v3-its: Free collection mapping on device teardown
  irqchip/gic-v3-its: Factor out wait_for_syncr primitive
  irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
  irqchip/gic-v3-its: Make is_v4 use a TYPER copy
  irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
  irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
  irqchip/gic-v3-its: Add its_vlpi_map helpers
  irqchip/gic-v3-its: Synchronise INV command targetting a VLPI using
    VSYNC
  irqchip/gic-v3-its: Synchronise INT/CLEAR commands targetting a VLPI
    using VSYNC
  irqchip/irq-gic-v3-its: Lock VLPI map array before translating it
  irqchip/gic-v3-its: Make vlpi_lock a spinlock

 drivers/irqchip/irq-gic-v3-its.c   | 289 ++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |   4 +-
 2 files changed, 224 insertions(+), 69 deletions(-)

-- 
2.20.1

