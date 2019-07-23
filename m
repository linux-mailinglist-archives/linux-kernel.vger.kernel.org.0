Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF971667
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfGWKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:44:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfGWKor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E51D337;
        Tue, 23 Jul 2019 03:44:47 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441A73F71A;
        Tue, 23 Jul 2019 03:44:46 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] irqchip/gic-v3: Add support for GICv3.1 extended PPI/SPI ranges
Date:   Tue, 23 Jul 2019 11:44:28 +0100
Message-Id: <20190723104437.154403-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, having ~1000 wired interrupts is not enough, and some
people need more. Fear not! The GIC Achitecture Department hereby
grants you another 1024 SPIs, together with 64 PPIs, provided that you
implement GICv3.1 (see [1] for the details)

This series implements the required support, which requires a bit of
infrastructure rework in order to make the thing less horrible...

This has been tested on a FastModel.

[1] https://developer.arm.com/docs/ihi0069/latest (version E)

Marc Zyngier (9):
  irqchip/gic: Rework gic_configure_irq to take the full ICFGR base
  irqchip/gic-v3: Add INTID range and convertion primitives
  dt-bindings: interrupt-controller: arm,gic-v3: Describe ESPI range
    support
  irqchip/gic-v3: Add ESPI range support
  irqchip/gic: Prepare for more than 16 PPIs
  irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
  irqchip/gic-v3: Dynamically allocate PPI partition descriptors
  dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range
    support
  irqchip/gic-v3: Add EPPI range support

 .../interrupt-controller/arm,gic-v3.yaml      |   6 +-
 drivers/irqchip/irq-gic-common.c              |  33 +-
 drivers/irqchip/irq-gic-common.h              |   2 +-
 drivers/irqchip/irq-gic-v3.c                  | 323 ++++++++++++++----
 drivers/irqchip/irq-gic.c                     |  12 +-
 drivers/irqchip/irq-hip04.c                   |   9 +-
 include/linux/irqchip/arm-gic-v3.h            |  29 +-
 7 files changed, 319 insertions(+), 95 deletions(-)

-- 
2.20.1

