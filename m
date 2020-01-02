Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F422712E18F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 02:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgABB6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 20:58:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbgABB6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:58:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33C092841182367BBE00;
        Thu,  2 Jan 2020 09:58:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 09:58:20 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <ysato@users.sourceforge.jp>, <dalias@libc.org>
CC:     <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] sh: remove call to memset after dma_alloc_coherent
Date:   Thu, 2 Jan 2020 09:54:30 +0800
Message-ID: <20200102015430.140729-1-chenzhou10@huawei.com>
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

Function dma_alloc_coherent use in buf already zeroes out memory,
so memset is not needed.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 3169a34..0de206c 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -57,8 +57,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.7.4

