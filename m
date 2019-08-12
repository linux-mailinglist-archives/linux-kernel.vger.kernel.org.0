Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAA89902
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfHLIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 04:52:33 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42814 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfHLIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:52:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZG-hna_1565599941;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZG-hna_1565599941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Aug 2019 16:52:28 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: [PATCH v2 2/3] genirq: introduce update_irq_devid()
Date:   Mon, 12 Aug 2019 16:52:05 +0800
Message-Id: <d98748e6da771f832571dc33f983976be4817bf4.1565594108.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1565594108.git.luoben@linux.alibaba.com>
References: <cover.1565594108.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1565594108.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com> <cover.1565594108.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, only the dev_id field of irqaction need to be changed.
E.g. KVM VM with device passthru via VFIO may switch irq injection
path between KVM irqfd and userspace eventfd. These two paths
share the same irq num and handler for the same vector of a device,
only with different dev_id referencing to different fds' contexts.

So, instead of free/request irq, only update dev_id of irqaction.
This narrows the gap for setting up new irq (and irte, if has)
and also gains some performance benefit.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |  3 ++
 kernel/irq/manage.c       | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a..6060c5a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -172,6 +172,9 @@ struct irqaction {
 request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *dev);
 
+extern int __must_check
+update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id);
+
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b97ee5e..4c34a23 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2064,6 +2064,85 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 EXPORT_SYMBOL(request_threaded_irq);
 
 /**
+ *	update_irq_devid - update irq dev_id to a new one
+ *	@irq: Interrupt line to update
+ *	@dev_id: A cookie to find the irqaction to update
+ *	@new_dev_id: New cookie passed to the handler function
+ *
+ *	Sometimes, only the cookie data need to be changed.
+ *	Instead of free/request irq, only update dev_id here
+ *	Not only to gain some performance benefit, but also
+ *	reduce the risk of losing interrupt.
+ *
+ *	E.g. irq affinity setting in a VM with VFIO passthru
+ *	device is carried out in a free-then-request-irq way
+ *	since lack of this very function. The free_irq()
+ *	eventually triggers deactivation of IR domain, which
+ *	will cleanup IRTE. There is a gap before request_irq()
+ *	finally setup the IRTE again. In this gap, a in-flight
+ *	irq buffering in hardware layer may trigger DMAR fault
+ *	and be lost.
+ *
+ *	On failure, it returns a negative value. On success,
+ *	it returns 0
+ */
+int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action, **action_ptr;
+	unsigned long flags;
+
+	if (in_interrupt()) {
+		WARN(1, "Trying to update IRQ %d (dev_id %p to %p) \
+				from IRQ context!\n", irq, dev_id, new_dev_id);
+		return -EPERM;
+	}
+
+	if (!desc)
+		return -EINVAL;
+
+	chip_bus_lock(desc);
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	/*
+	 * There can be multiple actions per IRQ descriptor, find the right
+	 * one based on the dev_id:
+	 */
+	action_ptr = &desc->action;
+	for (;;) {
+		action = *action_ptr;
+
+		if (!action) {
+			raw_spin_unlock_irqrestore(&desc->lock, flags);
+			chip_bus_sync_unlock(desc);
+			WARN(1, "Trying to update already-free IRQ %d \
+					(dev_id %p to %p)\n",
+					irq, dev_id, new_dev_id);
+			return -ENXIO;
+		}
+
+		if (action->dev_id == dev_id) {
+			action->dev_id = new_dev_id;
+			break;
+		}
+		action_ptr = &action->next;
+	}
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	chip_bus_sync_unlock(desc);
+
+	/*
+	 * Make sure it's not being used on another CPU:
+	 * There is a risk of UAF for old *dev_id, if it is
+	 * freed in a short time after this func returns
+	 */
+	synchronize_irq(irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(update_irq_devid);
+
+/**
  *	request_any_context_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
-- 
1.8.3.1

