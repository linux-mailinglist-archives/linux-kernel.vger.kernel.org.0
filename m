Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401D4E492D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394515AbfJYLFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:05:10 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:36498 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392856AbfJYLFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:05:10 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNxP2-0003Qe-6d; Fri, 25 Oct 2019 13:05:08 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [GIT PULL] irqchip fixes for 5.4, take 2
Date:   Fri, 25 Oct 2019 12:04:56 +0100
Message-Id: <20191025110456.15650-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, alan.mikhak@sifive.com, hch@lst.de, paul.walmsley@sifive.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's what I hope is the last set of irqchip fixes for 5.4.

On the menu, one Sifive PLIC fix, where the driver could pick the
wrong context if the DT contained such information, and a GICv4
fix where the driver could send VMOVP commands to ITSs that
did not expect to receive them.

Please pull, 

	M.

The following changes since commit bb0fed1c60cccbe4063b455a7228818395dac86e:

  irqchip/sifive-plic: Switch to fasteoi flow (2019-09-18 12:29:52 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.4-2

for you to fetch changes up to 41860cc447045c811ce6d5a92f93a065a691fe8e:

  irqchip/sifive-plic: Skip contexts except supervisor in plic_init() (2019-10-25 11:48:13 +0100)

----------------------------------------------------------------
irqchip updates for 5.4, take 2

- Sifive PLIC: force driver to skip non-relevant contexts
- GICv4: Don't send VMOVP commands to ITSs that don't have
  this vPE mapped

----------------------------------------------------------------
Alan Mikhak (1):
      irqchip/sifive-plic: Skip contexts except supervisor in plic_init()

Zenghui Yu (1):
      irqchip/gic-v3-its: Use the exact ITSList for VMOVP

 drivers/irqchip/irq-gic-v3-its.c  | 21 ++++++++++++++++++---
 drivers/irqchip/irq-sifive-plic.c |  4 ++--
 2 files changed, 20 insertions(+), 5 deletions(-)
