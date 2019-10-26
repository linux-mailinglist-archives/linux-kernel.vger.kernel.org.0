Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E22E57CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 03:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfJZBdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 21:33:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfJZBdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:33:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30EA4AA6608D48243F4E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 09:33:30 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 26 Oct 2019
 09:33:21 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>
Subject: [PATCH] tools: PCI: Fix fd leakage
Date:   Fri, 25 Oct 2019 21:33:21 -0400
Message-ID: <20191026013321.59035-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should close fd before the return of run_test.

Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/pci/pcitest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index cb1e51fcc84e..32b7c6f9043d 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -129,6 +129,7 @@ static int run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
+	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
-- 
2.19.1

