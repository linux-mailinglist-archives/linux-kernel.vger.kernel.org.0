Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637654636D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:54:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfFNPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:54:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 544C0B8A76344D1F0A32;
        Fri, 14 Jun 2019 23:54:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:54:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <puwen@hygon.cn>,
        <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/amd_nb: Make hygon_nb_misc_ids static
Date:   Fri, 14 Jun 2019 23:54:41 +0800
Message-ID: <20190614155441.22076-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

arch/x86/kernel/amd_nb.c:74:28: warning:
 symbol 'hygon_nb_misc_ids' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/kernel/amd_nb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cc51275..922e8fd 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -71,7 +71,7 @@ static const struct pci_device_id hygon_root_ids[] = {
 	{}
 };
 
-const struct pci_device_id hygon_nb_misc_ids[] = {
+static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.7.4


