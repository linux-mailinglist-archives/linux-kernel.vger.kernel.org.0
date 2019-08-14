Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F98CFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfHNJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:34:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39159 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:34:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so3666308pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LA9G0O8Qg6353EinN8VOzW44Yfjks5KMSdb5d3hZdg=;
        b=upLOHo8Yo6a+qvxiCt/IFOzXpzMngN+TQCMewYWOmVwL1ly3dHpvAWGeJ77AwvUfDv
         LDTtX1050zcl3oNDXg4gWhOAzTv/6SOdgALZqYmKaaOs95uVnLNNCGeWmJMmCpv3K/jP
         WzU0JzA2y71ctm62V4Waxm3ohUfa3Rc09V95FVwvQwXGQfyMDXlb2RTsSZ1F/SZYCL8J
         bPJxb5O/i68m33OEFnRHMrS0RkIVZvYaA1hQCyOdk5jB3Vai5jvumYvH/XEl8OQzDIph
         t3EDzGV2RqpRnTbpRhZik56+xCtGOzHUnzQqy+zX4BzDo0pMMg2aESe3B48J0PiBAAxS
         nPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+LA9G0O8Qg6353EinN8VOzW44Yfjks5KMSdb5d3hZdg=;
        b=jkiaQ6iFEe5uEYP1di8j2mtCoxIV8IeXvM/HvVEgLsecKb7Jm2XmYAFKvtQiX/itL9
         sDaTTiKlHFyRNOdVGm33Ug+7h0fHcqXzZcHB3rhAgmKbQLRDDoRt+FxY9QloC038kiK4
         L8AJowgkwJPKPD71GBD7jQHbr5lkoC3ZrZSTZd8bOTil50gVRpA3Lv4RtzQWjUtJrdaj
         b2VqcZwlaL2801p+z5pKpQcDOCHdIN0s7VE3BHXqf/NJ4wzw2HPIsyG45ah1lWX1JAbG
         eddtlCDHO32OV0PGAOMSdZbCe3+/7ZnkoOZ+/YNQeiO3etoRZ9rMRV3+bTHN/ZY7dJPT
         wbXg==
X-Gm-Message-State: APjAAAXDjPa0kbRxRh+y3CuL+NYAbC7xeZtYOq70ekNelug6mIozwb9U
        nfggXiMlLGQDL4JVuypJUfpe4w==
X-Google-Smtp-Source: APXvYqwvx2bW4be3CW520+uK9oRAFwTBHYubWlv24/R3USxAufLTri6Gdqy+zZrqg516sgoyz1NoyQ==
X-Received: by 2002:a17:902:40e:: with SMTP id 14mr32509915ple.323.1565775281538;
        Wed, 14 Aug 2019 02:34:41 -0700 (PDT)
Received: from localhost.localdomain ([193.187.117.228])
        by smtp.gmail.com with ESMTPSA id v12sm3419815pjk.13.2019.08.14.02.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 02:34:41 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/2] uacce: Add documents for WarpDrive/uacce
Date:   Wed, 14 Aug 2019 17:34:24 +0800
Message-Id: <1565775265-21212-2-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

WarpDrive is a general accelerator framework for the user application to
access the hardware without going through the kernel in data path.

The kernel component to provide kernel facility to driver for expose the
user interface is called uacce. It a short name for
"Unified/User-space-access-intended Accelerator Framework".

This patch add document to explain how it works.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 Documentation/misc-devices/warpdrive.rst | 351 +++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100644 Documentation/misc-devices/warpdrive.rst

