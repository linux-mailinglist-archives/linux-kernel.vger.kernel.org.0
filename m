Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6FE12FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfECOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 10:06:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36726 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfECOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:06:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so6163317edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D/CH4GqGr+z8YvNiyoDqREVHjChbqZqJjYmwX1HGL8k=;
        b=eGhXmoc8I9oK5S07+Cf/+NBpgznArjYFwNdzPDBoc5oNv6WpfFrICkvkWudLf8UoXM
         oURzLmKVEFVRQxZXxb+XXHRTJNlkjfG1iBgT1ph5n5gPYfsTtOVyyG6Rty6Z+jReH9cq
         R71Ey5B+kPUXrCZdmq4MraXrTUzvKbiMIgtaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D/CH4GqGr+z8YvNiyoDqREVHjChbqZqJjYmwX1HGL8k=;
        b=Tvcaxv3k658liJJoxIFzXIodzZVvgFQbJ/zfReSR9sXxMZ5X82FfTl3fi6f6dZ8V/J
         b/ePqEo9A9IjBzE3JXDuaHgqkkEwi096mPnMSnV3mJ/SQb/vUswNV+guS5Wd5MU5FA2e
         zW8HVpeZvFRzQ5wpVdEgOiXdirNqamxk2FE4LPrynWhs7josQv+PSiQ4PyvelpN+QaSf
         /xs1gZX40PwpXgoRyQLZby1FhbvbTxXwu9eLdqBHHrz2i/tjkWlTXCdI7ZN6/lHr+Y8W
         igXJYCnqg0l12707uxWw67NPqYJFhHneJo/G2ptoEj6J41n8SmUx5jIFKLJMuK3jSEmT
         hCAg==
X-Gm-Message-State: APjAAAXpy1RsvDdXsXazTOELtw6s35ixI6+PZ7+ifvXaabLjKMv4sAAL
        7JBx7oPq/XydOQh9xG2zNbqhMg==
X-Google-Smtp-Source: APXvYqzGIjNck5fcKtNGAmKeDcxVbNQcwMe9+Ow76Mtcv1tHZaSwqBqwtaKclkMR03PmKdn3UxvlPA==
X-Received: by 2002:a17:906:6a1a:: with SMTP id o26mr6433401ejr.170.1556892359682;
        Fri, 03 May 2019 07:05:59 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 07:05:58 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 1/3] PCI: Add dma_ranges window list
Date:   Fri,  3 May 2019 19:35:32 +0530
Message-Id: <1556892334-16270-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dma_ranges field in PCI host bridge structure to hold resource
entries list of memory regions in sorted order representing memory
ranges that can be accessed through DMA transactions.

Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7e12d01..72563c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -595,6 +595,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -623,6 +624,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_ranges);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -632,6 +634,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_ranges);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7744821..bba0a29 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -490,6 +490,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4

