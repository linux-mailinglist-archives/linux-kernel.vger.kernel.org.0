Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD07CAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfGaRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:50:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGaRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:50:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DE7169E;
        Wed, 31 Jul 2019 10:50:15 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252333F71F;
        Wed, 31 Jul 2019 10:50:12 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.3-rc3
Date:   Wed, 31 Jul 2019 18:50:00 +0100
Message-Id: <20190731175000.12948-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small bunch of fixes from the irqchip department. Nothing
major, just a number of fixes for error paths, a GPCv2 irq_set_type()
fix, and a bunch of /* fall-though */ annotation to keep the build
quiet.

Please pull.

	M.

The following changes since commit 3dae67ce600caaa92c9af6e0cb6cad2db2632a0a:

  irqchip/gic-pm: Remove PM_CLK dependency (2019-07-03 09:33:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.3

for you to fetch changes up to b5fa9fc9e809f84bb20439730162eccfed906a76:

  irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe() (2019-07-26 14:40:01 +0100)

----------------------------------------------------------------
irqchip fixes for 5.3

- Fix a couple of UAF on error paths (RZA1, GICv3 ITS)
- Fix iMX GPCv2 trigger setting
- Add missing of_node_put on error path in MBIGEN
- Add another bunch of /* fall-through */ to silence warnings

----------------------------------------------------------------
Anders Roxell (1):
      irqchip/gic-v3: Mark expected switch fall-through

Lucas Stach (1):
      irqchip/irq-imx-gpcv2: Forward irq type to parent

Nianyao Tang (1):
      irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail

Nishka Dasgupta (1):
      irqchip/irq-mbigen: Add of_node_put() before return

Wen Yang (1):
      irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe()

 drivers/irqchip/irq-gic-v3-its.c   |  2 +-
 drivers/irqchip/irq-gic-v3.c       |  4 ++++
 drivers/irqchip/irq-imx-gpcv2.c    |  1 +
 drivers/irqchip/irq-mbigen.c       |  9 +++++++--
 drivers/irqchip/irq-renesas-rza1.c | 15 ++++++++-------
 5 files changed, 21 insertions(+), 10 deletions(-)
