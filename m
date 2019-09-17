Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0DB48DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404667AbfIQIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:10:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37234 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIQIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:10:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so1585272pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx0LVlGpRTRJ2DfT0wJH9xBNU5sStzHBUsn2JpxYeEY=;
        b=Gi9vs3pksW2OFbonFyh/kusMOOflBQa4VAascBFlRqv6OL0Uet/EFU9j2KWHFf+XjC
         roDkXrKE+2421ZgH4xVGQmWlXSNsrVf5o8sW+PKHy+10t3U8/HBUgzE9ABIyYB1DGeZI
         +Rvv/dRqoEsM/v5Vy7vDDGf9CPri481xNb0MuW8aSlokDxJG9vfYdMTkn6Pjez1MQA/t
         IfHXJP2Qa+HGf7ZDmrlVKdHvk5vr4vNWrZqCeFJMo/4jPA2ySNq3X3XegrT2mahYbwlj
         b0hQsvXW9GOVoOlBWOKP1HitqMnYGwL77J1xR5cDw/VNxL2IRLM0H0Dh9ypOcrfdY6lI
         YTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx0LVlGpRTRJ2DfT0wJH9xBNU5sStzHBUsn2JpxYeEY=;
        b=l5JqKDRqWJNRztSBbH8cUJnjz/H/JJL71lfvI3v61VBJ+IniCiO6whR+O8M3G75wg/
         DLBPpBkCKkFq1aa3dQFkIFywqT4DtZcQHSGIIsl+NDG1dOZf++BEmQytIeMaDWafxaQ2
         UDbxPpdGdE1204Ugx6bIYifAAE09aoN2AkOlDOYVXeLwsgzLfpWJu+dRYusGn51DZiVj
         GQL4qtXwrZKb1HFiu4onpoGJ5s4VGgspAy8jevs29/zOQ7wsk5HJ8/Skh6bxcpXSpOXy
         ozw5co269amhqZ7YXEUmHf8mXp85iln+rGGWoTKt3rq1DNy50TivPW/O2bIDB4VTT8Xm
         Cy1w==
X-Gm-Message-State: APjAAAXkfWQN87R19FnQBy2o3oAmCaaUCo4gqI6B3Sw60KDqbWvELMiu
        NiQB1rJOlLjsIYNkis9PEvJmz0AAz1/NyQ==
X-Google-Smtp-Source: APXvYqxadsJUxYw28CdU1FHvmhF3MAOVGRYlyddV+Zd4Mo2oaF/X2zlqCkY71LgFiOF9IFDRZjuFaA==
X-Received: by 2002:a17:90a:7308:: with SMTP id m8mr3663908pjk.87.1568707824536;
        Tue, 17 Sep 2019 01:10:24 -0700 (PDT)
Received: from localhost.localdomain ([45.41.132.67])
        by smtp.gmail.com with ESMTPSA id ep10sm6076773pjb.2.2019.09.17.01.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 01:10:24 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 1/2] uacce: Add documents for uacce
