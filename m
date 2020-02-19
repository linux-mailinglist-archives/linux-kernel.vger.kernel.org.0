Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427E1163873
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 01:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBSAU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 19:20:56 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:42578 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727232AbgBSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1E5BDC009E;
        Wed, 19 Feb 2020 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582071650; bh=q0mOux0YTylyNFWh/bIJlHYc47b9ESSYqZ+vR2TUk7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=H7FNTi3brnMFzcl2CZgjZvXX+zexB5jsUvVlaPs0dtKiSGVc93kt8L/TGAy7+wdhP
         YUZr/d/DWQuDwgBj4L8F/YVI51/Frh4m3qk9N9MgVXL7851V361NucwJqQbr9wp+ie
         +jCFMTp0ImLlCIiJHcqPQM1jlXJrw8bbPaSA8t750XvO1vPhRQ9DIOixktTyNgDwyr
         lIcg8kAhXUbXtSK29WJl4Rpd5iIsuD1V6RlDcyNC6zHmrn8YU8YEMAvZ0ImHzfRDK4
         n/xLQEUXhNGIUskXM5HyxfxTD6/JMyRN0Cx59N0zpdiF6UKs/Pe+RukkO/UYnzJgPW
         5JWMWdJ37VDRQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5232DA007C;
        Wed, 19 Feb 2020 00:20:47 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 37D773D250;
        Wed, 19 Feb 2020 01:20:47 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        corbet@lwn.net, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Date:   Wed, 19 Feb 2020 01:20:42 +0100
Message-Id: <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds user mode support to I3C SDR transfers.

The module is based on i2c-dev.c with the follow features:
  - expose on /dev the i3c devices dynamically based on if they have
    a device driver bound.
  - Dynamically allocate the char device Major number.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Changes in v3:
  Use the xfer_lock to prevent device detach during ioctl call
  Expose i3cdev under /dev/bus/i3c/ folder like usb does
  Change NOTIFY_BOUND to NOTIFY_BIND, this allows the device detach occur
  before driver->probe
  Avoid use of IS_ERR_OR_NULL
  Use u64_to_user_ptr instead of (void __user *)(uintptr_t) cast
  Allocate k_xfer and data_ptrs at once to eliminate duble allocation check
  Pass i3cdev to dev->driver_data
  Make all minors available

Changes in v2:
  Use IDR api for minor numbering
  Modify ioctl struct
  Fix SPDX license

 drivers/i3c/Kconfig             |  15 ++
 drivers/i3c/Makefile            |   1 +
 drivers/i3c/i3cdev.c            | 429 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/i3c/i3cdev.h |  38 ++++
 4 files changed, 483 insertions(+)
 create mode 100644 drivers/i3c/i3cdev.c
 create mode 100644 include/uapi/linux/i3c/i3cdev.h

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a4415..0164276 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -20,5 +20,20 @@ menuconfig I3C
 	  will be called i3c.
 
 if I3C
+
+config I3CDEV
+	tristate "I3C device interface"
+	depends on I3C
+	help
+	  Say Y here to use i3c-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the I3C devices.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i3cdev.
+
+	  Note that this application programming interface is EXPERIMENTAL
+	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
+
 source "drivers/i3c/master/Kconfig"
 endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 11982ef..606d422 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 i3c-y				:= device.o master.o
 obj-$(CONFIG_I3C)		+= i3c.o
+obj-$(CONFIG_I3CDEV)		+= i3cdev.o
 obj-$(CONFIG_I3C)		+= master/
