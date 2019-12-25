Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF61812A7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 12:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLYLpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 06:45:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYLpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 06:45:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E255562D16940305A7BB;
        Wed, 25 Dec 2019 19:45:12 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 19:45:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/jump_label: Fix old-style declaration
Date:   Wed, 25 Dec 2019 19:45:00 +0800
Message-ID: <20191225114500.7712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc warning:

arch/x86/kernel/jump_label.c:61:1: warning:
 inline is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 9c4498e..5ba8477 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -58,7 +58,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type,
 	return code;
 }
 
-static void inline __jump_label_transform(struct jump_entry *entry,
+static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-- 
2.7.4


