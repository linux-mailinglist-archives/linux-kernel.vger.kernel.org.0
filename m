Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD511581E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 05:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEGDmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 23:42:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbfEGDmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:42:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 74D60BC3975760A175A1;
        Tue,  7 May 2019 11:42:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 7 May 2019 11:42:07 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>
CC:     <horms@verge.net.au>, <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH 4/4] kdump: update Documentation about crashkernel on arm64
Date:   Tue, 7 May 2019 11:50:58 +0800
Message-ID: <20190507035058.63992-5-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507035058.63992-1-chenzhou10@huawei.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support crashkernel=X,[high,low] on arm64, update the
Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 268b10a..03a08aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -705,7 +705,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, x86_64] select a region under 4G first, and
+			[KNL, x86_64, arm64] select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/kdump/kdump.txt for further details.
@@ -718,14 +718,14 @@
 			Documentation/kdump/kdump.txt for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, x86_64] range could be above 4G. Allow kernel
+			[KNL, x86_64, arm64] range could be above 4G. Allow kernel
 			to allocate physical memory region from top, so could
 			be above 4G if system have more than 4G ram installed.
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, x86_64] range under 4G. When crashkernel=X,high
+			[KNL, x86_64, arm64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
-- 
2.7.4

