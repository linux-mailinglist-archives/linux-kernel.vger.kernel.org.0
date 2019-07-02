Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E75D5D05E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 09:17:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfGBNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:17:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9459D9F5B332EABA387F;
        Tue,  2 Jul 2019 21:17:51 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:17:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <robh@kernel.org>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <allison@lohutok.net>, <groug@kaod.org>,
        <shilpa.bhat@linux.vnet.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/powernv: Make some sysbols static
Date:   Tue, 2 Jul 2019 21:17:33 +0800
Message-ID: <20190702131733.44100-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

arch/powerpc/platforms/powernv/opal-psr.c:20:1:
 warning: symbol 'psr_mutex' was not declared. Should it be static?
arch/powerpc/platforms/powernv/opal-psr.c:27:3:
 warning: symbol 'psr_attrs' was not declared. Should it be static?
arch/powerpc/platforms/powernv/opal-powercap.c:20:1:
 warning: symbol 'powercap_mutex' was not declared. Should it be static?
arch/powerpc/platforms/powernv/opal-sensor-groups.c:20:1:
 warning: symbol 'sg_mutex' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/powernv/opal-powercap.c      | 2 +-
 arch/powerpc/platforms/powernv/opal-psr.c           | 4 ++--
 arch/powerpc/platforms/powernv/opal-sensor-groups.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-powercap.c b/arch/powerpc/platforms/powernv/opal-powercap.c
index dc599e7..c16d44f 100644
--- a/arch/powerpc/platforms/powernv/opal-powercap.c
+++ b/arch/powerpc/platforms/powernv/opal-powercap.c
@@ -13,7 +13,7 @@
 
 #include <asm/opal.h>
 
-DEFINE_MUTEX(powercap_mutex);
+static DEFINE_MUTEX(powercap_mutex);
 
 static struct kobject *powercap_kobj;
 
diff --git a/arch/powerpc/platforms/powernv/opal-psr.c b/arch/powerpc/platforms/powernv/opal-psr.c
index b6ccb30..69d7e75 100644
--- a/arch/powerpc/platforms/powernv/opal-psr.c
+++ b/arch/powerpc/platforms/powernv/opal-psr.c
@@ -13,11 +13,11 @@
 
 #include <asm/opal.h>
 
-DEFINE_MUTEX(psr_mutex);
+static DEFINE_MUTEX(psr_mutex);
 
 static struct kobject *psr_kobj;
 
-struct psr_attr {
+static struct psr_attr {
 	u32 handle;
 	struct kobj_attribute attr;
 } *psr_attrs;
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 31f13c1..f8ae1fb 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -13,7 +13,7 @@
 
 #include <asm/opal.h>
 
-DEFINE_MUTEX(sg_mutex);
+static DEFINE_MUTEX(sg_mutex);
 
 static struct kobject *sg_kobj;
 
-- 
2.7.4


