Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0747EA32D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 10:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3ImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 04:42:17 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39041 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfH3ImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:42:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Taqk710_1567154526;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Taqk710_1567154526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Aug 2019 16:42:09 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v5 3/3] vfio/pci: make use of irq_update_devid and optimize irq ops
Date:   Fri, 30 Aug 2019 16:42:06 +0800
Message-Id: <9a8b3fc5d82c3c46feb0de673fbe898cfd884d63.1567151182.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567151182.git.luoben@linux.alibaba.com>
References: <cover.1567151182.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace (e.g. qemu) triggers a switch between KVM
irqfd and userspace eventfd, only dev_id of irqaction
(i.e. the "trigger" in this patch's context) will be
changed, but a free-then-request-irq action is taken in
current code. And, irq affinity setting in VM will also
trigger a free-then-request-irq action, which actually
changes nothing, but only need to bounce the irqbypass
registraion in case that posted-interrupt is in use.

This patch makes use of irq_update_devid() and optimize
both cases above, which reduces the risk of losing interrupt
and also cuts some overhead.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 124 ++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 37 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3fa3f72..d3a93d7 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -284,70 +284,120 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 				      int vector, int fd, bool msix)
 {
+	struct eventfd_ctx *trigger = NULL;
 	struct pci_dev *pdev = vdev->pdev;
-	struct eventfd_ctx *trigger;
 	int irq, ret;
 
 	if (vector < 0 || vector >= vdev->num_ctx)
 		return -EINVAL;
 
+	if (fd >= 0) {
+		trigger = eventfd_ctx_fdget(fd);
+		if (IS_ERR(trigger)) {
+			/* oops, going to disable this interrupt */
+			dev_info(&pdev->dev,
+				 "get ctx error on bad fd: %d for vector:%d\n",
+				 fd, vector);
+		}
+	}
+
 	irq = pci_irq_vector(pdev, vector);
 
+	/*
+	 * 'trigger' is NULL or invalid, disable the interrupt
+	 * 'trigger' is same as before, only bounce the bypass registration
+	 * 'trigger' is a new invalid one, update it to irqaction and other
+	 * data structures referencing to the old one; fallback to disable
+	 * the interrupt on error
+	 */
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
+		/*
+		 * even if the trigger is unchanged we need to bounce the
+		 * interrupt bypass connection to allow affinity changes in
+		 * the guest to be realized.
+		 */
 		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(vdev->ctx[vector].trigger);
-		vdev->ctx[vector].trigger = NULL;
+
+		if (vdev->ctx[vector].trigger == trigger) {
+			/* avoid duplicated referencing to the same trigger */
+			eventfd_ctx_put(trigger);
+
+		} else if (trigger && !IS_ERR(trigger)) {
+			ret = irq_update_devid(irq,
+					       vdev->ctx[vector].trigger, trigger);
+			if (unlikely(ret)) {
+				dev_info(&pdev->dev,
+					 "update devid of %d (token %p) failed: %d\n",
+					 irq, vdev->ctx[vector].trigger, ret);
+				eventfd_ctx_put(trigger);
+				free_irq(irq, vdev->ctx[vector].trigger);
+				kfree(vdev->ctx[vector].name);
+				eventfd_ctx_put(vdev->ctx[vector].trigger);
+				vdev->ctx[vector].trigger = NULL;
+				return ret;
+			}
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].producer.token = trigger;
+			vdev->ctx[vector].trigger = trigger;
+
+		} else {
+			free_irq(irq, vdev->ctx[vector].trigger);
+			kfree(vdev->ctx[vector].name);
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].trigger = NULL;
+		}
 	}
 
 	if (fd < 0)
 		return 0;
+	else if (IS_ERR(trigger))
+		return PTR_ERR(trigger);
 
-	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
-					   msix ? "x" : "", vector,
-					   pci_name(pdev));
-	if (!vdev->ctx[vector].name)
-		return -ENOMEM;
+	if (!vdev->ctx[vector].trigger) {
+		vdev->ctx[vector].name = kasprintf(GFP_KERNEL,
+						   "vfio-msi%s[%d](%s)",
+						   msix ? "x" : "", vector,
+						   pci_name(pdev));
+		if (!vdev->ctx[vector].name) {
+			eventfd_ctx_put(trigger);
+			return -ENOMEM;
+		}
 
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(vdev->ctx[vector].name);
-		return PTR_ERR(trigger);
-	}
+		/*
+		 * The MSIx vector table resides in device memory which may be
+		 * cleared via backdoor resets. We don't allow direct access to
+		 * the vector table so even if a userspace driver attempts to
+		 * save/restore around such a reset it would be unsuccessful.
+		 * To avoid this, restore the cached value of the message prior
+		 * to enabling.
+		 */
+		if (msix) {
+			struct msi_msg msg;
 
-	/*
-	 * The MSIx vector table resides in device memory which may be cleared
-	 * via backdoor resets. We don't allow direct access to the vector
-	 * table so even if a userspace driver attempts to save/restore around
-	 * such a reset it would be unsuccessful. To avoid this, restore the
-	 * cached value of the message prior to enabling.
-	 */
-	if (msix) {
-		struct msi_msg msg;
+			get_cached_msi_msg(irq, &msg);
+			pci_write_msi_msg(irq, &msg);
+		}
 
-		get_cached_msi_msg(irq, &msg);
-		pci_write_msi_msg(irq, &msg);
-	}
+		ret = request_irq(irq, vfio_msihandler, 0,
+				  vdev->ctx[vector].name, trigger);
+		if (ret) {
+			kfree(vdev->ctx[vector].name);
+			eventfd_ctx_put(trigger);
+			return ret;
+		}
 
-	ret = request_irq(irq, vfio_msihandler, 0,
-			  vdev->ctx[vector].name, trigger);
-	if (ret) {
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(trigger);
-		return ret;
+		vdev->ctx[vector].producer.token = trigger;
+		vdev->ctx[vector].producer.irq = irq;
+		vdev->ctx[vector].trigger = trigger;
 	}
 
-	vdev->ctx[vector].producer.token = trigger;
-	vdev->ctx[vector].producer.irq = irq;
+	/* setup bypass connection and make irte updated */
 	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
 	if (unlikely(ret))
 		dev_info(&pdev->dev,
 		"irq bypass producer (token %p) registration fails: %d\n",
 		vdev->ctx[vector].producer.token, ret);
 
-	vdev->ctx[vector].trigger = trigger;
-
 	return 0;
 }
 
-- 
1.8.3.1

