Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40F88EC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbfHONDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:03:10 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37323 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730775AbfHONDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:03:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZYQf.p_1565874181;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZYQf.p_1565874181)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 21:03:06 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com,
        linyunsheng@huawei.com
Subject: [PATCH v3 0/3] genirq/vfio: Introduce update_irq_devid and optimize VFIO irq ops
Date:   Thu, 15 Aug 2019 21:02:58 +0800
Message-Id: <cover.1565857737.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO takes a lot of free-then-request-irq actions whenever
a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
irq. Those actions only change the cookie data of irqaction or even
change nothing. The free-then-request-irq not only adds more latency,
but also increases the risk of losing interrupt, which may lead to a
VM hung forever in waiting for IO completion

This patchset solved the issue by:
Patch 2 introduces update_irq_devid to only update dev_id of irqaction
Patch 3 make use of update_irq_devid and optimize irq operations in VFIO

changes from v2:
 - reformat to avoid quoted string split across lines and etc.

changes from v1:
 - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
 - enhance error recovery code and debugging info in update_irq_devid
 - use __must_check in external referencing of update_irq_devid
 - use EXPORT_SYMBOL_GPL for update_irq_devid
 - reformat code of patch 3 for better readability

Ben Luo (3):
  genirq: enhance error recovery code in free irq
  genirq: introduce update_irq_devid()
  vfio_pci: make use of update_irq_devid and optimize irq ops

 drivers/vfio/pci/vfio_pci_intrs.c | 101 +++++++++++++++++++++-------------
 include/linux/interrupt.h         |   3 ++
 kernel/irq/manage.c               | 110 +++++++++++++++++++++++++++++++++-----
 3 files changed, 164 insertions(+), 50 deletions(-)

-- 
1.8.3.1

