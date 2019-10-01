Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5FC305E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfJAJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 05:39:14 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:38853 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfJAJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:39:14 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFEcX-0001PN-Mo; Tue, 01 Oct 2019 11:39:01 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>,
        Talel Shenhar <talel@amazon.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
Subject: [GIT PULL] irqchip updates for 5.4-rc2
Date:   Tue,  1 Oct 2019 10:38:53 +0100
Message-Id: <20191001093853.17511-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, claudiu.beznea@microchip.com, darius@bluespec.com, palmer@sifive.com, paul.walmsley@sifive.com, sandeepsheriker.mallikarjun@microchip.com, talel@amazon.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small set of fixes I've collected during the merge window. Nothing
major, except for the SiFive PLIC driver which gets promoted to using the
fasteoi flow (and now won't crash when a driver masks an interrupt). The
rest is a handful of platform support and minor fixes.

Please pull,

	M.

The following changes since commit c9c96e30ecaa0aafa225aa1a5392cb7db17c7a82:

  irqchip/gic-v3-its: Fix LPI release for Multi-MSI devices (2019-09-05 16:03:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.4-1

for you to fetch changes up to bb0fed1c60cccbe4063b455a7228818395dac86e:

  irqchip/sifive-plic: Switch to fasteoi flow (2019-09-18 12:29:52 +0100)

----------------------------------------------------------------
irqchip fixes for 5.4, take #1

- Add retrigger support to Amazon's al-fic driver
- Add SAM9X60 support to Atmel's AIC5 irqchip
- Fix GICv3 maximum interrupt calculation
- Convert SiFive's PLIC to the fasteoi IRQ flow

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/sifive-plic: Switch to fasteoi flow

Sandeep Sheriker Mallikarjun (1):
      irqchip/atmel-aic5: Add support for sam9x60 irqchip

Talel Shenhar (1):
      irqchip/al-fic: Add support for irq retrigger

Zenghui Yu (1):
      irqchip/gic-v3: Fix GIC_LINE_NR accessor

 .../bindings/interrupt-controller/atmel,aic.txt    |  7 ++++--
 drivers/irqchip/irq-al-fic.c                       | 12 +++++++++
 drivers/irqchip/irq-atmel-aic5.c                   | 10 ++++++++
 drivers/irqchip/irq-gic-v3.c                       |  2 +-
 drivers/irqchip/irq-sifive-plic.c                  | 29 +++++++++++-----------
 5 files changed, 43 insertions(+), 17 deletions(-)
