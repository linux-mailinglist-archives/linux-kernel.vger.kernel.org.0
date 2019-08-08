Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F146E86150
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfHHMGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 08:06:37 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39621 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfHHMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:06:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TYxvm0-_1565265986;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TYxvm0-_1565265986)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Aug 2019 20:06:34 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com
Subject: [PATCH 0/2] introduce update_irq_devid and optimize VFIO irq ops
Date:   Thu,  8 Aug 2019 20:07:30 +0800
Message-Id: <cover.1565263723.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO takes a lot of free-then-request-irq actions whenever
a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
irq. Those actions only change the cookie data of irqaction or even
change nothing. The free-then-request-irq not only add more latency,
but also increases the risk of losing interrupt, this may lead to a
VM hung forever in waiting IO completion

This patchset solved this issue by:
patch 1 introduces update_irq_devid to only update dev_id of irqaction
patch 2 make use of update_irq_devid and optimize irq operations in VFIO

Ben Luo (2):
  genirq: introduce update_irq_devid()
  vfio_pci: make use of update_irq_devid and optimize irq ops

 drivers/vfio/pci/vfio_pci_intrs.c | 100 +++++++++++++++++++++++---------------
 include/linux/interrupt.h         |   3 ++
 kernel/irq/manage.c               |  74 ++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 38 deletions(-)

-- 
1.8.3.1

