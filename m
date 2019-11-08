Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2913DF4BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKHMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 07:35:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46753 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:35:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id 193so4437322pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1bALUHO3xpglOgvkfgJKBQqlzLjwrjC7IKM5e/eGJo=;
        b=KhMG6tzb92sGivmeo516LzvSMxFLvvHggC80suV3Vo2/NbprJb17equ8aOHCVf9PcY
         ilW7/4sTBvNiBI2pw+O1uNg6eMyLG6Y+iqtc7VIhr3W0nKLLkBI2XsxM6YV00pxg6/yr
         A8HJrMs+nQiuwn0jTqbQ87YRTyZqlotdl2XgyvWAcMr3f7TKPEJJpfRWF1uVOr6pTnx9
         +uScTHosDPdScWJUN3oHQePVdB8cDS+9mu9asJulKVxMLPRjeSMntC21Z4FHJ8wNH7fs
         M4tHys//oB7CCsRr2AESYShi0CkxPYnUuFUJdWMc0ObZA8IGWioIBJVk5ctBnADiGaNd
         DIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O1bALUHO3xpglOgvkfgJKBQqlzLjwrjC7IKM5e/eGJo=;
        b=l1A4JqCKvS7jpXg4vXIMWSbHGNQPu9Uv+/SvgkI3N1O34Xn0h+kGkW3S5mIIIZ3gat
         dbKXIdEZY6U0jdCJLyD9z6HyD54Xscz2Zm1Y6BSADlnEJcaWwSrU5bhNg2orBZPyMzos
         Pi2eAt92Ov9ZftcdcHwbjnv61oYhATSVk/gUEyqaNk6jaccx2muzG6awidk2Zb7h1IXK
         wr0HwXOt+Pwl2WSViX1FsDU0miD/GkOlgQwxtCHWL8DoGWxRWs7WviFgrAYDvrIE4gJT
         K3dzS+p4YhMOhodvP9XGdrurwFN3Aq8Pv/zB8b9F8uRyoBK4TQBzS16AHOUqB+sHiawX
         bKeQ==
X-Gm-Message-State: APjAAAXxk7jrezwjAaqScc6tUybPTboue77YtCpTxa51QFo9gw2MTywS
        N6TenUhtmyXTQCvv59m2Szz2kA==
X-Google-Smtp-Source: APXvYqwWE5PdITjfdVG+15rQNjhto9Dtq3eENXa2qMAi/RSDw6OOu6UWc2Al4eDjVkzIHDWDTe24Nw==
X-Received: by 2002:a62:5b83:: with SMTP id p125mr11833145pfb.237.1573216538968;
        Fri, 08 Nov 2019 04:35:38 -0800 (PST)
Received: from localhost.localdomain ([240e:362:48f:8f00:79bd:a8a7:1834:2d1a])
        by smtp.gmail.com with ESMTPSA id q34sm5430926pjb.15.2019.11.08.04.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 04:35:38 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, grant.likely@arm.com,
        jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v8 2/3] uacce: add uacce driver
Date:   Fri,  8 Nov 2019 20:34:27 +0800
Message-Id: <1573216468-10379-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573216468-10379-1-git-send-email-zhangfei.gao@linaro.org>
References: <1573216468-10379-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
provide Shared Virtual Addressing (SVA) between accelerators and processes.
So accelerator can access any data structure of the main cpu.
This differs from the data sharing between cpu and io device, which share
only data content rather than address.
Since unified address, hardware and user space of process can share the
same virtual address in the communication.

Uacce create a chrdev for every registration, the queue is allocated to
the process when the chrdev is opened. Then the process can access the
hardware resource by interact with the queue file. By mmap the queue
file space to user space, the process can directly put requests to the
hardware without syscall to the kernel space.

The IOMMU core only tracks mm<->device bonds at the moment, because it
only needs to handle IOTLB invalidation and PASID table entries. However
uacce needs a finer granularity since multiple queues from the same
device can be bound to an mm. When the mm exits, all bound queues must
be stopped so that the IOMMU can safely clear the PASID table entry and
reallocate the PASID.

