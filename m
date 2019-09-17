Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC6B48DD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404678AbfIQIKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:10:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34317 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIQIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:10:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so1595512pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fA0z5ieCbARMxxxMnq0+AqbVvKuf143/mK7L6hthEKY=;
        b=c39v6TSEbEiwTTJ79uv45B05sP/wG4Oc9p7oi5rsYNGp68mZWCqfVn0zCz+eB8Wjz5
         j51OWyNdFbEpCVv3DZQBoyP7ymLXe3BlUnUiYqx/JbQD7+SO05fg5niI/ryUkux/vVdD
         en69Pt9nhtDgC6bfBpwYpFkrNHxx9g9O/aYH+GaSQUJbedw0PKdqwk6jaQNzVTxFWuyo
         lhDoNr7aOaO2luyjfZXFPtKy2jFS0uE8QvH10MIVIvQjYMKA8A6YgN9b4kOowxnsJlV8
         9JCVKIyafPxrNRMxQb6ydwHovpMdP9a0KUzemviuf/KUQwGHao/UcFrJ+qxEnRg8Vvb+
         9W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fA0z5ieCbARMxxxMnq0+AqbVvKuf143/mK7L6hthEKY=;
        b=JBrWHzih/oe0E1hjwZYM5fJtuDuO4VYsNI1mhHuzikuudMQbXKA2qatxayn42VXksa
         aRvVU7wMzF/fdwCPT2nUNTVIK/ayIz9vYcQzEH+cz8AV+3BGEUDuaTPIz+4pWY+qa7sm
         iYvdpQ2M1NlFr4jO7Bizd98Agx1l8R31pjniIqTqLWvrtzRYh/p8aA2pZZ7dOycC+C/v
         snd7glNHlWQ75Q/easnYMSfKwDAgn+FyNll+bOcptZsV1TtH8GymmeUyADSN83yLhWgN
         mz3NqyT57+3+yrj/+LaiI77qs/IjCz6JDDByvkpueZYtBBN+E3+eMxZVLqPZXEKUFRxS
         Zsiw==
X-Gm-Message-State: APjAAAXnXUftUUww/m9MTzcRFCGRd4e2Dw1r1JBKc3X2NO1n2tWNYiD/
        BcpUjK7eJZ9+6LCiJ7l5caCoOQ==
X-Google-Smtp-Source: APXvYqydPKjqQ9VA7QCD9AzuaUJ/7atmPSkuUBqNe4/KytaFi6WL2iNqA6AkbrdXuNR41YEJHWXjTg==
X-Received: by 2002:a63:d111:: with SMTP id k17mr1715836pgg.355.1568707829924;
        Tue, 17 Sep 2019 01:10:29 -0700 (PDT)
Received: from localhost.localdomain ([45.41.132.67])
        by smtp.gmail.com with ESMTPSA id ep10sm6076773pjb.2.2019.09.17.01.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 01:10:29 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 2/2] uacce: add uacce driver
Date:   Tue, 17 Sep 2019 16:10:06 +0800
Message-Id: <1568707806-14492-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568707806-14492-1-git-send-email-zhangfei.gao@linaro.org>
References: <1568707806-14492-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
provide Shared Virtual Addressing (SVA) between accelerators and processes.
So accelerator can access any data structure of the main cpu.
This differs from the data sharing between cpu and io device, which share
data content rather than address.
Since unified address, hardware and user space of process can share the
same virtual address in the communication.

Uacce create a chrdev for every registration, the queue is allocated to
the process when the chrdev is opened. Then the process can access the
hardware resource by interact with the queue file. By mmap the queue
file space to user space, the process can directly put requests to the
hardware without syscall to the kernel space.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/ABI/testing/sysfs-driver-uacce |   47 ++
 drivers/misc/Kconfig                         |    1 +
 drivers/misc/Makefile                        |    1 +
 drivers/misc/uacce/Kconfig                   |   13 +
 drivers/misc/uacce/Makefile                  |    2 +
 drivers/misc/uacce/uacce.c                   | 1028 ++++++++++++++++++++++++++
 include/linux/uacce.h                        |  156 ++++
 include/uapi/misc/uacce.h                    |   40 +
 8 files changed, 1288 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce.h

diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
new file mode 100644
index 0000000..563f55c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-uacce
@@ -0,0 +1,47 @@
+What:           /sys/class/uacce/hisi_zip-<n>/id
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Id of the device.
+
+What:           /sys/class/uacce/hisi_zip-<n>/api
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Api of the device, used by application to match the correct driver
+
+What:           /sys/class/uacce/hisi_zip-<n>/flags
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Attributes of the device, see UACCE_DEV_xxx flag defined in uacce.h
+
+What:           /sys/class/uacce/hisi_zip-<n>/available_instances
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Available instances left of the device
+
+What:           /sys/class/uacce/hisi_zip-<n>/algorithms
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Algorithms supported by this accelerator
+
+What:           /sys/class/uacce/hisi_zip-<n>/qfrs_offset
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Page offsets of each queue file regions
+
+What:           /sys/class/uacce/hisi_zip-<n>/numa_distance
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Distance of device node to cpu node
+
+What:           /sys/class/uacce/hisi_zip-<n>/node_id
+Date:           Sep 2019
+KernelVersion:  5.4
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Id of the numa node
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1690035..94d363c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -503,4 +503,5 @@ source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
+source "drivers/misc/uacce/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index abd8ae2..93a131b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,4 +58,5 @@ obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/uacce/Kconfig b/drivers/misc/uacce/Kconfig
new file mode 100644
index 0000000..e854354
--- /dev/null
+++ b/drivers/misc/uacce/Kconfig
@@ -0,0 +1,13 @@
+config UACCE
+	tristate "Accelerator Framework for User Land"
+	depends on IOMMU_API
+	help
+	  UACCE provides interface for the user process to access the hardware
+	  without interaction with the kernel space in data path.
+
+	  The user-space interface is described in
+	  include/uapi/misc/uacce.h
+
+	  See Documentation/misc-devices/uacce.rst for more details.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/misc/uacce/Makefile b/drivers/misc/uacce/Makefile
new file mode 100644
index 0000000..5b4374e
--- /dev/null
+++ b/drivers/misc/uacce/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-$(CONFIG_UACCE) += uacce.o
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
new file mode 100644
index 0000000..fc02987
--- /dev/null
+++ b/drivers/misc/uacce/uacce.c
@@ -0,0 +1,1028 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/compat.h>
+#include <linux/dma-iommu.h>
+#include <linux/file.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
+#include <linux/uacce.h>
+
+static struct class *uacce_class;
+static DEFINE_IDR(uacce_idr);
+static dev_t uacce_devt;
+static DEFINE_MUTEX(uacce_mutex);
+static const struct file_operations uacce_fops;
+
+static int uacce_queue_map_qfr(struct uacce_queue *q,
+			       struct uacce_qfile_region *qfr)
+{
+	struct device *dev = q->uacce->pdev;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	int i, j, ret;
+
+	if (!(qfr->flags & UACCE_QFRF_MAP) || (qfr->flags & UACCE_QFRF_DMA))
+		return 0;
+
+	if (!domain)
+		return -ENODEV;
+
+	for (i = 0; i < qfr->nr_pages; i++) {
+		ret = iommu_map(domain, qfr->iova + i * PAGE_SIZE,
+				page_to_phys(qfr->pages[i]),
+				PAGE_SIZE, qfr->prot | q->uacce->prot);
+		if (ret)
+			goto err_with_map_pages;
+
+		get_page(qfr->pages[i]);
+	}
+
+	return 0;
+
+err_with_map_pages:
+	for (j = i - 1; j >= 0; j--) {
+		iommu_unmap(domain, qfr->iova + j * PAGE_SIZE, PAGE_SIZE);
+		put_page(qfr->pages[j]);
+	}
+	return ret;
+}
+
+static void uacce_queue_unmap_qfr(struct uacce_queue *q,
+				  struct uacce_qfile_region *qfr)
+{
+	struct device *dev = q->uacce->pdev;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	int i;
+
+	if (!domain || !qfr)
+		return;
+
+	if (!(qfr->flags & UACCE_QFRF_MAP) || (qfr->flags & UACCE_QFRF_DMA))
+		return;
+
+	for (i = qfr->nr_pages - 1; i >= 0; i--) {
+		iommu_unmap(domain, qfr->iova + i * PAGE_SIZE, PAGE_SIZE);
+		put_page(qfr->pages[i]);
+	}
+}
+
+static int uacce_qfr_alloc_pages(struct uacce_qfile_region *qfr)
+{
+	int i, j;
+
+	qfr->pages = kcalloc(qfr->nr_pages, sizeof(*qfr->pages), GFP_ATOMIC);
+	if (!qfr->pages)
+		return -ENOMEM;
+
+	for (i = 0; i < qfr->nr_pages; i++) {
+		qfr->pages[i] = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+		if (!qfr->pages[i])
+			goto err_with_pages;
+	}
+
+	return 0;
+
+err_with_pages:
+	for (j = i - 1; j >= 0; j--)
+		put_page(qfr->pages[j]);
+
+	kfree(qfr->pages);
+	return -ENOMEM;
+}
+
+static void uacce_qfr_free_pages(struct uacce_qfile_region *qfr)
+{
+	int i;
+
+	for (i = 0; i < qfr->nr_pages; i++)
+		put_page(qfr->pages[i]);
+
+	kfree(qfr->pages);
+}
+
+static inline int uacce_queue_mmap_qfr(struct uacce_queue *q,
+				       struct uacce_qfile_region *qfr,
+				       struct vm_area_struct *vma)
+{
+	int i, ret;
+
+	for (i = 0; i < qfr->nr_pages; i++) {
+		ret = remap_pfn_range(vma, vma->vm_start + (i << PAGE_SHIFT),
+				      page_to_pfn(qfr->pages[i]), PAGE_SIZE,
+				      vma->vm_page_prot);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct uacce_qfile_region *
+uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
+		    enum uacce_qfrt type, unsigned int flags)
+{
+	struct uacce_qfile_region *qfr;
+	struct uacce_device *uacce = q->uacce;
+	unsigned long vm_pgoff;
+	int ret = -ENOMEM;
+
+	qfr = kzalloc(sizeof(*qfr), GFP_ATOMIC);
+	if (!qfr)
+		return ERR_PTR(-ENOMEM);
+
+	qfr->type = type;
+	qfr->flags = flags;
+	qfr->iova = vma->vm_start;
+	qfr->nr_pages = vma_pages(vma);
+
+	if (vma->vm_flags & VM_READ)
+		qfr->prot |= IOMMU_READ;
+
+	if (vma->vm_flags & VM_WRITE)
+		qfr->prot |= IOMMU_WRITE;
+
+	if (flags & UACCE_QFRF_SELFMT) {
+		if (!uacce->ops->mmap) {
+			ret = -EINVAL;
+			goto err_with_qfr;
+		}
+
+		ret = uacce->ops->mmap(q, vma, qfr);
+		if (ret)
+			goto err_with_qfr;
+		return qfr;
+	}
+
+	/* allocate memory */
+	if (flags & UACCE_QFRF_DMA) {
+		qfr->kaddr = dma_alloc_coherent(uacce->pdev,
+						qfr->nr_pages << PAGE_SHIFT,
+						&qfr->dma, GFP_KERNEL);
+		if (!qfr->kaddr) {
+			ret = -ENOMEM;
+			goto err_with_qfr;
+		}
+	} else {
+		ret = uacce_qfr_alloc_pages(qfr);
+		if (ret)
+			goto err_with_qfr;
+	}
+
+	/* map to device */
+	ret = uacce_queue_map_qfr(q, qfr);
+	if (ret)
+		goto err_with_pages;
+
+	/* mmap to user space */
+	if (flags & UACCE_QFRF_MMAP) {
+		if (flags & UACCE_QFRF_DMA) {
+			/* dma_mmap_coherent() requires vm_pgoff as 0
+			 * restore vm_pfoff to initial value for mmap()
+			 */
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			ret = dma_mmap_coherent(uacce->pdev, vma, qfr->kaddr,
+						qfr->dma,
+						qfr->nr_pages << PAGE_SHIFT);
+			vma->vm_pgoff = vm_pgoff;
+		} else {
+			ret = uacce_queue_mmap_qfr(q, qfr, vma);
+		}
+
+		if (ret)
+			goto err_with_mapped_qfr;
+	}
+
+	return qfr;
+
+err_with_mapped_qfr:
+	uacce_queue_unmap_qfr(q, qfr);
+err_with_pages:
+	if (flags & UACCE_QFRF_DMA)
+		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
+				  qfr->kaddr, qfr->dma);
+	else
+		uacce_qfr_free_pages(qfr);
+err_with_qfr:
+	kfree(qfr);
+
+	return ERR_PTR(ret);
+}
+
+static void uacce_destroy_region(struct uacce_queue *q,
+				 struct uacce_qfile_region *qfr)
+{
+	struct uacce_device *uacce = q->uacce;
+
+	if (qfr->flags & UACCE_QFRF_DMA) {
+		dma_free_coherent(uacce->pdev, qfr->nr_pages << PAGE_SHIFT,
+				  qfr->kaddr, qfr->dma);
+	} else if (qfr->pages) {
+		if (qfr->flags & UACCE_QFRF_KMAP && qfr->kaddr) {
+			vunmap(qfr->kaddr);
+			qfr->kaddr = NULL;
+		}
+
+		uacce_qfr_free_pages(qfr);
+	}
+	kfree(qfr);
+}
+
+static long uacce_cmd_share_qfr(struct uacce_queue *tgt, int fd)
+{
+	struct file *filep;
+	struct uacce_queue *src;
+	int ret = -EINVAL;
+
+	mutex_lock(&uacce_mutex);
+
+	if (tgt->state != UACCE_Q_STARTED)
+		goto out_with_lock;
+
+	filep = fget(fd);
+	if (!filep)
+		goto out_with_lock;
+
+	if (filep->f_op != &uacce_fops)
+		goto out_with_fd;
+
+	src = filep->private_data;
+	if (!src)
+		goto out_with_fd;
+
+	/* no share sva is needed if the dev can do fault-from-dev */
+	if (tgt->uacce->flags & UACCE_DEV_FAULT_FROM_DEV)
+		goto out_with_fd;
+
+	if (!src->qfrs[UACCE_QFRT_SS] || tgt->qfrs[UACCE_QFRT_SS])
+		goto out_with_fd;
+
+	ret = uacce_queue_map_qfr(tgt, src->qfrs[UACCE_QFRT_SS]);
+	if (ret)
+		goto out_with_fd;
+
+	tgt->qfrs[UACCE_QFRT_SS] = src->qfrs[UACCE_QFRT_SS];
+	list_add(&tgt->list, &src->qfrs[UACCE_QFRT_SS]->qs);
+
+out_with_fd:
+	fput(filep);
+out_with_lock:
+	mutex_unlock(&uacce_mutex);
+	return ret;
+}
+
+static int uacce_start_queue(struct uacce_queue *q)
+{
+	struct uacce_qfile_region *qfr;
+	int ret = -EINVAL;
+	int i, j;
+
+	mutex_lock(&uacce_mutex);
+
+	if (q->state != UACCE_Q_INIT)
+		goto out_with_lock;
+
+	/*
+	 * map KMAP qfr to kernel
+	 * vmap should be done in non-spinlocked context!
+	 */
+	for (i = 0; i < UACCE_QFRT_MAX; i++) {
+		qfr = q->qfrs[i];
+		if (qfr && (qfr->flags & UACCE_QFRF_KMAP) && !qfr->kaddr) {
+			qfr->kaddr = vmap(qfr->pages, qfr->nr_pages, VM_MAP,
+					  PAGE_KERNEL);
+			if (!qfr->kaddr) {
+				ret = -ENOMEM;
+				goto err_with_vmap;
+			}
+		}
+	}
+
+	if (q->uacce->ops->start_queue) {
+		ret = q->uacce->ops->start_queue(q);
+		if (ret < 0)
+			goto err_with_vmap;
+	}
+
+	q->state = UACCE_Q_STARTED;
+	mutex_unlock(&uacce_mutex);
+
+	return 0;
+
+err_with_vmap:
+	for (j = i; j >= 0; j--) {
+		qfr = q->qfrs[j];
+		if (qfr && qfr->kaddr) {
+			vunmap(qfr->kaddr);
+			qfr->kaddr = NULL;
+		}
+	}
+out_with_lock:
+	mutex_unlock(&uacce_mutex);
+	return ret;
+}
+
+/*
+ * While user space releases a queue, all the relatives on the queue
+ * should be released immediately by this putting.
+ */
+static long uacce_put_queue(struct uacce_queue *q)
+{
+	struct uacce_device *uacce = q->uacce;
+
+	mutex_lock(&uacce_mutex);
+
+	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
+		uacce->ops->stop_queue(q);
+
+	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
+	     uacce->ops->put_queue)
+		uacce->ops->put_queue(q);
+
+	q->state = UACCE_Q_ZOMBIE;
+	mutex_unlock(&uacce_mutex);
+
+	return 0;
+}
+
+static long uacce_fops_unl_ioctl(struct file *filep,
+				 unsigned int cmd, unsigned long arg)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce_device *uacce = q->uacce;
+
+	switch (cmd) {
+	case UACCE_CMD_SHARE_SVAS:
+		return uacce_cmd_share_qfr(q, arg);
+
+	case UACCE_CMD_START:
+		return uacce_start_queue(q);
+
+	case UACCE_CMD_PUT_Q:
+		return uacce_put_queue(q);
+
+	default:
+		if (!uacce->ops->ioctl)
+			return -EINVAL;
+
+		return uacce->ops->ioctl(q, cmd, arg);
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static long uacce_fops_compat_ioctl(struct file *filep,
+				   unsigned int cmd, unsigned long arg)
+{
+	arg = (unsigned long)compat_ptr(arg);
+
+	return uacce_fops_unl_ioctl(filep, cmd, arg);
+}
+#endif
+
+static int uacce_dev_open_check(struct uacce_device *uacce)
+{
+	if (uacce->flags & UACCE_DEV_PASID)
+		return 0;
+
+	/*
+	 * The device can be opened once if it dose not support pasid
+	 */
+	if (kref_read(&uacce->cdev->kobj.kref) > 2)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int uacce_fops_open(struct inode *inode, struct file *filep)
+{
+	struct uacce_queue *q;
+	struct iommu_sva *handle = NULL;
+	struct uacce_device *uacce;
+	int ret;
+	int pasid = 0;
+
+	uacce = idr_find(&uacce_idr, iminor(inode));
+	if (!uacce)
+		return -ENODEV;
+
+	if (!try_module_get(uacce->pdev->driver->owner))
+		return -ENODEV;
+
+	ret = uacce_dev_open_check(uacce);
+	if (ret)
+		goto out_with_module;
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID) {
+		handle = iommu_sva_bind_device(uacce->pdev, current->mm, NULL);
+		if (IS_ERR(handle))
+			goto out_with_module;
+		pasid = iommu_sva_get_pasid(handle);
+	}
+#endif
+	q = kzalloc(sizeof(struct uacce_queue), GFP_KERNEL);
+	if (!q) {
+		ret = -ENOMEM;
+		goto out_with_module;
+	}
+
+	if (uacce->ops->get_queue) {
+		ret = uacce->ops->get_queue(uacce, pasid, q);
+		if (ret < 0)
+			goto out_with_mem;
+	}
+
+	q->pasid = pasid;
+	q->handle = handle;
+	q->uacce = uacce;
+	q->mm = current->mm;
+	memset(q->qfrs, 0, sizeof(q->qfrs));
+	INIT_LIST_HEAD(&q->list);
+	init_waitqueue_head(&q->wait);
+	filep->private_data = q;
+	q->state = UACCE_Q_INIT;
+
+	return 0;
+
+out_with_mem:
+	kfree(q);
+out_with_module:
+	module_put(uacce->pdev->driver->owner);
+	return ret;
+}
+
+static int uacce_fops_release(struct inode *inode, struct file *filep)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce_qfile_region *qfr;
+	struct uacce_device *uacce = q->uacce;
+	bool is_to_free_region;
+	int free_pages = 0;
+	int i;
+
+	mutex_lock(&uacce_mutex);
+
+	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
+		uacce->ops->stop_queue(q);
+
+	for (i = 0; i < UACCE_QFRT_MAX; i++) {
+		qfr = q->qfrs[i];
+		if (!qfr)
+			continue;
+
+		is_to_free_region = false;
+		uacce_queue_unmap_qfr(q, qfr);
+		if (i == UACCE_QFRT_SS) {
+			list_del(&q->list);
+			if (list_empty(&qfr->qs))
+				is_to_free_region = true;
+		} else
+			is_to_free_region = true;
+
+		if (is_to_free_region) {
+			free_pages += qfr->nr_pages;
+			uacce_destroy_region(q, qfr);
+		}
+
+		qfr = NULL;
+	}
+
+	if (current->mm == q->mm) {
+		down_write(&q->mm->mmap_sem);
+		q->mm->data_vm -= free_pages;
+		up_write(&q->mm->mmap_sem);
+	}
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID)
+		iommu_sva_unbind_device(q->handle);
+#endif
+
+	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
+	     uacce->ops->put_queue)
+		uacce->ops->put_queue(q);
+
+	kfree(q);
+	mutex_unlock(&uacce_mutex);
+
+	module_put(uacce->pdev->driver->owner);
+
+	return 0;
+}
+
+static int uacce_get_region_type(struct uacce_device *uacce,
+				 struct vm_area_struct *vma)
+{
+	enum uacce_qfrt type = UACCE_QFRT_MAX;
+	size_t next_start = UACCE_QFR_NA;
+	int i;
+
+	for (i = UACCE_QFRT_MAX - 1; i >= 0; i--) {
+		if (vma->vm_pgoff >= uacce->qf_pg_start[i]) {
+			type = i;
+			break;
+		}
+	}
+
+	/* make sure the mapping size is exactly the same as the region */
+	if (type < UACCE_QFRT_SS) {
+		for (i = type + 1; i < UACCE_QFRT_MAX; i++)
+			if (uacce->qf_pg_start[i] != UACCE_QFR_NA) {
+				next_start = uacce->qf_pg_start[i];
+				break;
+			}
+
+		if (next_start == UACCE_QFR_NA)
+			return -EINVAL;
+
+		if (vma_pages(vma) != next_start - uacce->qf_pg_start[type])
+			return -EINVAL;
+	}
+
+	return type;
+}
+
+static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce_device *uacce = q->uacce;
+	enum uacce_qfrt type;
+	struct uacce_qfile_region *qfr;
+	unsigned int flags = 0;
+	int ret;
+
+	ret = uacce_get_region_type(uacce, vma);
+	if (ret < 0)
+		return ret;
+	type = ret;
+
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;
+
+	mutex_lock(&uacce_mutex);
+
+	/* fixme: if the region need no pages, we don't need to check it */
+	if (q->mm->data_vm + vma_pages(vma) >
+	    rlimit(RLIMIT_DATA) >> PAGE_SHIFT) {
+		ret = -ENOMEM;
+		goto out_with_lock;
+	}
+
+	if (q->qfrs[type]) {
+		ret = -EBUSY;
+		goto out_with_lock;
+	}
+
+	switch (type) {
+	case UACCE_QFRT_MMIO:
+		flags = UACCE_QFRF_SELFMT;
+		break;
+
+	case UACCE_QFRT_SS:
+		if (q->state != UACCE_Q_STARTED) {
+			ret = -EINVAL;
+			goto out_with_lock;
+		}
+
+		if (uacce->flags & UACCE_DEV_FAULT_FROM_DEV) {
+			ret = -EINVAL;
+			goto out_with_lock;
+		}
+
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
+
+		break;
+
+	case UACCE_QFRT_DKO:
+		if (uacce->flags & UACCE_DEV_PASID) {
+			ret = -EINVAL;
+			goto out_with_lock;
+		}
+
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_KMAP;
+
+		break;
+
+	case UACCE_QFRT_DUS:
+		if (uacce->flags & UACCE_DEV_PASID) {
+			flags = UACCE_QFRF_SELFMT;
+			break;
+		}
+
+		flags = UACCE_QFRF_MAP | UACCE_QFRF_MMAP;
+		break;
+
+	default:
+		WARN_ON(&uacce->dev);
+		break;
+	}
+
+	qfr = uacce_create_region(q, vma, type, flags);
+	if (IS_ERR(qfr)) {
+		ret = PTR_ERR(qfr);
+		goto out_with_lock;
+	}
+	q->qfrs[type] = qfr;
+
+	if (type == UACCE_QFRT_SS) {
+		INIT_LIST_HEAD(&qfr->qs);
+		list_add(&q->list, &q->qfrs[type]->qs);
+	}
+
+	mutex_unlock(&uacce_mutex);
+
+	if (qfr->pages)
+		q->mm->data_vm += qfr->nr_pages;
+
+	return 0;
+
+out_with_lock:
+	mutex_unlock(&uacce_mutex);
+	return ret;
+}
+
+static __poll_t uacce_fops_poll(struct file *file, poll_table *wait)
+{
+	struct uacce_queue *q = file->private_data;
+	struct uacce_device *uacce = q->uacce;
+
+	poll_wait(file, &q->wait, wait);
+	if (uacce->ops->is_q_updated && uacce->ops->is_q_updated(q))
+		return EPOLLIN | EPOLLRDNORM;
+
+	return 0;
+}
+
+static const struct file_operations uacce_fops = {
+	.owner		= THIS_MODULE,
+	.open		= uacce_fops_open,
+	.release	= uacce_fops_release,
+	.unlocked_ioctl	= uacce_fops_unl_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= uacce_fops_compat_ioctl,
+#endif
+	.mmap		= uacce_fops_mmap,
+	.poll		= uacce_fops_poll,
+};
+
+#define to_uacce_device(dev) container_of(dev, struct uacce_device, dev)
+
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%d\n", uacce->dev_id);
+}
+
+static ssize_t api_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%s\n", uacce->api_ver);
+}
+
+static ssize_t numa_distance_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int distance;
+
+	distance = node_distance(smp_processor_id(), uacce->pdev->numa_node);
+
+	return sprintf(buf, "%d\n", abs(distance));
+}
+
+static ssize_t node_id_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int node_id;
+
+	node_id = dev_to_node(uacce->pdev);
+
+	return sprintf(buf, "%d\n", node_id);
+}
+
+static ssize_t flags_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%u\n", uacce->flags);
+}
+
+static ssize_t available_instances_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int val = 0;
+
+	if (uacce->ops->get_available_instances)
+		val = uacce->ops->get_available_instances(uacce);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t algorithms_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%s", uacce->algs);
+}
+
+static ssize_t qfrs_offset_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int i, ret;
+	unsigned long offset;
+
+	for (i = 0, ret = 0; i < UACCE_QFRT_MAX; i++) {
+		offset = uacce->qf_pg_start[i];
+		if (offset != UACCE_QFR_NA)
+			offset = offset << PAGE_SHIFT;
+		if (i == UACCE_QFRT_SS)
+			break;
+		ret += sprintf(buf + ret, "%lu\t", offset);
+	}
+	ret += sprintf(buf + ret, "%lu\n", offset);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(api);
+static DEVICE_ATTR_RO(numa_distance);
+static DEVICE_ATTR_RO(node_id);
+static DEVICE_ATTR_RO(flags);
+static DEVICE_ATTR_RO(available_instances);
+static DEVICE_ATTR_RO(algorithms);
+static DEVICE_ATTR_RO(qfrs_offset);
+
+static struct attribute *uacce_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_api.attr,
+	&dev_attr_node_id.attr,
+	&dev_attr_numa_distance.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_available_instances.attr,
+	&dev_attr_algorithms.attr,
+	&dev_attr_qfrs_offset.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(uacce_dev);
+
+static void uacce_release(struct device *dev)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	kfree(uacce);
+}
+
+/* Borrowed from VFIO to fix msi translation */
+static bool uacce_iommu_has_sw_msi(struct iommu_group *group,
+				   phys_addr_t *base)
+{
+	struct list_head group_resv_regions;
+	struct iommu_resv_region *region, *next;
+	bool ret = false;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+	list_for_each_entry(region, &group_resv_regions, list) {
+		/*
+		 * The presence of any 'real' MSI regions should take
+		 * precedence over the software-managed one if the
+		 * IOMMU driver happens to advertise both types.
+		 */
+		if (region->type == IOMMU_RESV_MSI) {
+			ret = false;
+			break;
+		}
+
+		if (region->type == IOMMU_RESV_SW_MSI) {
+			*base = region->start;
+			ret = true;
+		}
+	}
+
+	list_for_each_entry_safe(region, next, &group_resv_regions, list)
+		kfree(region);
+
+	return ret;
+}
+
+static int uacce_set_iommu_domain(struct uacce_device *uacce)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+	struct device *dev = uacce->pdev;
+	bool resv_msi;
+	phys_addr_t resv_msi_base = 0;
+	int ret;
+
+	if (uacce->flags & UACCE_DEV_PASID)
+		return 0;
+
+	/* allocate and attach a unmanged domain */
+	domain = iommu_domain_alloc(uacce->pdev->bus);
+	if (!domain) {
+		dev_err(&uacce->dev, "cannot get domain for iommu\n");
+		return -ENODEV;
+	}
+
+	ret = iommu_attach_device(domain, uacce->pdev);
+	if (ret)
+		goto err_with_domain;
+
+	if (iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY))
+		uacce->prot |= IOMMU_CACHE;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		ret = -EINVAL;
+		goto err_with_domain;
+	}
+
+	resv_msi = uacce_iommu_has_sw_msi(group, &resv_msi_base);
+	iommu_group_put(group);
+
+	if (resv_msi) {
+		if (!irq_domain_check_msi_remap() &&
+		    !iommu_capable(dev->bus, IOMMU_CAP_INTR_REMAP)) {
+			dev_warn(dev, "No interrupt remapping support!");
+			ret = -EPERM;
+			goto err_with_domain;
+		}
+
+		ret = iommu_get_msi_cookie(domain, resv_msi_base);
+		if (ret)
+			goto err_with_domain;
+	}
+
+	return 0;
+
+err_with_domain:
+	iommu_domain_free(domain);
+	return ret;
+}
+
+static void uacce_unset_iommu_domain(struct uacce_device *uacce)
+{
+	struct iommu_domain *domain;
+
+	if (uacce->flags & UACCE_DEV_PASID)
+		return;
+
+	domain = iommu_get_domain_for_dev(uacce->pdev);
+	if (!domain) {
+		dev_err(&uacce->dev, "bug: no domain attached to device\n");
+		return;
+	}
+
+	iommu_detach_device(domain, uacce->pdev);
+	iommu_domain_free(domain);
+}
+
+/**
+ *	uacce_register - register an accelerator
+ *	@uacce: the accelerator structure
+ */
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface)
+{
+	int ret, i;
+	struct uacce_device *uacce;
+	unsigned int flags = interface->flags;
+
+	/* if dev support fault-from-dev, it should support pasid */
+	if ((flags & UACCE_DEV_FAULT_FROM_DEV) && !(flags & UACCE_DEV_PASID)) {
+		dev_warn(parent, "SVM/SAV device should support PASID\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	uacce = kzalloc(sizeof(struct uacce_device), GFP_KERNEL);
+	if (!uacce)
+		return ERR_PTR(-ENOMEM);
+
+#ifdef CONFIG_IOMMU_SVA
+	if (flags & UACCE_DEV_PASID) {
+		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
+		if (ret)
+			flags &= ~(UACCE_DEV_FAULT_FROM_DEV |
+				   UACCE_DEV_PASID);
+	}
+#endif
+	uacce->pdev = parent;
+	uacce->flags = flags;
+	uacce->ops = interface->ops;
+
+	for (i = 0; i < UACCE_QFRT_MAX; i++)
+		uacce->qf_pg_start[i] = UACCE_QFR_NA;
+
+	ret = uacce_set_iommu_domain(uacce);
+	if (ret)
+		goto err_free;
+
+	mutex_lock(&uacce_mutex);
+
+	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto err_with_lock;
+
+	uacce->cdev = cdev_alloc();
+	uacce->cdev->ops = &uacce_fops;
+	uacce->dev_id = ret;
+	uacce->cdev->owner = THIS_MODULE;
+	device_initialize(&uacce->dev);
+	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
+	uacce->dev.class = uacce_class;
+	uacce->dev.groups = uacce_dev_groups;
+	uacce->dev.parent = uacce->pdev;
+	uacce->dev.release = uacce_release;
+	dev_set_name(&uacce->dev, "%s-%d", interface->name, uacce->dev_id);
+	ret = cdev_device_add(uacce->cdev, &uacce->dev);
+	if (ret)
+		goto err_with_idr;
+
+	mutex_unlock(&uacce_mutex);
+
+	return uacce;
+
+err_with_idr:
+	idr_remove(&uacce_idr, uacce->dev_id);
+err_with_lock:
+	mutex_unlock(&uacce_mutex);
+	uacce_unset_iommu_domain(uacce);
+err_free:
+#ifdef CONFIG_IOMMU_SVA
+	if (flags & UACCE_DEV_PASID)
+		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
+#endif
+	kfree(uacce);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(uacce_register);
+
+/**
+ * uacce_unregister - unregisters a uacce
+ * @uacce: the accelerator to unregister
+ *
+ * Unregister an accelerator that wat previously successully registered with
+ * uacce_register().
+ */
+void uacce_unregister(struct uacce_device *uacce)
+{
+	mutex_lock(&uacce_mutex);
+
+#ifdef CONFIG_IOMMU_SVA
+	if (uacce->flags & UACCE_DEV_PASID)
+		iommu_dev_disable_feature(uacce->pdev, IOMMU_DEV_FEAT_SVA);
+#endif
+	uacce_unset_iommu_domain(uacce);
+	cdev_device_del(uacce->cdev, &uacce->dev);
+	idr_remove(&uacce_idr, uacce->dev_id);
+	put_device(&uacce->dev);
+
+	mutex_unlock(&uacce_mutex);
+}
+EXPORT_SYMBOL_GPL(uacce_unregister);
+
+static int __init uacce_init(void)
+{
+	int ret;
+
+	uacce_class = class_create(THIS_MODULE, UACCE_NAME);
+	if (IS_ERR(uacce_class)) {
+		ret = PTR_ERR(uacce_class);
+		goto err;
+	}
+
+	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
+	if (ret)
+		goto err_with_class;
+
+	return 0;
+
+err_with_class:
+	class_destroy(uacce_class);
+err:
+	return ret;
+}
+
+static __exit void uacce_exit(void)
+{
+	unregister_chrdev_region(uacce_devt, MINORMASK);
+	class_destroy(uacce_class);
+	idr_destroy(&uacce_idr);
+}
+
+subsys_initcall(uacce_init);
+module_exit(uacce_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hisilicon Tech. Co., Ltd.");
+MODULE_DESCRIPTION("Accelerator interface for Userland applications");
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
new file mode 100644
index 0000000..b63e9e2
--- /dev/null
+++ b/include/linux/uacce.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_UACCE_H
+#define _LINUX_UACCE_H
+
+#include <linux/cdev.h>
+#include <uapi/misc/uacce.h>
+
+#define UACCE_NAME		"uacce"
+
+struct uacce_queue;
+struct uacce_device;
+
+/* uacce mode of the driver */
+#define UACCE_MODE_NOUACCE	0 /* don't use uacce */
+#define UACCE_MODE_UACCE	1 /* use uacce exclusively */
+
+/* uacce queue file flag, requires different operation */
+#define UACCE_QFRF_MAP		BIT(0)	/* map to current queue */
+#define UACCE_QFRF_MMAP		BIT(1)	/* map to user space */
+#define UACCE_QFRF_KMAP		BIT(2)	/* map to kernel space */
+#define UACCE_QFRF_DMA		BIT(3)	/* use dma api for the region */
+#define UACCE_QFRF_SELFMT	BIT(4)	/* self maintained qfr */
+
+/**
+ * struct uacce_qfile_region - structure of queue file region
+ * @type: type of the qfr
+ * @iova: iova share between user and device space
+ * @pages: pages pointer of the qfr memory
+ * @nr_pages: page numbers of the qfr memory
+ * @prot: qfr protection flag
+ * @flags: flags of qfr
+ * @qs: list sharing the same region, for ss region
+ * @kaddr: kernel addr of the qfr
+ * @dma: dma address, if created by dma api
+ */
+struct uacce_qfile_region {
+	enum uacce_qfrt type;
+	unsigned long iova;
+	struct page **pages;
+	u32 nr_pages;
+	u32 prot;
+	u32 flags;
+	struct list_head qs;
+	void *kaddr;
+	dma_addr_t dma;
+};
+
+/**
+ * struct uacce_ops - uacce device operations
+ * @get_available_instances:  get available instances left of the device
+ * @get_queue: get a queue from the device
+ * @put_queue: free a queue to the device
+ * @start_queue: make the queue start work after get_queue
+ * @stop_queue: make the queue stop work before put_queue
+ * @is_q_updated: check whether the task is finished
+ * @mask_notify: mask the task irq of queue
+ * @mmap: mmap addresses of queue to user space
+ * @reset: reset the uacce device
+ * @reset_queue: reset the queue
+ * @ioctl: ioctl for user space users of the queue
+ */
+struct uacce_ops {
+	int (*get_available_instances)(struct uacce_device *uacce);
+	int (*get_queue)(struct uacce_device *uacce, unsigned long arg,
+			 struct uacce_queue *q);
+	void (*put_queue)(struct uacce_queue *q);
+	int (*start_queue)(struct uacce_queue *q);
+	void (*stop_queue)(struct uacce_queue *q);
+	int (*is_q_updated)(struct uacce_queue *q);
+	void (*mask_notify)(struct uacce_queue *q, int event_mask);
+	int (*mmap)(struct uacce_queue *q, struct vm_area_struct *vma,
+		    struct uacce_qfile_region *qfr);
+	int (*reset)(struct uacce_device *uacce);
+	int (*reset_queue)(struct uacce_queue *q);
+	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
+		      unsigned long arg);
+};
+
+/**
+ * struct uacce_interface
+ * @name: the uacce device name.  Will show up in sysfs
+ * @flags: uacce device attributes
+ * @ops: pointer to the struct uacce_ops
+ *
+ * This structure is used for the uacce_register()
+ */
+struct uacce_interface {
+	char name[32];
+	unsigned int flags;
+	struct uacce_ops *ops;
+};
+
+enum uacce_q_state {
+	UACCE_Q_INIT,
+	UACCE_Q_STARTED,
+	UACCE_Q_ZOMBIE,
+};
+
+/**
+ * struct uacce_queue
+ * @uacce: pointer to uacce
+ * @priv: private pointer
+ * @wait: wait queue head
+ * @pasid: pasid of the queue
+ * @handle: iommu_sva handle return from iommu_sva_bind_device
+ * @list: share list for qfr->qs
+ * @mm: current->mm
+ * @qfrs: pointer of qfr regions
+ */
+struct uacce_queue {
+	struct uacce_device *uacce;
+	void *priv;
+	wait_queue_head_t wait;
+	int pasid;
+	struct iommu_sva *handle;
+	struct list_head list;
+	struct mm_struct *mm;
+	struct uacce_qfile_region *qfrs[UACCE_QFRT_MAX];
+	enum uacce_q_state state;
+};
+
+/**
+ * struct uacce_device
+ * @algs: supported algorithms
+ * @api_ver: api version
+ * @qf_pg_start: page start of the queue file regions
+ * @ops: pointer to the struct uacce_ops
+ * @pdev: pointer to the parent device
+ * @is_vf: whether virtual function
+ * @flags: uacce attributes
+ * @dev_id: id of the uacce device
+ * @prot: uacce protection flag
+ * @cdev: cdev of the uacce
+ * @dev: dev of the uacce
+ * @priv: private pointer of the uacce
+ */
+struct uacce_device {
+	const char *algs;
+	const char *api_ver;
+	unsigned long qf_pg_start[UACCE_QFRT_MAX];
+	struct uacce_ops *ops;
+	struct device *pdev;
+	bool is_vf;
+	u32 flags;
+	u32 dev_id;
+	u32 prot;
+	struct cdev *cdev;
+	struct device dev;
+	void *priv;
+};
+
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface);
+void uacce_unregister(struct uacce_device *uacce);
+
+#endif /* _LINUX_UACCE_H */
diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
new file mode 100644
index 0000000..eb419f8
--- /dev/null
+++ b/include/uapi/misc/uacce.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _UAPIUUACCE_H
+#define _UAPIUUACCE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define UACCE_CMD_SHARE_SVAS	_IO('W', 0)
+#define UACCE_CMD_START		_IO('W', 1)
+#define UACCE_CMD_PUT_Q		_IO('W', 2)
+
+/**
+ * UACCE Device Attributes:
+ *
+ * SHARE_DOMAIN: no PASID, can shae sva only for one process and the kernel
+ * PASID: the device has IOMMU which support PASID setting
+ *	  can do share sva, mapped to dev per process
+ * FAULT_FROM_DEV: the device has IOMMU which can do page fault request
+ *		   no need for share sva, should be used with PASID
+ * SVA: full function device
+ */
+
+enum {
+	UACCE_DEV_SHARE_DOMAIN = 0x0,
+	UACCE_DEV_PASID = 0x1,
+	UACCE_DEV_FAULT_FROM_DEV = 0x2,
+	UACCE_DEV_SVA = UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV,
+};
+
+#define UACCE_QFR_NA ((unsigned long)-1)
+
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,	/* device mmio region */
+	UACCE_QFRT_DKO = 1,	/* device kernel-only */
+	UACCE_QFRT_DUS = 2,	/* device user share */
+	UACCE_QFRT_SS = 3,	/* static share memory */
+	UACCE_QFRT_MAX = 16,
+};
+
+#endif
-- 
2.7.4