diff --git a/Documentation/misc-devices/warpdrive.rst b/Documentation/misc-devices/warpdrive.rst
new file mode 100644
index 0000000..14e5939
--- /dev/null
+++ b/Documentation/misc-devices/warpdrive.rst
@@ -0,0 +1,351 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Introduction of WarpDrive
+=========================
+
+*WarpDrive* is a general accelerator framework for the user application to
+communicate with the hardware without going through the kernel in data path.
+
+It can be used as a quick channel for accelerators, network adaptors or
+other hardware for application in user space.
+
+It may also make some exist solution simpler.  E.g.  you can reuse most of the
+*netdev* driver in kernel and just share some ring buffer to the user space
+driver for *DPDK* or *ODP*. Or you can combine the RSA accelerator
+with the *netdev* in the user space as a https reverse proxy, etc.
+
+*WarpDrive* takes the hardware accelerator as a heterogeneous processor which
+can share particular load from the CPU:
+
+	 __________________________       __________________________
+	|                          |     |                          |
+	|  User application (CPU)  |     |   Hardware Accelerator   |
+	|__________________________|     |__________________________|
+
+	             |                                 |
+	             |                                 |
+	             V                                 V
+                 __________                        __________
+                |          |                      |          |
+                |   MMU    |                      |  IOMMU   |
+                |__________|                      |__________|
+		      \                               /
+	               \                             /
+	                \                           /
+			 __________________________
+			|                          |
+			|          Memory          |
+			|__________________________|
+
+
+
+Architecture
+------------
+
+*WarpDrive* includes general user libraries, kernel management modules
+and drivers for the hardware. In kernel, the management module
+is called *uacce*, meaning "Unified/User-space-access-intended
+Accelerator Framework".
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
+The accelerator device present itself as a "uacce" object, which exports as
+chrdev to the user space. The user application communicates with the
+hardware by ioctl (as control path) or share memory (as data path).
+
+
+How does it work
+================
+
+*WarpDrive* uses *mmap* and *IOMMU* to play the trick.
+
+*Uacce* create a chrdev for every device registered to it. New queue is
+created when user application open the chrdev. The file descriptor is used as
+the user handle of the queue.
+
+The control path to the hardware is via file operation, while data path is via
+mmap space of the queue fd.
+
+The queue file address space:
+
+enum uacce_qfrt {
+	UACCE_QFRT_MMIO = 0,	/* device mmio region */
+	UACCE_QFRT_DKO,		/* device kernel-only region */
+	UACCE_QFRT_DUS,		/* device user share region */
+	UACCE_QFRT_SS,		/* static shared memory (for non-sva devices) */
+	UACCE_QFRT_MAX,
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
+        int wd_request_queue(struct wd_queue *q);
+        void wd_release_queue(struct wd_queue *q);
+        int wd_send(struct wd_queue *q, void *req);
+        int wd_recv(struct wd_queue *q, void **req);
+        int wd_recv_sync(struct wd_queue *q, void **req);
+        void wd_flush(struct wd_queue *q);
+
+wd_recv_sync() is a wrapper to its non-sync version. It will trap into
+kernel and wait until the queue become available.
+
+If the queue do not support SVA/SVM. The following helper functions
+can be used to create Static Virtual Share Memory: ::
+
+        void *wd_reserve_memory(struct wd_queue *q, size_t size);
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
+protocol. *UACCE* provides some attributes in sysfs for the user driver to
+match the right accelerator accordingly.
+
+The *UACCE* device attribute is under the following directory:
+
+/sys/class/uacce/<dev-name>/attrs
+
+The following attributes are supported:
+
+id (ro)
+        N. Id of the device. The chrdev of this uacce is /dev/uaN
+api (ro)
+	api of the device, match with driver
+flags (ro)
+        Attributes of the device, see UACCE_DEV_xxx flag defined in uacce.h
+available_instances (ro)
+        available instances left of the device
+algorithms (ro)
+        algorithms supported by this accelerator
+qfrs_offset (ro)
+       qfrs_offset of the device
+numa_distance (ro)
+	distance of device node to cpu node
+node_id (ro)
+	id of the numa node
+
+
+The uacce register API
+-----------------------
+The *uacce* register API is defined in uacce.h. If the hardware support SVM/SVA,
+The driver need only the following API functions: ::
+
+        int uacce_register(uacce);
+        void uacce_unregister(uacce);
+        void uacce_wake_up(q);
+
+*uacce_wake_up* is used to notify the process who epoll() on the queue file.
+
+According to the IOMMU capability, *uacce* categories the devices as below:
+
+UACCE_DEV_NOIOMMU
+        The device has no IOMMU. The user process cannot use VA on the hardware
+        This mode is not recommended.
+
+UACCE_DEV_SVA (UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV)
+        The device has IOMMU which can share the same page table with user
+        process
+
+UACCE_DEV_SHARE_DOMAIN
+        This is used for device which need QFR_KO.
+
+
+The Memory Sharing Model
+------------------------
+The perfect form of a uacce device is to support SVM/SVA. We built this upon
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
+*Uacce* will create an unmanaged iommu_domain for the device. So it can be
+bound to multiple processes. In this case, the device cannot share the user
+page table directly. The user process must map the Static Share Queue File
+Region to create the connection. The *Uacce* kernel module will allocate
+physical memory to the region for both the device and the user process.
+
+If the device does not support UACCE_DEV_PASID either. There is no way for
+*uacce* to support multiple process. Every *Uacce* allow only one process at
+the same time. In this case, DMA API cannot be used in this device. If the
+device driver need to share memory with the device, it should use QFRT_KO
+queue file region instead. This region is mmaped from the user space but valid
+only for kernel.
+
+The device can also be declared as UACCE_DEV_NOIOMMU. It can be used when the
+device has no iommu support or the iommu is set in pass through mode.  In this
+case, the driver should map address to device by itself with DMA API. The
+ioctl(UACCE_CMD_GET_SS_DMA) can be used to get the physical address, though it
+is an untrusted and kernel-tainted behavior.
+
+We suggest the driver use uacce_mode module parameter to choose the working
+mode of the device. It can be:
+
+UACCE_MODE_NOUACCE (0)
+        Do not register to uacce. In this mode, the driver can register to
+        other kernel framework, such as crypto
+
+UACCE_MODE_UACCE (1)
+        Register to uacce. In this mode, the driver register to uacce. It can
+        register to other kernel framework according to whether it supports
+        PASID.
+
+UACCE_MODE_NOIOMMU
+        Register to uacce and assume there is no IOMMU or IOMMU in
+        pass-through mode. In this case, DMA API is available, so it can also
+        register to other kernel framework.
+
+        In this case, mmap operations except for QRFT_SS will be passed
+        through to the uacce->ops->mmap() call back.
+
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
+This is a reason why *WarpDrive* does not adopt the mode used in *VFIO* and
+*InfiniBand*.  Both solutions can set any user pointer for hardware sharing.
+But they cannot support fork when the dma is in process. Or the
+"Copy-On-Write" procedure will make the parent process lost its physical
+pages.
+
+
+Difference to the VFIO and IB framework
+---------------------------------------
+The essential function of WarpDrive is to let the device access the user
+address directly. There are many device drivers doing the same in the kernel.
+And both VFIO and IB can provide similar function in framework level.
+
+But WarpDrive has a different goal: "share address space". It is
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
+assumption which is unnecessary to WarpDrive. They may hurt each other if we
+try to merge them together.
+
+VFIO manages resource of a hardware as a "virtual device". If a device need to
+serve a separated application. It must isolate the resource as separate
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