An intermediate struct uacce_mm links uacce devices and queues.
Note that an mm may be bound to multiple devices but an uacce_mm
structure only ever belongs to a single device, because we don't need
anything more complex (if multiple devices are bound to one mm, then
we'll create one uacce_mm for each bond).

        uacce_device --+-- uacce_mm --+-- uacce_queue
                       |              '-- uacce_queue
                       |
                       '-- uacce_mm --+-- uacce_queue
                                      +-- uacce_queue
                                      '-- uacce_queue

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/ABI/testing/sysfs-driver-uacce |  53 +++
 drivers/misc/Kconfig                         |   1 +
 drivers/misc/Makefile                        |   1 +
 drivers/misc/uacce/Kconfig                   |  13 +
 drivers/misc/uacce/Makefile                  |   2 +
 drivers/misc/uacce/uacce.c                   | 634 +++++++++++++++++++++++++++
 include/linux/uacce.h                        | 155 +++++++
 include/uapi/misc/uacce/uacce.h              |  36 ++
 8 files changed, 895 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce/uacce.h

diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
new file mode 100644
index 0000000..20a6ada
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-uacce
@@ -0,0 +1,53 @@
+What:           /sys/class/uacce/<dev_name>/id
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Id of the device.
+
+What:           /sys/class/uacce/<dev_name>/api
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Api of the device, used by application to match the correct driver
+
+What:           /sys/class/uacce/<dev_name>/flags
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Attributes of the device, see UACCE_DEV_xxx flag defined in uacce.h
+
+What:           /sys/class/uacce/<dev_name>/available_instances
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Available instances left of the device
+
+What:           /sys/class/uacce/<dev_name>/algorithms
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Algorithms supported by this accelerator, separated by new line.
+
+What:           /sys/class/uacce/<dev_name>/region_mmio_size
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Size (bytes) of mmio region queue file
+
+What:           /sys/class/uacce/<dev_name>/region_dus_size
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Size (bytes) of dus region queue file
+
+What:           /sys/class/uacce/<dev_name>/numa_distance
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Distance of device node to cpu node
+
+What:           /sys/class/uacce/<dev_name>/node_id
+Date:           Nov 2019
+KernelVersion:  5.5
+Contact:        linux-accelerators@lists.ozlabs.org
+Description:    Id of the numa node
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c55b637..929feb0 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -481,4 +481,5 @@ source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
+source "drivers/misc/uacce/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d3..9abf292 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,4 +56,5 @@ obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/uacce/Kconfig b/drivers/misc/uacce/Kconfig
new file mode 100644
index 0000000..5e39b60
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
+	  include/uapi/misc/uacce/uacce.h
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
index 0000000..b66da58
--- /dev/null
+++ b/drivers/misc/uacce/uacce.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/compat.h>
+#include <linux/dma-iommu.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/uacce.h>
+
+static struct class *uacce_class;
+static dev_t uacce_devt;
+static DEFINE_MUTEX(uacce_mutex);
+static DEFINE_XARRAY_ALLOC(uacce_xa);
+
+static int uacce_start_queue(struct uacce_queue *q)
+{
+	int ret = 0;
+
+	mutex_lock(&uacce_mutex);
+
+	if (q->state != UACCE_Q_INIT) {
+		ret = -EINVAL;
+		goto out_with_lock;
+	}
+
+	if (q->uacce->ops->start_queue) {
+		ret = q->uacce->ops->start_queue(q);
+		if (ret < 0)
+			goto out_with_lock;
+	}
+
+	q->state = UACCE_Q_STARTED;
+
+out_with_lock:
+	mutex_unlock(&uacce_mutex);
+
+	return ret;
+}
+
+static int uacce_put_queue(struct uacce_queue *q)
+{
+	struct uacce_device *uacce = q->uacce;
+
+	mutex_lock(&uacce_mutex);
+
+	if (q->state == UACCE_Q_ZOMBIE)
+		goto out;
+
+	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
+		uacce->ops->stop_queue(q);
+
+	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
+	     uacce->ops->put_queue)
+		uacce->ops->put_queue(q);
+
+	q->state = UACCE_Q_ZOMBIE;
+out:
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
+	case UACCE_CMD_START_Q:
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
+static int uacce_sva_exit(struct device *dev, struct iommu_sva *handle,
+			  void *data)
+{
+	struct uacce_mm *uacce_mm = data;
+	struct uacce_queue *q;
+
+	/*
+	 * No new queue can be added concurrently because no caller can have a
+	 * reference to this mm. But there may be concurrent calls to
+	 * uacce_mm_put(), so we need the lock.
+	 */
+	mutex_lock(&uacce_mm->lock);
+	list_for_each_entry(q, &uacce_mm->queues, list)
+		uacce_put_queue(q);
+	uacce_mm->mm = NULL;
+	mutex_unlock(&uacce_mm->lock);
+
+	return 0;
+}
+
+static struct iommu_sva_ops uacce_sva_ops = {
+	.mm_exit = uacce_sva_exit,
+};
+
+static struct uacce_mm *uacce_mm_get(struct uacce_device *uacce,
+				     struct uacce_queue *q,
+				     struct mm_struct *mm)
+{
+	struct uacce_mm *uacce_mm = NULL;
+	struct iommu_sva *handle = NULL;
+	int ret;
+
+	lockdep_assert_held(&uacce->mm_lock);
+
+	list_for_each_entry(uacce_mm, &uacce->mm_list, list) {
+		if (uacce_mm->mm == mm) {
+			mutex_lock(&uacce_mm->lock);
+			list_add(&q->list, &uacce_mm->queues);
+			mutex_unlock(&uacce_mm->lock);
+			return uacce_mm;
+		}
+	}
+
+	uacce_mm = kzalloc(sizeof(*uacce_mm), GFP_KERNEL);
+	if (!uacce_mm)
+		return NULL;
+
+	if (uacce->flags & UACCE_DEV_SVA) {
+		/*
+		 * Safe to pass an incomplete uacce_mm, since mm_exit cannot
+		 * fire while we hold a reference to the mm.
+		 */
+		handle = iommu_sva_bind_device(uacce->parent, mm, uacce_mm);
+		if (IS_ERR(handle))
+			goto err_free;
+
+		ret = iommu_sva_set_ops(handle, &uacce_sva_ops);
+		if (ret)
+			goto err_unbind;
+
+		uacce_mm->pasid = iommu_sva_get_pasid(handle);
+		if (uacce_mm->pasid == IOMMU_PASID_INVALID)
+			goto err_unbind;
+	}
+
+	uacce_mm->mm = mm;
+	uacce_mm->handle = handle;
+	INIT_LIST_HEAD(&uacce_mm->queues);
+	mutex_init(&uacce_mm->lock);
+	list_add(&q->list, &uacce_mm->queues);
+	list_add(&uacce_mm->list, &uacce->mm_list);
+
+	return uacce_mm;
+
+err_unbind:
+	if (handle)
+		iommu_sva_unbind_device(handle);
+err_free:
+	kfree(uacce_mm);
+	return NULL;
+}
+
+static void uacce_mm_put(struct uacce_queue *q)
+{
+	struct uacce_mm *uacce_mm = q->uacce_mm;
+
+	lockdep_assert_held(&q->uacce->mm_lock);
+
+	mutex_lock(&uacce_mm->lock);
+	list_del(&q->list);
+	mutex_unlock(&uacce_mm->lock);
+
+	if (list_empty(&uacce_mm->queues)) {
+		if (uacce_mm->handle)
+			iommu_sva_unbind_device(uacce_mm->handle);
+		list_del(&uacce_mm->list);
+		kfree(uacce_mm);
+	}
+}
+
+static int uacce_fops_open(struct inode *inode, struct file *filep)
+{
+	struct uacce_mm *uacce_mm = NULL;
+	struct uacce_device *uacce;
+	struct uacce_queue *q;
+	int ret = 0;
+
+	uacce = xa_load(&uacce_xa, iminor(inode));
+	if (!uacce)
+		return -ENODEV;
+
+	if (!try_module_get(uacce->parent->driver->owner))
+		return -ENODEV;
+
+	q = kzalloc(sizeof(struct uacce_queue), GFP_KERNEL);
+	if (!q) {
+		ret = -ENOMEM;
+		goto out_with_module;
+	}
+
+	mutex_lock(&uacce->mm_lock);
+	uacce_mm = uacce_mm_get(uacce, q, current->mm);
+	mutex_unlock(&uacce->mm_lock);
+	if (!uacce_mm) {
+		ret = -ENOMEM;
+		goto out_with_mem;
+	}
+
+	q->uacce = uacce;
+	q->uacce_mm = uacce_mm;
+
+	if (uacce->ops->get_queue) {
+		ret = uacce->ops->get_queue(uacce, uacce_mm->pasid, q);
+		if (ret < 0)
+			goto out_with_mm;
+	}
+
+	init_waitqueue_head(&q->wait);
+	filep->private_data = q;
+	q->state = UACCE_Q_INIT;
+
+	return 0;
+
+out_with_mm:
+	mutex_lock(&uacce->mm_lock);
+	uacce_mm_put(q);
+	mutex_unlock(&uacce->mm_lock);
+out_with_mem:
+	kfree(q);
+out_with_module:
+	module_put(uacce->parent->driver->owner);
+	return ret;
+}
+
+static int uacce_fops_release(struct inode *inode, struct file *filep)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce_device *uacce = q->uacce;
+
+	uacce_put_queue(q);
+
+	mutex_lock(&uacce->mm_lock);
+	uacce_mm_put(q);
+	mutex_unlock(&uacce->mm_lock);
+
+	kfree(q);
+	module_put(uacce->parent->driver->owner);
+
+	return 0;
+}
+
+static void uacce_vma_close(struct vm_area_struct *vma)
+{
+	struct uacce_queue *q = vma->vm_private_data;
+	struct uacce_qfile_region *qfr = NULL;
+
+	if (vma->vm_pgoff < UACCE_MAX_REGION)
+		qfr = q->qfrs[vma->vm_pgoff];
+
+	kfree(qfr);
+}
+
+static const struct vm_operations_struct uacce_vm_ops = {
+	.close = uacce_vma_close,
+};
+
+static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct uacce_queue *q = filep->private_data;
+	struct uacce_device *uacce = q->uacce;
+	struct uacce_qfile_region *qfr;
+	enum uacce_qfrt type = UACCE_MAX_REGION;
+	int ret = 0;
+
+	if (vma->vm_pgoff < UACCE_MAX_REGION)
+		type = vma->vm_pgoff;
+	else
+		return -EINVAL;
+
+	qfr = kzalloc(sizeof(*qfr), GFP_KERNEL);
+	if (!qfr)
+		return -ENOMEM;
+
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
+	vma->vm_ops = &uacce_vm_ops;
+	vma->vm_private_data = q;
+	qfr->type = type;
+
+	mutex_lock(&uacce_mutex);
+
+	if (q->state != UACCE_Q_INIT && q->state != UACCE_Q_STARTED) {
+		ret = -EINVAL;
+		goto out_with_lock;
+	}
+
+	if (q->qfrs[type]) {
+		ret = -EEXIST;
+		goto out_with_lock;
+	}
+
+	switch (type) {
+	case UACCE_QFRT_MMIO:
+		if (!uacce->ops->mmap) {
+			ret = -EINVAL;
+			goto out_with_lock;
+		}
+
+		ret = uacce->ops->mmap(q, vma, qfr);
+		if (ret)
+			goto out_with_lock;
+
+		break;
+
+	case UACCE_QFRT_DUS:
+		if (uacce->flags & UACCE_DEV_SVA) {
+			if (!uacce->ops->mmap) {
+				ret = -EINVAL;
+				goto out_with_lock;
+			}
+
+			ret = uacce->ops->mmap(q, vma, qfr);
+			if (ret)
+				goto out_with_lock;
+
+		}
+		break;
+
+	default:
+		ret = -EINVAL;
+		goto out_with_lock;
+	}
+
+	q->qfrs[type] = qfr;
+	mutex_unlock(&uacce_mutex);
+
+	return ret;
+
+out_with_lock:
+	mutex_unlock(&uacce_mutex);
+	kfree(qfr);
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
+	distance = node_distance(smp_processor_id(), uacce->parent->numa_node);
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
+	node_id = dev_to_node(uacce->parent);
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
+	return sprintf(buf, "%s\n", uacce->algs);
+}
+
+static ssize_t region_mmio_size_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%lu\n",
+		       uacce->qf_pg_num[UACCE_QFRT_MMIO] << PAGE_SHIFT);
+}
+
+static ssize_t region_dus_size_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sprintf(buf, "%lu\n",
+		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
+}
+
+static DEVICE_ATTR_RO(id);
+static DEVICE_ATTR_RO(api);
+static DEVICE_ATTR_RO(numa_distance);
+static DEVICE_ATTR_RO(node_id);
+static DEVICE_ATTR_RO(flags);
+static DEVICE_ATTR_RO(available_instances);
+static DEVICE_ATTR_RO(algorithms);
+static DEVICE_ATTR_RO(region_mmio_size);
+static DEVICE_ATTR_RO(region_dus_size);
+
+static struct attribute *uacce_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_api.attr,
+	&dev_attr_numa_distance.attr,
+	&dev_attr_node_id.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_available_instances.attr,
+	&dev_attr_algorithms.attr,
+	&dev_attr_region_mmio_size.attr,
+	&dev_attr_region_dus_size.attr,
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
+/**
+ * uacce_register() - register an accelerator
+ * @parent: pointer of uacce parent device
+ * @interface: pointer of uacce_interface for register
+ *
+ * Return 0 if register succeeded, or an error.
+ * Need check returned negotiated uacce->flags
+ */
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface)
+{
+	unsigned int flags = interface->flags;
+	struct uacce_device *uacce;
+	int ret;
+
+	uacce = kzalloc(sizeof(struct uacce_device), GFP_KERNEL);
+	if (!uacce)
+		return ERR_PTR(-ENOMEM);
+
+	if (flags & UACCE_DEV_SVA) {
+		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
+		if (ret)
+			flags &= ~UACCE_DEV_SVA;
+	}
+
+	uacce->parent = parent;
+	uacce->flags = flags;
+	uacce->ops = interface->ops;
+
+	ret = xa_alloc(&uacce_xa, &uacce->dev_id, uacce, xa_limit_32b,
+		       GFP_KERNEL);
+	if (ret < 0)
+		goto err_with_uacce;
+
+	uacce->cdev = cdev_alloc();
+	if (!uacce->cdev) {
+		ret = -ENOMEM;
+		goto err_with_xa;
+	}
+
+	INIT_LIST_HEAD(&uacce->mm_list);
+	mutex_init(&uacce->mm_lock);
+	uacce->cdev->ops = &uacce_fops;
+	uacce->cdev->owner = THIS_MODULE;
+	device_initialize(&uacce->dev);
+	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
+	uacce->dev.class = uacce_class;
+	uacce->dev.groups = uacce_dev_groups;
+	uacce->dev.parent = uacce->parent;
+	uacce->dev.release = uacce_release;
+	dev_set_name(&uacce->dev, "%s-%d", interface->name, uacce->dev_id);
+	ret = cdev_device_add(uacce->cdev, &uacce->dev);
+	if (ret)
+		goto err_with_cdev;
+
+	return uacce;
+
+err_with_cdev:
+	cdev_del(uacce->cdev);
+err_with_xa:
+	xa_erase(&uacce_xa, uacce->dev_id);
+err_with_uacce:
+	if (flags & UACCE_DEV_SVA)
+		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	kfree(uacce);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(uacce_register);
+
+/**
+ * uacce_unregister() - unregisters an accelerator
+ * @uacce: the accelerator to unregister
+ */
+void uacce_unregister(struct uacce_device *uacce)
+{
+	struct uacce_mm *uacce_mm;
+	struct uacce_queue *q;
+
+	if (!uacce)
+		return;
+
+	/* ensure no open queue remains */
+	mutex_lock(&uacce->mm_lock);
+	list_for_each_entry(uacce_mm, &uacce->mm_list, list) {
+		/*
+		 * We don't take the uacce_mm->lock here. Since we hold the
+		 * device's mm_lock, no queue can be added to or removed from
+		 * this uacce_mm. We may run concurrently with mm_exit, but
+		 * uacce_put_queue() is serialized and iommu_sva_unbind_device()
+		 * waits for the lock that mm_exit is holding.
+		 */
+		list_for_each_entry(q, &uacce_mm->queues, list)
+			uacce_put_queue(q);
+
+		if (uacce->flags & UACCE_DEV_SVA) {
+			iommu_sva_unbind_device(uacce_mm->handle);
+			uacce_mm->handle = NULL;
+		}
+	}
+	mutex_unlock(&uacce->mm_lock);
+
+	/* disable sva now since no opened queues */
+	if (uacce->flags & UACCE_DEV_SVA)
+		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+
+	cdev_device_del(uacce->cdev, &uacce->dev);
+	xa_erase(&uacce_xa, uacce->dev_id);
+	put_device(&uacce->dev);
+}
+EXPORT_SYMBOL_GPL(uacce_unregister);
+
+static int __init uacce_init(void)
+{
+	int ret;
+
+	uacce_class = class_create(THIS_MODULE, UACCE_NAME);
+	if (IS_ERR(uacce_class))
+		return PTR_ERR(uacce_class);
+
+	ret = alloc_chrdev_region(&uacce_devt, 0, MINORMASK, UACCE_NAME);
+	if (ret)
+		class_destroy(uacce_class);
+
+	return ret;
+}
+
+static __exit void uacce_exit(void)
+{
+	unregister_chrdev_region(uacce_devt, MINORMASK);
+	class_destroy(uacce_class);
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
index 0000000..6f0a2db
--- /dev/null
+++ b/include/linux/uacce.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_UACCE_H
+#define _LINUX_UACCE_H
+
+#include <linux/cdev.h>
+#include <uapi/misc/uacce/uacce.h>
+
+#define UACCE_NAME		"uacce"
+#define UACCE_MAX_REGION	16
+#define UACCE_MAX_NAME_SIZE	64
+
+struct uacce_queue;
+struct uacce_device;
+
+/**
+ * struct uacce_qfile_region - structure of queue file region
+ * @type: type of the region
+ */
+struct uacce_qfile_region {
+	enum uacce_qfrt type;
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
+ * @mmap: mmap addresses of queue to user space
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
+	int (*mmap)(struct uacce_queue *q, struct vm_area_struct *vma,
+		    struct uacce_qfile_region *qfr);
+	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
+		      unsigned long arg);
+};
+
+/**
+ * struct uacce_interface - interface required for uacce_register()
+ * @name: the uacce device name.  Will show up in sysfs
+ * @flags: uacce device attributes
+ * @ops: pointer to the struct uacce_ops
+ */
+struct uacce_interface {
+	char name[UACCE_MAX_NAME_SIZE];
+	unsigned int flags;
+	const struct uacce_ops *ops;
+};
+
+enum uacce_q_state {
+	UACCE_Q_ZOMBIE = 0,
+	UACCE_Q_INIT,
+	UACCE_Q_STARTED,
+};
+
+/**
+ * struct uacce_queue
+ * @uacce: pointer to uacce
+ * @priv: private pointer
+ * @wait: wait queue head
+ * @list: index into uacce_mm
+ * @uacce_mm: the corresponding mm
+ * @qfrs: pointer of qfr regions
+ * @state: queue state machine
+ */
+struct uacce_queue {
+	struct uacce_device *uacce;
+	void *priv;
+	wait_queue_head_t wait;
+	struct list_head list;
+	struct uacce_mm *uacce_mm;
+	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
+	enum uacce_q_state state;
+};
+
+/**
+ * struct uacce_device
+ * @algs: supported algorithms
+ * @api_ver: api version
+ * @ops: pointer to the struct uacce_ops
+ * @qf_pg_num: page numbers of the queue file regions
+ * @parent: pointer to the parent device
+ * @is_vf: whether virtual function
+ * @flags: uacce attributes
+ * @dev_id: id of the uacce device
+ * @cdev: cdev of the uacce
+ * @dev: dev of the uacce
+ * @priv: private pointer of the uacce
+ * @mm_list: list head of uacce_mm->list
+ * @mm_lock: lock for mm_list
+ */
+struct uacce_device {
+	const char *algs;
+	const char *api_ver;
+	const struct uacce_ops *ops;
+	unsigned long qf_pg_num[UACCE_MAX_REGION];
+	struct device *parent;
+	bool is_vf;
+	u32 flags;
+	u32 dev_id;
+	struct cdev *cdev;
+	struct device dev;
+	void *priv;
+	struct list_head mm_list;
+	struct mutex mm_lock;
+};
+
+/*
+ * struct uacce_mm - keep track of queues bound to a process
+ * @list: index into uacce_device
+ * @queues: list of queues
+ * @mm: the mm struct
+ * @lock: protects the list of queues
+ * @pasid: pasid of the uacce_mm
+ * @handle: iommu_sva handle return from iommu_sva_bind_device
+ */
+struct uacce_mm {
+	struct list_head list;
+	struct list_head queues;
+	struct mm_struct *mm;
+	struct mutex lock;
+	int pasid;
+	struct iommu_sva *handle;
+};
+
+#if IS_ENABLED(CONFIG_UACCE)
+
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface);
+void uacce_unregister(struct uacce_device *uacce);
+
+#else /* CONFIG_UACCE */
+
+static inline
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void uacce_unregister(struct uacce_device *uacce) {}
+
+#endif /* CONFIG_UACCE */
+
+#endif /* _LINUX_UACCE_H */
diff --git a/include/uapi/misc/uacce/uacce.h b/include/uapi/misc/uacce/uacce.h
new file mode 100644
index 0000000..d253384
--- /dev/null
+++ b/include/uapi/misc/uacce/uacce.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPIUUACCE_H
+#define _UAPIUUACCE_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* UACCE_CMD_START_Q: Start queue */
+#define UACCE_CMD_START_Q	_IO('W', 0)
+
+/**
+ * UACCE_CMD_PUT_Q:
+ * User actively stop queue and free queue resource immediately
+ * Optimization method since close fd may delay
+ */
+#define UACCE_CMD_PUT_Q		_IO('W', 1)
+
+/**
+ * UACCE Device flags:
+ * UACCE_DEV_SVA: Shared Virtual Addresses
+ *		  Support PASID
+ *		  Support device page faults (PCI PRI or SMMU Stall)
+ */
+#define UACCE_DEV_SVA		BIT(0)
+
+/**
+ * enum uacce_qfrt: queue file region type
+ * @UACCE_QFRT_MMIO: device mmio region
+ * @UACCE_QFRT_DUS: device user share region
+ */
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,
+	UACCE_QFRT_DUS = 1,
+};
+
+#endif
-- 
2.7.4

