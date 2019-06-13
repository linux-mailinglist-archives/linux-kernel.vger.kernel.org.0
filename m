Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289A04449B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392687AbfFMQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:37:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbfFMHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zrvKpljxrRXoMw3me5BR8AhqFJrBrP/RLB7FSk6JjTg=; b=sym0TmWILor5t14LMyRnRqvkg0
        EOM5U4fBRbAa0sCPMtQ8ondzb4A68BVEImqRwMpoyI7tlXAKyHWV9CS8ErDRu7VWWa44KABjarLVb
        VgqTswe7YRcNNyOeDe2IqZcFoRCNaiFQAuVnv1UlipmjTa3S4bZrtHUN4r4kgo0wdhn/oxozXDYay
        ZTZpyhoPoVnxMUEWo6bbYN5gOkyVrsZM/6ToihFSA/GsfP9iGX8eW2cC8KZGn4tTBMUz3KVZm6Wcx
        hl6UrDUinSCN0VsCzOGZZw7eXTSdocwgC0nh+6qPuC9EQgUJsuXWFFLvAuBkTi2uwXC7J8+CWk5NK
        SZYOIDZw==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbJs1-0004Zl-6O; Thu, 13 Jun 2019 07:10:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] riscv: add binfmt_flat support
Date:   Thu, 13 Jun 2019 09:09:03 +0200
Message-Id: <20190613070903.17214-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
References: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use the generic definitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig            | 1 +
 arch/riscv/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c4b12205632..2c19baa8d6c3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -17,6 +17,7 @@ config RISCV
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
+	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 5ee646619cc3..1efaeddf1e4b 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += extable.h
+generic-y += flat.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
-- 
2.20.1

