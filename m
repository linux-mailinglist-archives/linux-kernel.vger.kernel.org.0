Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4D15F9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 23:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBNWn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 17:43:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46672 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBNWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so10656636otb.13;
        Fri, 14 Feb 2020 14:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ST+PLmiGkSAozwHs99VdZ/cPWTCicua8kJ4SQHCu/G0=;
        b=jVdUIj8QKcnYvs9zwdkmvD6M+eIlc/zEDEC0iAx0oDknUIre9g9WpIr9+djbQo/WXr
         KwPJWksYnfY2UOYp4Dg46mmevIxY8XYfOtV51PR2yo6/NlLOdS3daj4afSIMO0rPK++f
         ufPFcdPJYt8bthMNkWTUJSe46tTRzFi3hD3JO1mBHnYxkwB0XtWbnj9AmFakgxwJCLQN
         ZBZqWVJOsbk+AHva1xsb/2JkPaY0WcG2kTiN3G2YysQcJQG6oJcov7S8v0vvRhLOILJG
         QTB1BxI0WamG6zRnsR7VUD10fxXBPvIxpEXAwaDAtilP7Jv6MnXYsSQtqFXMBgLN0PIs
         6Cmg==
X-Gm-Message-State: APjAAAUvOP/bphVoCVdWc0niz1CJU7eCspN/AKqk2URrdQ8sUPtQ89ji
        YUY+OdjJvZ+fh/LYsTRnbhBLaAc=
X-Google-Smtp-Source: APXvYqxxmXzYV2nzTRMz/xGJINwf9DGQxAgo8jid+3mqivFaYg1qMgHG0Ks4Cmkv5nA82os7cvfM0Q==
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr4296352otq.17.1581720206590;
        Fri, 14 Feb 2020 14:43:26 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:26 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/7] microblaze: Drop using struct of_pci_range.pci_space field
Date:   Fri, 14 Feb 2020 16:43:17 -0600
Message-Id: <20200214224322.20030-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the struct of_pci_range.flags field instead so we can remove
the pci_space field.

Just drop the debug prints as there's plenty of debug output in
drivers/of/address.c which can be enabled.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/pci/pci-common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 58cc4965bd3e..60a58c0015f2 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -433,10 +433,6 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	pr_debug("Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
 		/* Read next ranges element */
-		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
-				range.pci_space, range.pci_addr);
-		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
-					range.cpu_addr, range.size);
 
 		/* If we failed translation or got a zero-sized region
 		 * (some FW try to feed us with non sensical zero sized regions
@@ -486,7 +482,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			pr_info(" MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
 				range.cpu_addr, range.cpu_addr + range.size - 1,
 				range.pci_addr,
-				(range.pci_space & 0x40000000) ?
+				(range.flags & IORESOURCE_PREFETCH) ?
 				"Prefetch" : "");
 
 			/* We support only 3 memory ranges */
@@ -1121,4 +1117,3 @@ int early_find_capability(struct pci_controller *hose, int bus, int devfn,
 {
 	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
 }
-
-- 
2.20.1

