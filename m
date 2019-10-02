Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2CC4A35
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJBJG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:60109 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFaas-00057p-BF; Wed, 02 Oct 2019 11:06:46 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: Relax ICC_PMR_EL1 synchronisation when possible
Date:   Wed,  2 Oct 2019 10:06:11 +0100
Message-Id: <20191002090613.14236-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very late update on [1], fixing the 32bit compilation issue that
was present in v2, and adding an extra message in the kernel log to find out
what is going on.

[1] http://lore.kernel.org/r/20190802125208.73162-1-maz@kernel.org

Marc Zyngier (2):
  arm64: Relax ICC_PMR_EL1 accesses when ICC_CTLR_EL1.PMHE is clear
  arm64: Document ICC_CTLR_EL3.PMHE setting requirements

 Documentation/arm64/booting.rst    |  3 +++
 arch/arm64/include/asm/barrier.h   | 12 ++++++++++++
 arch/arm64/include/asm/daifflags.h |  3 ++-
 arch/arm64/include/asm/irqflags.h  | 19 ++++++++++---------
 arch/arm64/include/asm/kvm_host.h  |  3 +--
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kvm/hyp/switch.c        |  4 ++--
 drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 9 files changed, 56 insertions(+), 16 deletions(-)

-- 
2.20.1

