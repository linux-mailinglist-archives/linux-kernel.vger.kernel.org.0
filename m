Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE80D14E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfJIRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 13:07:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41823 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfJIRHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:07:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so1342339plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fa9xrD4T1rxzQNwYuOjdLGG0r9pM+goY6z40NA+UpNk=;
        b=eWSMm4RGsYvvraPfWPNbhEvXx67CRd+v1lzqeVnY4XCqgS3cNk+xkxmVVBvM4XQYg0
         rXBiQuhNKFbx+5xo+tJc8EWRV8qgU3eFQTerVRsnfsf5Z1TOnpHsEaABH2VpNcy8WiAh
         RSfds7USbSSZTFSezm6bh4LLU2pODq7gxz1yAcPtl0O3CATiThpWHCsL/Sm0gKKWXtH/
         aieAhKj4ZyFoIaHM+l5aGuYQMKHeqH9YF5km1RnzXa47MKTp4uD16JLKwF6MDKLwu0NF
         AlLlKdRoyeINr0rXk+pQcOCZaO2LPWHKB5cqGgx4OPYp7EfXS3IDpHhV9SFY+henXQ/T
         c0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fa9xrD4T1rxzQNwYuOjdLGG0r9pM+goY6z40NA+UpNk=;
        b=ogAq7JeYFTg9fpTevoq+pLoq7FdoCnfg6gGgVCOTwKvicBkfA7dxJGy+W8y2yIjdjM
         TgyRSqDa8V1Ecn9PgGdrB1BNbwZb17lYIpMmemadPFAOMwBBoWbKzhQ2FKgVYHFgMMG2
         TzguZeoidGP6c+LCh7IWNv0FWcqJk7rxEHcEYHGXhIP7EhRrl+sQotq/WKKqtar44zOq
         Dz3ROjoeZr4QH00mSG8YPnSvPdMC+mx/IpdR77Ovg4TV5Q76VtCAdkRqc2YHvw/MD4AN
         bJEdv8NpJyMBAlh6SxbmHvWwAaLU009Fg6AZHkWGXT8oxG52FKzgFHLZ/oJSiowuNCUI
         zr1Q==
X-Gm-Message-State: APjAAAXKo+lcZex/sQSa2wHO0R3L+ifkqZw6lsoqu4ungAin73ywZAxW
        Zo8KlqLtOr0n3SN+t00PFI6rMUHITSQ=
X-Google-Smtp-Source: APXvYqwU3BiVtACu8/3nQCuMz7hVtGkewUXexz+BseY1XRM0b2PGsn0yw5Dh/+dDAuPNWl2bKxAGMQ==
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr4277629plb.303.1570640831326;
        Wed, 09 Oct 2019 10:07:11 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x20sm3417640pfp.120.2019.10.09.10.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 10:07:10 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Cast the page number to phys_addr_t
Date:   Wed,  9 Oct 2019 10:06:56 -0700
Message-Id: <1570640816-5390-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify pci_epc_mem_alloc_addr() to cast the variable 'pageno'
from type 'int' to 'phys_addr_t' before shifting left. This
cast is needed to avoid treating bit 31 of 'pageno' as the
sign bit which would otherwise get sign-extended to produce
a negative value. When added to the base address of PCI memory
space, the negative value would produce an invalid physical
address which falls before the start of the PCI memory space.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index 2bf8bd1f0563..d2b174ce15de 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -134,7 +134,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
 	if (pageno < 0)
 		return NULL;
 
-	*phys_addr = mem->phys_base + (pageno << page_shift);
+	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
 	virt_addr = ioremap(*phys_addr, size);
 	if (!virt_addr)
 		bitmap_release_region(mem->bitmap, pageno, order);
-- 
2.7.4

