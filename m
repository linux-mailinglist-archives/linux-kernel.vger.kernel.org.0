Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F1AA6568
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfICJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 05:33:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfICJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UTFu87w+XEtxou+h9sB6RKxA59A9q/pV/jkzaJrvpcg=; b=fc5MP86CrSTKOzd3QkOriE8h4J
        YTzk8wtFdxcfgJr5m3fwj4QKfGj/CgNNnldYUl7l4vvhJOi3IR2eloh1YeeXLjvApaw9J9cCA6KU7
        x4EjITeVgN3gbFGJQ4iKrTZ/9cm+RdNss/OpTq2l05pRpYPfnEa5EbKSEzopoQjXdFIW6+rOkrpc+
        75DP1x8IGLx2HvhMpO84/Y6wuuUii5gIjxsdwA0hnyuFG6v7GWYIdS4uxmTIe79I52X6YxlvkB72Q
        PEhp7F25GUb6AOTa8xaSW255NzL+XnyWvYGJp9TEScZWgujVHK1hEIrlX6cUQlAl3uq8kWL9AO6nE
        GKwZGxrg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55Bt-0004zL-5m; Tue, 03 Sep 2019 09:33:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] riscv: disable the EFI PECOFF header for M-mode
Date:   Tue,  3 Sep 2019 11:32:39 +0200
Message-Id: <20190903093239.21278-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
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
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 102520e4bdc8..5a36c36bc823 100644
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
 	csrw CSR_XIE, zero
 	csrw CSR_XIP, zero
-- 
2.20.1

