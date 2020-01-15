Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02213C538
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgAOONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:13:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43640 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbgAOONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so8268875pga.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Src2nBsw9fEQNe6R1XRh63qOf6PvwHbP1eF/87qT/L8=;
        b=o6X/nqdFlkZP5IwKgGBT/IcaPAebM8FGb0PVIqEcdL2L8VmRMZh0Xrtfqf8LzRhcOX
         nHuQZj8X9SbuPZfeTRcBm1MScioFj409Xm3HqAUI9LYp5X2sB+nWaWN8Ivo8NfEc3vui
         a7a8fqJGWG3n2dsXwgNOC4Slz2B9/SACrUabygcmHTK90Rr/l5txCtH7UQkDF1fcFtos
         Zfy00UgZSMuR4p7IFOIqJhQD4j5idbWvdGAeagJC5TzNZvGizttwUhU9JQ+j+dM3TuFp
         dlp46BYaGJb6ojmMzXo9qYcL29nmp6uEJwC9Latw9iDd5ATDzVPN9HvxHDv94CMIKXm0
         ZjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Src2nBsw9fEQNe6R1XRh63qOf6PvwHbP1eF/87qT/L8=;
        b=Sz1ajLARAAoGudkpdpMsUaz8CsACekgQGqKJZB09n70g8o4YwhtxMk1TOKMyOjRwP0
         6wFGSmyufDzc+KupdrqQyMcRSZkAy5fpn45u2qekIoRe1+JggM5gNhRjyNFtHzCGxsiL
         /Dg8CsgqbXECzQNaZEZhrY/yM8P4kdE0brdkWWgcnUjYYnvYb1NSYDzeM7o3UhBHQlzg
         cHElEEqgvj6oYvk9EbSK1uOAZ0a/tPWpdBirleyHbBH7qU/rgXpp5IVBmCS6VQw9j7Qm
         qrl/5/ROx+0iymWIaJ2565PJgFGGlppnMauOBqAl71TnhK3uHDtEoM1Vtx9LxLk0iLTa
         C1/w==
X-Gm-Message-State: APjAAAXKQpWH0Rb+us3kAp4u6Zcf3tLCkfE2oksD3sRYtEq6NoqC893/
        TFf567x7fdeOfosPjUeykyaztQ==
X-Google-Smtp-Source: APXvYqyQSCXVq+hDlAm/NQfAOYPsWzy5xtoOWdx9TnQPGj1dt1+mhL4Lz5B23bXss89DIAAzgOOxpw==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr30849280pfq.14.1579097611989;
        Wed, 15 Jan 2020 06:13:31 -0800 (PST)
Received: from localhost.localdomain ([104.238.63.136])
        by smtp.gmail.com with ESMTPSA id a15sm22591980pfh.169.2020.01.15.06.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jan 2020 06:13:31 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
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
Subject: [PATCH v12 1/4] uacce: Add documents for uacce
Date:   Wed, 15 Jan 2020 22:12:45 +0800
Message-Id: <1579097568-17542-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

Uacce (Unified/User-space-access-intended Accelerator Framework) is
a kernel module targets to provide Shared Virtual Addressing (SVA)
between the accelerator and process.

This patch add document to explain how it works.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/misc-devices/uacce.rst | 176 +++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..1db412e
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of Uacce
+---------------------
+
+Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
+provide Shared Virtual Addressing (SVA) between accelerators and processes.
+So accelerator can access any data structure of the main cpu.
+This differs from the data sharing between cpu and io device, which share
+only data content rather than address.
+Because of the unified address, hardware and user space of process can
+share the same virtual address in the communication.
+Uacce takes the hardware accelerator as a heterogeneous processor, while
+IOMMU share the same CPU page tables and as a result the same translation
+from va to pa.
+
+::
+
+         __________________________       __________________________
+        |                          |     |                          |
+        |  User application (CPU)  |     |   Hardware Accelerator   |
+        |__________________________|     |__________________________|
+
+                     |                                 |
+                     | va                              | va
+                     V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+                     |                                 |
+                     |                                 |
+                     V pa                              V pa
+                 _______________________________________
+                |                                       |
+                |              Memory                   |
+                |_______________________________________|
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
+::
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
+----------------
+
+Uacce uses mmap and IOMMU to play the trick.
+
+Uacce creates a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used
+as the user handle of the queue.
+The accelerator device present itself as an Uacce object, which exports as
+a chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+The control path to the hardware is via file operation, while data path is
+via mmap space of the queue fd.
+
+The queue file address space:
+
+::
+
+   /**
+   * enum uacce_qfrt: qfrt type
+   * @UACCE_QFRT_MMIO: device mmio region
+   * @UACCE_QFRT_DUS: device user share region
+   */
+  enum uacce_qfrt {
+          UACCE_QFRT_MMIO = 0,
+          UACCE_QFRT_DUS = 1,
+  };
+
+All regions are optional and differ from device type to type.
+Each region can be mmapped only once, otherwise -EEXIST returns.
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
+----------------------
+
+The register API is defined in uacce.h.
+
+::
+
+  struct uacce_interface {
+    char name[UACCE_MAX_NAME_SIZE];
+    unsigned int flags;
+    const struct uacce_ops *ops;
+  };
+
+According to the IOMMU capability, uacce_interface flags can be:
+
+::
+
+  /**
+   * UACCE Device flags:
+   * UACCE_DEV_SVA: Shared Virtual Addresses
+   *              Support PASID
+   *              Support device page faults (PCI PRI or SMMU Stall)
+   */
+  #define UACCE_DEV_SVA               BIT(0)
+
+  struct uacce_device *uacce_alloc(struct device *parent,
+                                   struct uacce_interface *interface);
+  int uacce_register(struct uacce_device *uacce);
+  void uacce_remove(struct uacce_device *uacce);
+
+uacce_register results can be:
+
+a. If uacce module is not compiled, ERR_PTR(-ENODEV)
+
+b. Succeed with the desired flags
+
+c. Succeed with the negotiated flags, for example
+
+  uacce_interface.flags = UACCE_DEV_SVA but uacce->flags = ~UACCE_DEV_SVA
+
+  So user driver need check return value as well as the negotiated uacce->flags.
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

