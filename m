Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0B15716A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 10:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBJJGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 04:06:03 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59296 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbgBJJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:06:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tpb9F9X_1581325530;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0Tpb9F9X_1581325530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Feb 2020 17:05:31 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, zhabin@linux.alibaba.com,
        jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
Subject: [PATCH v2 0/5] virtio mmio specification enhancement
Date:   Mon, 10 Feb 2020 17:05:16 +0800
Message-Id: <cover.1581305609.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cloud native environment, we need a lightweight and secure system. It
should benefit from the speed of containers and the security of VM, which
is classified as secure containers. The traditional solution of cloud VM
is Qemu. In fact we don't need to pay for the legacy devices. Currently,
more userspace VMMs, e.g. Qemu, Firecracker, Cloud Hypervisor and Alibaba
Cloud VMM which is called Dragonball, began to pay attention to a
lightweight solution.

The lightweight VMM is suitable to cloud native infrastructure which is
designed for creating secure sandbox to address the requirements of
multi-tenant. Meanwhile, with faster startup time and lower memory
overhead, it makes possible to launch thousands of microVMs on the same
machine. This VMM minimizes the emulation devices and uses virtio-mmio to
get a more lightweight transport layer. The virtio-mmio devices have less
code than virtio-pci, which can decrease boot time and increase deploy
density by customizing kernel such as setting pci=off. From another point
of view, the minimal device can reduce the attack surface.

We have compared the number of files and the lines of code between
virtio-mmio and virio-pci.

				Virtio-PCI	    Virtio-MMIO	
	number of files(Linux)	    161			1
	lines of code(Linux)	    78237		538
	number of files(Qemu)	    24			1
	lines of code(Qemu)	    8952		421

But the current standard virtio-mmio spec has some limitations which is
only support legacy interrupt and will cause performance penalties.

To address such limitation, we proposed to update virtio-mmio spec with
two new feature bits to support MSI interrupt and enhancing notification
mechanism[1], which can achieve the same performance as virtio-pci devices
with only around 600 lines of code.

Here are the performance gain of MSI interrupt in virtio-mmio. Each case is
repeated three times.

        netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024

                Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
        trans/s     9536        6939            9500
        trans/s     9734        7029            9749
        trans/s     9894        7095            9318

With the virtio spec proposal[1], other VMMs (e.g. Qemu) can also make use
of the new features to get a enhancing performance.

[1] https://lkml.org/lkml/2020/1/21/31

Change Log:
v1->v2
* Change version update to feature bit
* Add mask/unmask support
* Add two MSI sharing/non-sharing modes
* Create generic irq domain for all architectures

Liu Jiang (5):
  virtio-mmio: add notify feature for per-queue
  virtio-mmio: refactor common functionality
  virtio-mmio: create a generic MSI irq domain
  virtio-mmio: add MSI interrupt feature support
  x86: virtio-mmio: support virtio-mmio with MSI for x86

 arch/x86/kernel/apic/msi.c          |  11 +-
 drivers/base/platform-msi.c         |   4 +-
 drivers/virtio/Kconfig              |   9 +
 drivers/virtio/virtio_mmio.c        | 351 ++++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_mmio_common.h |  39 ++++
 drivers/virtio/virtio_mmio_msi.h    | 175 ++++++++++++++++++
 include/linux/msi.h                 |   1 +
 include/uapi/linux/virtio_config.h  |  13 +-
 include/uapi/linux/virtio_mmio.h    |  31 ++++
 9 files changed, 596 insertions(+), 38 deletions(-)
 create mode 100644 drivers/virtio/virtio_mmio_common.h
 create mode 100644 drivers/virtio/virtio_mmio_msi.h

-- 
1.8.3.1

