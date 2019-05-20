Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5446D23060
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfETJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:30:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731543AbfETJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:30:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 164E21D770B4A287A969;
        Mon, 20 May 2019 17:30:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 May 2019 17:30:48 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH v2] hwtracing: stm: fix vfree() nonexistent vm_area
Date:   Mon, 20 May 2019 17:39:33 +0800
Message-ID: <20190520093933.29066-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_add() in stm_register_device() fails, stm_device_release()
is called by put_device() to free stm, free stm again on err_device
path will trigger following warning,

  Trying to vfree() nonexistent vm area (0000000054b5e7bc)
  WARNING: CPU: 0 PID: 6004 at mm/vmalloc.c:1595 __vunmap+0x72/0x480 mm/vmalloc.c:1594
  Kernel panic - not syncing: panic_on_warn set ...
  CPU: 0 PID: 6004 Comm: syz-executor.0 Tainted: G         C 5.1.0+ #28
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Call Trace:
   __vfree+0x2a/0x80 mm/vmalloc.c:1658
   _vfree+0x49/0x70 mm/vmalloc.c:1688
   stm_register_device+0x295/0x330 [stm_core]
   dummy_stm_init+0xfe/0x1e0 [dummy_stm]
   do_one_initcall+0xb9/0x3b5 init/main.c:914
   do_init_module+0xe0/0x330 kernel/module.c:3468
   load_module+0x38eb/0x4270 kernel/module.c:3819
   __do_sys_finit_module+0x162/0x190 kernel/module.c:3909
   do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Change error handling path and only free stm once if device_add() fails
to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/hwtracing/stm/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index e55b902560de..afb7999eb863 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -885,8 +885,10 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -ENOMEM;
 
 	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
-	if (stm->major < 0)
-		goto err_free;
+	if (stm->major < 0) {
+		vfree(stm);
+		return stm->major;
+	}
 
 	device_initialize(&stm->dev);
 	stm->dev.devt = MKDEV(stm->major, 0);
@@ -932,8 +934,6 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
-err_free:
-	vfree(stm);
 
 	return err;
 }
-- 
2.20.1

