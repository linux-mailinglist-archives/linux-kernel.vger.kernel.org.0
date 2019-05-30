Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD522EECB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 05:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbfE3Dtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 23:49:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387710AbfE3Dta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:49:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC38EA36FC591233E71A;
        Thu, 30 May 2019 11:49:27 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 30 May 2019 11:49:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v8 7/7] ia64: hide build option IOMMU_DEFAULT_PASSTHROUGH
Date:   Thu, 30 May 2019 11:48:31 +0800
Message-ID: <20190530034831.4184-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190530034831.4184-1-thunder.leizhen@huawei.com>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA mode PASSTHROUGH is not used on ia64.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f6c030433d38048..f7400e35628dce4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -89,7 +89,7 @@ choice
 
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "passthrough"
-	depends on !S390_IOMMU
+	depends on (!S390_IOMMU && !IA64)
 	help
 	  In this mode, the DMA access through IOMMU without any addresses
 	  translation. That means, the wrong or illegal DMA access can not
-- 
1.8.3