Date:   Tue, 17 Sep 2019 16:10:05 +0800
Message-Id: <1568707806-14492-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568707806-14492-1-git-send-email-zhangfei.gao@linaro.org>
References: <1568707806-14492-1-git-send-email-zhangfei.gao@linaro.org>
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
 Documentation/misc-devices/uacce.rst | 308 +++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)
 create mode 100644 Documentation/misc-devices/uacce.rst

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
new file mode 100644
index 0000000..4fd356e
--- /dev/null
+++ b/Documentation/misc-devices/uacce.rst
@@ -0,0 +1,308 @@
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
+
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,	/* device mmio region */
+	UACCE_QFRT_DKO = 1,	/* device kernel-only region */
+	UACCE_QFRT_DUS = 2,	/* device user share region */
+	UACCE_QFRT_SS = 3,	/* static shared memory (for non-sva devices) */
+	UACCE_QFRT_MAX = 16,
+};
+
+All regions are optional and differ from device type to type. The
+communication protocol is wrapped by the user driver.
+
+The device mmio region is mapped to the hardware mmio space. It is generally
+used for doorbell or other notification to the hardware. It is not fast enough
+as data channel.
+
+The device kernel-only region is necessary only if the device IOMMU has no
+PASID support or it cannot send kernel-only address request. In this case, if
+kernel need to share memory with the device, kernel has to share iova address
+space with the user process via mmap, to prevent iova conflict.
+
+The device user share region is used for share data buffer between user process
+and device. It can be merged into other regions. But a separated region can help
+on device state management. For example, the device can be started when this
+region is mapped.
+
+The static share virtual memory region is used for share data buffer with the
+device and can be shared among queues / devices.
+Its size is set according to the application requirement.
+
+
+The user API
+------------
+
+We adopt a polling style interface in the user space: ::
+
+	int wd_request_queue(struct wd_queue *q);
+	void wd_release_queue(struct wd_queue *q);
+	int wd_send(struct wd_queue *q, void *req);
+	int wd_recv(struct wd_queue *q, void **req);
+	int wd_recv_sync(struct wd_queue *q, void **req);
+	void wd_flush(struct wd_queue *q);
+
+wd_recv_sync() is a wrapper to its non-sync version. It will trap into
+kernel and wait until the queue become available.
+
+If the queue do not support SVA/SVM. The following helper functions
+can be used to create Static Virtual Share Memory: ::
+
+	void *wd_reserve_memory(struct wd_queue *q, size_t size);
+	int wd_share_reserved_memory(struct wd_queue *q,
+				     struct wd_queue *target_q);
+
+The user API is not mandatory. It is simply a suggestion and hint what the
+kernel interface is supposed to be.
+
+
+The user driver
+---------------
+
+The queue file mmap space will need a user driver to wrap the communication
+protocol. Uacce provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+More details in Documentation/ABI/testing/sysfs-driver-uacce.
+
+
+The Uacce register API
+-----------------------
+The register API is defined in uacce.h.
+
+struct uacce_interface {
+	char name[32];
+	unsigned int flags;
+	struct uacce_ops *ops;
+};
+
+struct uacce_device *uacce_register(struct device *parent,
+				    struct uacce_interface *interface);
+void uacce_unregister(struct uacce_device *uacce);
+
+
+According to the IOMMU capability, Uacce categories the devices as below:
+
+UACCE_DEV_SVA (UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV)
+	The device has IOMMU which can share the same page table with user
+	process
+
+UACCE_DEV_SHARE_DOMAIN
+	This is used for device which does not support pasid.
+
+
+The Memory Sharing Model
+------------------------
+The perfect form of a Uacce device is to support SVM/SVA. We built this upon
+Jean Philippe Brucker's SVA patches. [1]
+
+If the hardware support SVA, the user process's page table is shared to the
+opened queue. So the device can access any address in the process address
+space. And it can raise a page fault if the physical page is not available
+yet. It can also access the address in the kernel space, which is referred by
+another page table particular to the kernel. Most of IOMMU implementation can
+handle this by a tag on the address request of the device. For example, ARM
+SMMU uses SSV bit to indicate that the address request is for kernel or user
+space.
+
+The device_attr UACCE_DEV_SVA is used to indicate this capability of the
+device. It is a combination of UACCE_DEV_FAULT_FROM_DEV and UACCE_DEV_PASID.
+
+If the device does not support UACCE_DEV_FAULT_FROM_DEV but UACCE_DEV_PASID.
+Uacce will create an unmanaged iommu_domain for the device. So it can be
+bound to multiple processes. In this case, the device cannot share the user
+page table directly. The user process must map the Static Share Queue File
+Region to create the connection. The Uacce kernel module will allocate
+physical memory to the region for both the device and the user process.
+
+If the device does not support UACCE_DEV_PASID either. There is no way for
+Uacce to support multiple process. Every Uacce allow only one process at
+the same time. In this case, DMA API cannot be used in this device. If the
+device driver need to share memory with the device, it should use QFRT_DKO
+queue file region instead. This region is mmaped from the user space but
+valid only for kernel.
+
+We suggest the driver use uacce_mode module parameter to choose the working
+mode of the device. It can be:
+
+UACCE_MODE_NOUACCE (0)
+	Do not register to uacce. In this mode, the driver can register to
+	other kernel framework, such as crypto
+
+UACCE_MODE_UACCE (1)
+	Register to uacce. In this mode, the driver register to uacce. It can
+	register to other kernel framework according to whether it supports
+	PASID.
+
+
+The Folk Scenario
+=================
+For a process with allocated queues and shared memory, what happen if it forks
+a child?
+
+The fd of the queue will be duplicated on folk, so the child can send request
+to the same queue as its parent. But the requests which is sent from processes
+except for the one who opens the queue will be blocked.
+
+It is recommended to add O_CLOEXEC to the queue file.
+
+The queue mmap space has a VM_DONTCOPY in its VMA. So the child will lose all
+those VMAs.
+
+This is a reason why Uacce does not adopt the mode used in VFIO and
+InfiniBand.  Both solutions can set any user pointer for hardware sharing.
+But they cannot support fork when the dma is in process. Or the
+"Copy-On-Write" procedure will make the parent process lost its physical
+pages.
+
+
+Difference to the VFIO and IB framework
+---------------------------------------
+The essential function of Uacce is to let the device access the user
+address directly. There are many device drivers doing the same in the kernel.
+And both VFIO and IB can provide similar function in framework level.
+
+But Uacce has a different goal: "share address space". It is
+not taken the request to the accelerator as an enclosure data structure. It
+takes the accelerator as another thread of the same process. So the
+accelerator can refer to any address used by the process.
+
+Both VFIO and IB are taken this as "memory sharing", not "address sharing".
+They care more on sharing the block of memory. But if there is an address
+stored in the block and referring to another memory region. The address may
+not be valid.
+
+By adding more constraints to the VFIO and IB framework, in some sense, we may
+achieve a similar goal. But we gave it up finally. Both VFIO and IB have extra
+assumption which is unnecessary to Uacce. They may hurt each other if we
+try to merge them together.
+
+VFIO manages resource of a hardware as a "virtual device". If a device need to
+serve a separated application. It must isolate the resource as a separate
+virtual device.  And the life cycle of the application and virtual device are
+unnecessary unrelated. And most concepts, such as bus, driver, probe and
+so on, to make it as a "device" is unnecessary either. And the logic added to
+VFIO to make address sharing do no help on "creating a virtual device".
+
+IB creates a "verbs" standard for sharing memory region to another remote
+entity.  Most of these verbs are to make memory region between entities to be
+synchronized.  This is not what accelerator need. Accelerator is in the same
+memory system with the CPU. It refers to the same memory system among CPU and
+devices. So the local memory terms/verbs are good enough for it. Extra "verbs"
+are not necessary. And its queue (like queue pair in IB) is the communication
+channel direct to the accelerator hardware. There is nothing about memory
+itself.
+
+Further, both VFIO and IB use the "pin" (get_user_page) way to lock local
+memory in place.  This is flexible. But it can cause other problems. For
+example, if the user process fork a child process. The COW procedure may make
+the parent process lost its pages which are sharing with the device. These may
+be fixed in the future. But is not going to be easy. (There is a discussion
+about this on Linux Plumbers Conference 2018 [2])
+
+So we choose to build the solution directly on top of IOMMU interface. IOMMU
+is the essential way for device and process to share their page mapping from
+the hardware perspective. It will be safe to create a software solution on
+this assumption.  Uacce manages the IOMMU interface for the accelerator
+device, so the device driver can export some of the resources to the user
+space. Uacce than can make sure the device and the process have the same
+address space.
+
+
+References
+==========
+.. [1] http://jpbrucker.net/sva/
+.. [2] https://lwn.net/Articles/774411/
-- 
2.7.4

