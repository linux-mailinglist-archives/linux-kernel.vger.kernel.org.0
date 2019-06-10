Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0D3BF61
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfFJWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 18:16:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390378AbfFJWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j+NRg+K9rfMiwlW0bYi4vNNt08WFCywGA4nYguu1B0U=; b=hjZqNyqdr1u43sSDisZ2XDo17m
        RlVo9LN9scl2OxGt/dwaDGkdB83y0zZDUSm52W0+dBgXU+wK1Lk/QjvThHqlo6TtKB6j561pq+1Ek
        qFo2fAwKH+2lB5+dELbqJuzBoGnB1WNOZVLTuxs9NQ0dpCipCQrYd00Vc67dfe4yibJfz5Bl92zy3
        YXl2c6SnHoMjqpAJ3wsTHchRvdLvjxjsDPAGWRXHA8R9YWtob/LeTvFSOlKhA+xjME9Dh7bdoFOQ2
        7ZElZq9Jnb2ZWxLgtIAqJKgfTmBtTaxEAwgkIlTjeRzRWUnCEDugA31drUsWn7Sf/4Dx+7D7RYrIg
        RuzPWyyQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSaz-0003Vu-7L; Mon, 10 Jun 2019 22:16:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] riscv: read hart ID from mhartid on boot
Date:   Tue, 11 Jun 2019 00:16:15 +0200
Message-Id: <20190610221621.10938-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610221621.10938-1-hch@lst.de>
References: <20190610221621.10938-1-hch@lst.de>
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
---
 arch/riscv/kernel/head.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index cb5691d82b0b..e05379fd8b64 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -25,6 +25,14 @@ ENTRY(_start)
 	/* Reset all registers except ra, a0,a1 */
 	call reset_regs
 
+#ifdef CONFIG_M_MODE
+	/*
+	 * The hartid in a0 is expected later on, and we have no firmware
+	 * to hand it to us.
+	 */
+	csrr a0, mhartid
+#endif
+
 	/* Load the global pointer */
 .option push
 .option norelax
-- 
2.20.1

