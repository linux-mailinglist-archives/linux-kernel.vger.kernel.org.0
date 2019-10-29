Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264B1E8074
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfJ2GlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 02:41:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44752 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbfJ2GlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 02:41:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so6826194pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KIkOGoEfD3sC7Lm1oZeLGLIevyyonnKw4CrTMTarj0A=;
        b=bIjXxvDeD2rWDSR6i985axak0TB8AlPFUcMAra8oKx8XhpAMLYgs03sHaaSUpqLxjJ
         GanF9IeQ9rcB7++fygVqlfUnt37XvO3LrlfTsw+0IgOkYY0Pa2fjK90vCRoJOVn1w+vK
         mQtOxJWYZctxQDXBOkOfslpDMwzIwsaydaFyUlhIZFLgSRqMbojBJ8PylPshovYPpXXk
         E7S4r9vuutLLOnm3PZ6H1kJiYGP+LrLZytPYO3UI17Itj1KFpChgA2MDBGHEZ6iYxRm7
         RGSeHUEWyoNCcuJXshHSghG8Ge1Uw8MAi2hWEwZZFwTdA1b+UebAeRjOt4/luSzAKrnn
         GssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KIkOGoEfD3sC7Lm1oZeLGLIevyyonnKw4CrTMTarj0A=;
        b=tKJi5467sK1Yo0XrhmJfydbtmUUinexEz3VE6lVZ26WcVBtP+940TKk3m1qFOl3r4V
         ZhUrTB9XzW4tYowVAqwRpzDmL+g9uBUSHjK07wxoSHFrDiunYznt9Pousjktyblgk4yc
         BWJn0sQBKlBPxS3SgZUWxRpFl6WqxGhgngEG/AxoZi0zZB2edFO7ZNGKNuTg8bz7abOO
         8QMHB8kHdv4v+A4gqxdOT5mgz7M6jqi3rPWsnEhl6yULqz9arArXmZIXPga3opIwXmjn
         HGK1Dim5c8srt9d88fEDvML+i0ZuA7cymQRatbIed+5GoZcpRsBG64q+Lrs1BLpl8SnO
         zN4w==
X-Gm-Message-State: APjAAAX4JD7MkEdi2kLf70hToFca07SvUYcisAJm991OjuUEd9ttH6pL
        qIGqn0/s8R69WBPKhlcb0aXRWg==
X-Google-Smtp-Source: APXvYqxNJ6Iu2A2JI6uBY0yAy/aq0E7dwPsiKMRw1Hi9k/q/qJ7hc/cmkRsr6ucYNgP6Ims5/HCwyw==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr2069000plt.75.1572331266831;
        Mon, 28 Oct 2019 23:41:06 -0700 (PDT)
Received: from localhost.localdomain ([240e:362:4dc:3a00:892e:70f7:f486:8f02])
        by smtp.gmail.com with ESMTPSA id e23sm13421834pgh.84.2019.10.28.23.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 23:41:06 -0700 (PDT)
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
Subject: [PATCH v7 1/3] uacce: Add documents for uacce
Date:   Tue, 29 Oct 2019 14:40:14 +0800
Message-Id: <1572331216-9503-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) is
a kernel module targets to provide Shared Virtual Addressing (SVA)
between the accelerator and process.

