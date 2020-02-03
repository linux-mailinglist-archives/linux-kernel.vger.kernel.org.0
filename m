Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0C15121E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCVxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 16:53:42 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:36957 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBCVxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:53:42 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a8992644;
        Mon, 3 Feb 2020 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=Ex4nOF/GtbLLELsAhbDd852gL
        jE=; b=PYCHYPKJtwvfYSOm5DF3eh1afYT+fxIWeveDkH1NomWBBMk8MgmkkcZoo
        vwBLvNm7XBwXhQRpn0Zw3oHNWOF52O/bWeymKhx6/51Y2uyoloUUoJBnNsxU/cGz
        ADyuxNqmnyIvRi3qnHst/xIxNWGAwSMS6LBGWVa54nVGDwYf6jh+DZn1oJfaNK+K
        S26Vqcxq4pIXNOyW2IL3NLPqbbYh/8to/RHkCCsH3Yyhm2WRTDzeb1KWa61+X7wl
        XgBx6ybbp0rjBgkDcgl0M9EckWWqirkQ4Dzf285rrQ9uha5jVop28ounJoV/FyEx
        FvAhgGOEBmZ0f9GlJ9veAgWg9bB+Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1b4d9316 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 3 Feb 2020 21:52:57 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, bhelgaas@google.com, x86@kernel.org,
        hch@lst.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2] x86/PCI: ensure to_pci_sysdata usage is available to !CONFIG_PCI
Date:   Mon,  3 Feb 2020 22:53:06 +0100
Message-Id: <20200203215306.172000-1-Jason@zx2c4.com>
In-Reply-To: <20200203200942.GA130652@google.com>
References: <20200203200942.GA130652@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the helper to_pci_sysdata was added inside of the CONFIG_PCI
guard, but it is used from inside of a CONFIG_NUMA guard, which does not
require CONFIG_PCI. This breaks builds on !CONFIG_PCI machines. This
commit makes that function available in all configurations.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: aad6aa0cd674 ("x86/PCI: Add to_pci_sysdata() helper")
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 40ac1330adb2..7ccb338507e3 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -33,13 +33,13 @@ extern int pci_routeirq;
 extern int noioapicquirk;
 extern int noioapicreroute;
 
-#ifdef CONFIG_PCI
-
 static inline struct pci_sysdata *to_pci_sysdata(const struct pci_bus *bus)
 {
 	return bus->sysdata;
 }
 
+#ifdef CONFIG_PCI
+
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
-- 
2.25.0