diff --git a/drivers/i3c/i3cdev.c b/drivers/i3c/i3cdev.c
new file mode 100644
index 0000000..1a6bd35
--- /dev/null
+++ b/drivers/i3c/i3cdev.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <soares@synopsys.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/i3c/i3cdev.h>
+
+#include "internals.h"
+
+struct i3cdev_data {
+	struct i3c_device *i3c;
+	struct device *dev;
+	struct mutex xfer_lock; /* prevent detach while transferring */
+	struct cdev cdev;
+	int id;
+};
+
+static DEFINE_IDA(i3cdev_ida);
+static dev_t i3cdev_number;
+#define I3C_MINORS (MINORMASK + 1)
+
+static struct i3cdev_data *get_free_i3cdev(struct i3c_device *i3c)
+{
+	struct i3cdev_data *i3cdev;
+	int id;
+
+	id = ida_simple_get(&i3cdev_ida, 0, I3C_MINORS, GFP_KERNEL);
+	if (id < 0) {
+		pr_err("i3cdev: no minor number available!\n");
+		return ERR_PTR(id);
+	}
+
+	i3cdev = kzalloc(sizeof(*i3cdev), GFP_KERNEL);
+	if (!i3cdev) {
+		ida_simple_remove(&i3cdev_ida, id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	i3cdev->i3c = i3c;
+	i3cdev->id = id;
+	i3cdev_set_drvdata(i3c, i3cdev);
+
+	return i3cdev;
+}
+
+static void put_i3cdev(struct i3cdev_data *i3cdev)
+{
+	i3cdev_set_drvdata(i3cdev->i3c, NULL);
+	kfree(i3cdev);
+}
+
+static ssize_t
+i3cdev_read(struct file *file, char __user *buf, size_t count, loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
+	struct i3c_priv_xfer xfers = {
+		.rnw = true,
+		.len = count,
+	};
+	int ret = -EACCES;
+	char *tmp;
+
+	mutex_lock(&i3cdev->xfer_lock);
+	if (i3c->dev.driver)
+		goto err_out;
+
+	tmp = kzalloc(count, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	xfers.data.in = tmp;
+
+	dev_dbg(&i3c->dev, "Reading %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	if (!ret)
+		ret = copy_to_user(buf, tmp, xfers.len) ? -EFAULT : xfers.len;
+
+	kfree(tmp);
+
+err_out:
+	mutex_unlock(&i3cdev->xfer_lock);
+	return ret;
+}
+
+static ssize_t
+i3cdev_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *f_pos)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
+	struct i3c_priv_xfer xfers = {
+		.rnw = false,
+		.len = count,
+	};
+	int ret = -EACCES;
+	char *tmp;
+
+	mutex_lock(&i3cdev->xfer_lock);
+	if (i3c->dev.driver)
+		goto err_out;
+
+	tmp = memdup_user(buf, count);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	xfers.data.out = tmp;
+
+	dev_dbg(&i3c->dev, "Writing %zu bytes.\n", count);
+
+	ret = i3c_device_do_priv_xfers(i3c, &xfers, 1);
+	kfree(tmp);
+
+err_out:
+	mutex_unlock(&i3cdev->xfer_lock);
+	return (!ret) ? count : ret;
+}
+
+static int
+i3cdev_do_priv_xfer(struct i3c_device *dev, struct i3c_ioc_priv_xfer *xfers,
+		    unsigned int nxfers)
+{
+	struct i3c_priv_xfer *k_xfers;
+	u8 **data_ptrs;
+	int i, ret = 0;
+
+	/* Since we have nxfers we may allocate k_xfer + *data_ptrs together */
+	k_xfers = kcalloc(nxfers, sizeof(*k_xfers) + sizeof(*data_ptrs),
+			  GFP_KERNEL);
+	if (!k_xfers)
+		return -ENOMEM;
+
+	/* set data_ptrs to be after nxfers * i3c_priv_xfer */
+	data_ptrs = (void *)k_xfers + (nxfers * sizeof(*k_xfers));
+
+	for (i = 0; i < nxfers; i++) {
+		data_ptrs[i] = memdup_user((const u8 __user *)
+					   (uintptr_t)xfers[i].data,
+					   xfers[i].len);
+		if (IS_ERR(data_ptrs[i])) {
+			ret = PTR_ERR(data_ptrs[i]);
+			break;
+		}
+
+		k_xfers[i].len = xfers[i].len;
+		if (xfers[i].rnw) {
+			k_xfers[i].rnw = true;
+			k_xfers[i].data.in = data_ptrs[i];
+		} else {
+			k_xfers[i].rnw = false;
+			k_xfers[i].data.out = data_ptrs[i];
+		}
+	}
+
+	if (ret < 0) {
+		i--;
+		goto err_free_mem;
+	}
+
+	ret = i3c_device_do_priv_xfers(dev, k_xfers, nxfers);
+	if (ret)
+		goto err_free_mem;
+
+	for (i = 0; i < nxfers; i++) {
+		if (xfers[i].rnw) {
+			if (copy_to_user(u64_to_user_ptr(xfers[i].data),
+					 data_ptrs[i], xfers[i].len))
+				ret = -EFAULT;
+		}
+	}
+
+err_free_mem:
+	for (; i >= 0; i--)
+		kfree(data_ptrs[i]);
+	kfree(k_xfers);
+	return ret;
+}
+
+static struct i3c_ioc_priv_xfer *
+i3cdev_get_ioc_priv_xfer(unsigned int cmd, struct i3c_ioc_priv_xfer *u_xfers,
+			 unsigned int *nxfers)
+{
+	u32 tmp = _IOC_SIZE(cmd);
+
+	if ((tmp % sizeof(struct i3c_ioc_priv_xfer)) != 0)
+		return ERR_PTR(-EINVAL);
+
+	*nxfers = tmp / sizeof(struct i3c_ioc_priv_xfer);
+	if (*nxfers == 0)
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(u_xfers, tmp);
+}
+
+static int
+i3cdev_ioc_priv_xfer(struct i3c_device *i3c, unsigned int cmd,
+		     struct i3c_ioc_priv_xfer *u_xfers)
+{
+	struct i3c_ioc_priv_xfer *k_xfers;
+	unsigned int nxfers;
+	int ret;
+
+	k_xfers = i3cdev_get_ioc_priv_xfer(cmd, u_xfers, &nxfers);
+	if (IS_ERR(k_xfers))
+		return PTR_ERR(k_xfers);
+
+	ret = i3cdev_do_priv_xfer(i3c, k_xfers, nxfers);
+
+	kfree(k_xfers);
+
+	return ret;
+}
+
+static long
+i3cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i3cdev_data *i3cdev = file->private_data;
+	struct i3c_device *i3c = i3cdev->i3c;
+	int ret = -EACCES;
+
+	dev_dbg(&i3c->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n", cmd, arg);
+
+	if (_IOC_TYPE(cmd) != I3C_DEV_IOC_MAGIC)
+		return -ENOTTY;
+
+	/* Use the xfer_lock to prevent device detach during ioctl call */
+	mutex_lock(&i3cdev->xfer_lock);
+	if (i3c->dev.driver)
+		goto err_no_dev;
+
+	/* Check command number and direction */
+	if (_IOC_NR(cmd) == _IOC_NR(I3C_IOC_PRIV_XFER(0)) &&
+	    _IOC_DIR(cmd) == (_IOC_READ | _IOC_WRITE))
+		ret = i3cdev_ioc_priv_xfer(i3c, cmd,
+					(struct i3c_ioc_priv_xfer __user *)arg);
+
+err_no_dev:
+	mutex_unlock(&i3cdev->xfer_lock);
+	return ret;
+}
+
+static int i3cdev_open(struct inode *inode, struct file *file)
+{
+	struct i3cdev_data *i3cdev = container_of(inode->i_cdev,
+						  struct i3cdev_data,
+						  cdev);
+	file->private_data = i3cdev;
+
+	return 0;
+}
+
+static int i3cdev_release(struct inode *inode, struct file *file)
+{
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations i3cdev_fops = {
+	.owner		= THIS_MODULE,
+	.read		= i3cdev_read,
+	.write		= i3cdev_write,
+	.unlocked_ioctl	= i3cdev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.open		= i3cdev_open,
+	.release	= i3cdev_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+static struct class *i3cdev_class;
+
+static int i3cdev_attach(struct device *dev, void *dummy)
+{
+	struct i3cdev_data *i3cdev;
+	struct i3c_device *i3c;
+	int res;
+
+	if (dev->type == &i3c_masterdev_type || dev->driver)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	/* Get a device */
+	i3cdev = get_free_i3cdev(i3c);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	mutex_init(&i3cdev->xfer_lock);
+	cdev_init(&i3cdev->cdev, &i3cdev_fops);
+	i3cdev->cdev.owner = THIS_MODULE;
+	res = cdev_add(&i3cdev->cdev,
+		       MKDEV(MAJOR(i3cdev_number), i3cdev->id), 1);
+	if (res)
+		goto error_cdev;
+
+	/* register this i3c device with the driver core */
+	i3cdev->dev = device_create(i3cdev_class, &i3c->dev,
+				    MKDEV(MAJOR(i3cdev_number), i3cdev->id),
+				    NULL, "bus!i3c!%s", dev_name(&i3c->dev));
+	if (IS_ERR(i3cdev->dev)) {
+		res = PTR_ERR(i3cdev->dev);
+		goto error;
+	}
+	pr_debug("i3cdev: I3C device [%s] registered as minor %d\n",
+		 dev_name(&i3c->dev), i3cdev->id);
+	return 0;
+
+error:
+	cdev_del(&i3cdev->cdev);
+error_cdev:
+	put_i3cdev(i3cdev);
+	return res;
+}
+
+static int i3cdev_detach(struct device *dev, void *dummy)
+{
+	struct i3cdev_data *i3cdev;
+	struct i3c_device *i3c;
+
+	if (dev->type == &i3c_masterdev_type)
+		return 0;
+
+	i3c = dev_to_i3cdev(dev);
+
+	i3cdev = i3cdev_get_drvdata(i3c);
+	if (!i3cdev)
+		return 0;
+
+	/* Prevent transfers while cdev removal */
+	mutex_lock(&i3cdev->xfer_lock);
+	cdev_del(&i3cdev->cdev);
+	device_destroy(i3cdev_class, MKDEV(MAJOR(i3cdev_number), i3cdev->id));
+	mutex_unlock(&i3cdev->xfer_lock);
+
+	ida_simple_remove(&i3cdev_ida, i3cdev->id);
+	put_i3cdev(i3cdev);
+
+	pr_debug("i3cdev: device [%s] unregistered\n", dev_name(&i3c->dev));
+
+	return 0;
+}
+
+static int i3cdev_notifier_call(struct notifier_block *nb,
+				unsigned long action,
+				void *data)
+{
+	struct device *dev = data;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		return i3cdev_attach(dev, NULL);
+	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_BIND_DRIVER:
+		return i3cdev_detach(dev, NULL);
+	}
+
+	return 0;
+}
+
+static struct notifier_block i3cdev_notifier = {
+	.notifier_call = i3cdev_notifier_call,
+};
+
+static int __init i3cdev_init(void)
+{
+	int res;
+
+	/* Dynamically request unused major number */
+	res = alloc_chrdev_region(&i3cdev_number, 0, I3C_MINORS, "i3c");
+	if (res)
+		goto out;
+
+	/* Create a classe to populate sysfs entries*/
+	i3cdev_class = class_create(THIS_MODULE, "i3cdev");
+	if (IS_ERR(i3cdev_class)) {
+		res = PTR_ERR(i3cdev_class);
+		goto out_unreg_chrdev;
+	}
+
+	/* Keep track of busses which have devices to add or remove later */
+	res = bus_register_notifier(&i3c_bus_type, &i3cdev_notifier);
+	if (res)
+		goto out_unreg_class;
+
+	/* Bind to already existing device without driver right away */
+	i3c_for_each_dev(NULL, i3cdev_attach);
+
+	return 0;
+
+out_unreg_class:
+	class_destroy(i3cdev_class);
+out_unreg_chrdev:
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+out:
+	pr_err("%s: Driver Initialisation failed\n", __FILE__);
+	return res;
+}
+
+static void __exit i3cdev_exit(void)
+{
+	bus_unregister_notifier(&i3c_bus_type, &i3cdev_notifier);
+	i3c_for_each_dev(NULL, i3cdev_detach);
+	class_destroy(i3cdev_class);
+	unregister_chrdev_region(i3cdev_number, I3C_MINORS);
+}
+
+MODULE_AUTHOR("Vitor Soares <soares@synopsys.com>");
+MODULE_DESCRIPTION("I3C /dev entries driver");
+MODULE_LICENSE("GPL");
+
+module_init(i3cdev_init);
+module_exit(i3cdev_exit);
diff --git a/include/uapi/linux/i3c/i3cdev.h b/include/uapi/linux/i3c/i3cdev.h
new file mode 100644
index 0000000..656a686
--- /dev/null
+++ b/include/uapi/linux/i3c/i3cdev.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#ifndef _UAPI_I3C_DEV_H_
+#define _UAPI_I3C_DEV_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* IOCTL commands */
+#define I3C_DEV_IOC_MAGIC	0x07
+
+/**
+ * struct i3c_ioc_priv_xfer - I3C SDR ioctl private transfer
+ * @data: Holds pointer to userspace buffer with transmit data.
+ * @len: Length of data buffer buffers, in bytes.
+ * @rnw: encodes the transfer direction. true for a read, false for a write
+ */
+struct i3c_ioc_priv_xfer {
+	__u64 data;
+	__u16 len;
+	__u8 rnw;
+	__u8 pad[5];
+};
+
+#define I3C_PRIV_XFER_SIZE(N)	\
+	((((sizeof(struct i3c_ioc_priv_xfer)) * (N)) < (1 << _IOC_SIZEBITS)) \
+	? ((sizeof(struct i3c_ioc_priv_xfer)) * (N)) : 0)
+
+#define I3C_IOC_PRIV_XFER(N)	\
+	_IOC(_IOC_READ|_IOC_WRITE, I3C_DEV_IOC_MAGIC, 30, I3C_PRIV_XFER_SIZE(N))
+
+#endif
-- 
2.7.4

