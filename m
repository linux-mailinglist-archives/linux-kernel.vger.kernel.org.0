Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD77E7110
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfJ1ML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 08:11:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388941AbfJ1MLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fSsBKmgdY1QjDFHoBUNLb7SjQL8aeF8LHQYOgo1Pa4I=; b=Bez+aHQoHK4jqH+tVVnzZGE4QX
        vJc4HF2pzu4wY6RaEOXN6OJl1YJ0ROKtr5bRtvGmRML7E6PEWEWdCxuBhZ+CRHuZs/Fgq1uFteRUu
        PS174gzf15BpU8NvYQV3YwN/8ocf8xS6dywg915XSt8DaabDp7uWpSPPruAofVtkCzo37tYWn2b9n
        4sZeV6RK49b09QrScILTq0DvBmo52Ex2ZAFxmbHB9yjXlen9CJsPeqX7LvOAupDfICXVt4gsig7Oh
        CXIsukV1oOiJGvrAQN+rlxWMiDAakVMdBJ1Dmywetzyj1/e/nNhN38yabhOvVFzEH6lmLAAn0YPGd
        IZ+9QCqQ==;
Received: from [2001:4bb8:18c:c7d:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP3rk-0007PC-Mn; Mon, 28 Oct 2019 12:11:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 12/12] riscv: disable the EFI PECOFF header for M-mode
Date:   Mon, 28 Oct 2019 13:10:43 +0100
Message-Id: <20191028121043.22934-13-hch@lst.de>
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

No point in bloating the kernel image with a bootloader header if
we run bare metal.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 84a6f0a4b120..9bca97ffb67a 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -16,6 +16,7 @@
 
 __INIT
 ENTRY(_start)
+#ifndef CONFIG_RISCV_M_MODE
 	/*
 	 * Image header expected by Linux boot-loaders. The image header data
 	 * structure is described in asm/image.h.
@@ -47,6 +48,7 @@ ENTRY(_start)
 
 .global _start_kernel
 _start_kernel:
+#endif /* CONFIG_RISCV_M_MODE */
 	/* Mask all interrupts */
 	csrw CSR_IE, zero
 	csrw CSR_IP, zero
-- 
2.20.1