This patch add document to explain how it works.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/misc-devices/uacce.rst | 160 +++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..ecd5d8b
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,160 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of Uacce
+=========================
+
+Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
+provide Shared Virtual Addressing (SVA) between accelerators and processes.
+So accelerator can access any data structure of the main cpu.
+This differs from the data sharing between cpu and io device, which share
+data content rather than address.
+Because of the unified address, hardware and user space of process can
+share the same virtual address in the communication.
+Uacce takes the hardware accelerator as a heterogeneous processor, while
+IOMMU share the same CPU page tables and as a result the same translation
+from va to pa.
+
+	 __________________________       __________________________
+	|                          |     |                          |
+	|  User application (CPU)  |     |   Hardware Accelerator   |
+	|__________________________|     |__________________________|
+
+	             |                                 |
+	             | va                              | va
+	             V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+		     |                                 |
+	             |                                 |
+	             V pa                              V pa
+		 _______________________________________
+		|                                       |
+		|              Memory                   |
+		|_______________________________________|
+
+
+
+Architecture
+------------
+
+Uacce is the kernel module, taking charge of iommu and address sharing.
+The user drivers and libraries are called WarpDrive.
+
+The uacce device, built around the IOMMU SVA API, can access multiple
+address spaces, including the one without PASID.
+
+A virtual concept, queue, is used for the communication. It provides a
+FIFO-like interface. And it maintains a unified address space between the
+application and all involved hardware.
+
+                             ___________________                  ________________
+                            |                   |   user API     |                |
+                            | WarpDrive library | ------------>  |  user driver   |
+                            |___________________|                |________________|
+                                     |                                    |
+                                     |                                    |
+                                     | queue fd                           |
+                                     |                                    |
+                                     |                                    |
+                                     v                                    |
+     ___________________         _________                                |
+    |                   |       |         |                               | mmap memory
+    | Other framework   |       |  uacce  |                               | r/w interface
+    | crypto/nic/others |       |_________|                               |
+    |___________________|                                                 |
+             |                       |                                    |
+             | register              | register                           |
+             |                       |                                    |
+             |                       |                                    |
+             |                _________________       __________          |
+             |               |                 |     |          |         |
+              -------------  |  Device Driver  |     |  IOMMU   |         |
+                             |_________________|     |__________|         |
+                                     |                                    |
+                                     |                                    V
+                                     |                            ___________________
+                                     |                           |                   |
+                                     --------------------------  |  Device(Hardware) |
+                                                                 |___________________|
+
+
+How does it work
+================
+
+Uacce uses mmap and IOMMU to play the trick.
+
+Uacce create a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used
+as the user handle of the queue.
+The accelerator device present itself as an Uacce object, which exports as
+chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+The control path to the hardware is via file operation, while data path is
+via mmap space of the queue fd.
+
+The queue file address space:
+/**
+ * enum uacce_qfrt: qfrt type
+ * @UACCE_QFRT_MMIO: device mmio region
+ * @UACCE_QFRT_DUS: device user share region
+ */
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,
+	UACCE_QFRT_DUS = 1,
+};
+
+All regions are optional and differ from device type to type. The
+communication protocol is wrapped by the user driver.
+
+The device mmio region is mapped to the hardware mmio space. It is generally
+used for doorbell or other notification to the hardware. It is not fast enough
+as data channel.
+
+The device user share region is used for share data buffer between user process
+and device.
+
+
+The Uacce register API
+-----------------------
+The register API is defined in uacce.h.
+
+struct uacce_interface {
+	char name[UACCE_MAX_NAME_SIZE];
+	enum uacce_dev_flag flags;
+	struct uacce_ops *ops;
+};
+
+According to the IOMMU capability, uacce_interface flags can be:
+
+/**
+ * enum uacce_dev_flag: Device flags:
+ * @UACCE_DEV_SVA: Shared Virtual Addresses
+ *		   Support PASID
+ *		   Support device page faults (PCI PRI or SMMU Stall)
+ */
+enum uacce_dev_flag {
+	UACCE_DEV_SVA = BIT(0),
+};
+
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface);
+void uacce_unregister(struct uacce_device *uacce);
+
+uacce_register results can be:
+a. If uacce module is not compiled, ERR_PTR(-ENODEV)
+b. Succeed with the desired flags
+c. Succeed with the negotiated flags, for example
+   uacce_interface.flags = UACCE_DEV_SVA but uacce->flags = ~UACCE_DEV_SVA
+So user driver need check return value as well as the negotiated uacce->flags.
+
+
+The user driver
+---------------
+
+The queue file mmap space will need a user driver to wrap the communication
+protocol. Uacce provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+More details in Documentation/ABI/testing/sysfs-driver-uacce.
-- 
2.7.4

