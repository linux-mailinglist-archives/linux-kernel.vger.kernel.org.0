Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D078E7107
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfJ1MLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 08:11:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388869AbfJ1MLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6VagoDFQgXNCA+UAJQ0E/1j0Ng3n2+jdyEXvkHZ2HZ8=; b=ucY8lKKD6GWPBKd71bQTaCGMJV
        NmfYWxK4apeC0QOYw5iAXiuVjrQtlAq7F8AXUe6cqGwFpvmyAUcgn4cbK3rI4acMXeRTw3LPV7HEH
        oWhT/dQgkEKF2U9ubme6elydUkFPWtAPYZlWUvtmOr5tbR7cFxCoYAkx8Z+QNsZ7chB8n4QsTfAHS
        A3DLPjRx0+q8KwXXcv4AlclQtoTFs3IlAsc11VAdiXdWhXGHZ3fD9vJCXALF8p6lK2H6RigK0T+f0
        AHcgrvGsQEP07Pv4gJuwV4IHm/JKLMiwIp59oL0pY+2vjxFq93sJ00VlIaamRz5ltm8Zw42ZxUN7h
        xoQM31Iw==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3rY-00074U-Tg; Mon, 28 Oct 2019 12:11:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 08/12] riscv: read the hart ID from mhartid on boot
Date:   Mon, 28 Oct 2019 13:10:39 +0100
Message-Id: <20191028121043.22934-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028121043.22934-1-hch@lst.de>
References: <20191028121043.22934-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

When in M-Mode, we can use the mhartid CSR to get the ID of the running
HART. Doing so, direct M-Mode boot without firmware is possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/csr.h | 1 +
 arch/riscv/kernel/head.S     | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 0ab642811028..318192c66fd8 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -99,6 +99,7 @@
 #define CSR_MCAUSE		0x342
 #define CSR_MTVAL		0x343
 #define CSR_MIP			0x344
+#define CSR_MHARTID		0xf14
 
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 5cfd2c582945..fc9973086946 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -50,6 +50,14 @@ _start_kernel:
 	csrw CSR_IE, zero
 	csrw CSR_IP, zero
 
+#ifdef CONFIG_RISCV_M_MODE
+	/*
+	 * The hartid in a0 is expected later on, and we have no firmware
+	 * to hand it to us.
+	 */
+	csrr a0, CSR_MHARTID
+#endif
+
 	/* Load the global pointer */
 .option push
 .option norelax
-- 
2.20.1

