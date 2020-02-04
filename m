Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD387151774
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBDJLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:11:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgBDJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:11:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA2F72ABEF3214DF7FDC;
        Tue,  4 Feb 2020 17:11:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 17:11:34 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/5] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
Date:   Tue, 4 Feb 2020 17:09:35 +0800
Message-ID: <20200204090940.1225-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains some cleanups, VPROPBASER field programming fix
and level2 vPE table allocation enhancement, collected while looking
through the GICv4.1 driver one more time.

Hope they will help, thanks!

Zenghui Yu (5):
  irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
  irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
  irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
  irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
  irqchip/gic-v3-its: Remove superfluous WARN_ON

 drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 2 files changed, 75 insertions(+), 7 deletions(-)

-- 
2.19.1


