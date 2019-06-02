Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC4323B2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFBPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 11:04:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43469 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFBPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:04:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id r18so589451wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=CcVASgLBBkSQXOvN9zTjH4zICIbfmh6RBlhGWPzCbrA=;
        b=tUShFhir/kIy6niRhrvf1p4+4+IgsQALwKsYhZ7kGmtpB2gLIs7ykN7kJI1C+ZGi61
         zYIzKiJEmLaREDiAT9K0YLLB81BNZpPQXKB2eqyoJDYevpHNrPDvkU8C2UTdbjvzdoNy
         u2CSZ1mXm/Vn5bSjxrTkdhWzN705qSt0G6vhVzeQ0vJRKUfGjBcvwxo8cY562w345ElN
         ux9eo4X5Wwvm996ucP9OyI/ISlHdJGyQfk8GUrp8eCuztC42xqiafQkkE+LMfMQOeg+T
         LBPhgsOEisptn0NC8K8l+6NnZ8Q6VymLsA+uWYi5EbwvOzLXMJZSecs6aqfFk4hqOYZb
         2ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=CcVASgLBBkSQXOvN9zTjH4zICIbfmh6RBlhGWPzCbrA=;
        b=BN0Sn6IMN7c2AjNoJI54JNvEzi7/Ivi8ApyT3SZQ+MuQyUCVgwSKmioHD5DCAToMd8
         AoUTftLKmsBNYQRHQZhSb2zvGV10dkCfnWvUPxasUSyQ5XBNMtMFDYYBKDiLNGuY5ajU
         8Nh0/Bkq9JunBdocy4FP7/FwesTWSF+Cra3xDAL88JUnt4U4wDiTU/7DXRDqfCw0TSUg
         VCzRDiWW7YYWXKCXuek1k9rMnpcLI0BYj2y6bi3OjnFdbgdzCSYl+Ech/8fKBG7tOCN8
         kGfl47re9f/HCNbp8VpiH+aqvZwPb75gfRlVBuyZnRdF1lW/YbppzEHkraZDQ4KBfMxV
         3sEw==
X-Gm-Message-State: APjAAAWjke7BRa7/f3xm2Gl3Zgh0YYM4hJCioKtqEF91ckLoGwhSijlE
        39Hemt3w+qRyAPRUuZCQ80st6zWnFUw=
X-Google-Smtp-Source: APXvYqwqmHoIUIch9SpJWD8GT7a7i3Ml/z4bEv4vvaAupybrfvI9+Y5tRDXHVjTHaMlenlwGyANn3Q==
X-Received: by 2002:adf:9e4c:: with SMTP id v12mr13361798wre.312.1559487863300;
        Sun, 02 Jun 2019 08:04:23 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id u19sm31346627wmu.41.2019.06.02.08.04.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 08:04:22 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>
Subject: [PATCH 2/2] pci: shpchp: Remove function hpc_get_mode1_ECC_cap
Date:   Sun,  2 Jun 2019 17:04:13 +0200
Message-Id: <20190602150418.31723-2-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190602150418.31723-1-benniciemanuel78@gmail.com>
References: <20190602150418.31723-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function hpc_get_mode1_ECC_cap since it was used by the
get_mode1_ECC_cap Callback - that was removed.
So this function is unused and can be safely removed.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/shpchp_hpc.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 59f75e567c63..a6d713360dca 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -494,23 +494,6 @@ static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
 	return retval;
 }

-static int hpc_get_mode1_ECC_cap(struct slot *slot, u8 *mode)
-{
-	int retval = 0;
-	struct controller *ctrl = slot->ctrl;
-	u16 sec_bus_status = shpc_readw(ctrl, SEC_BUS_CONFIG);
-	u8 pi = shpc_readb(ctrl, PROG_INTERFACE);
-
-	if (pi == 2) {
-		*mode = (sec_bus_status & 0x0100) >> 8;
-	} else {
-		retval = -1;
-	}
-
-	ctrl_dbg(ctrl, "Mode 1 ECC cap = %d\n", *mode);
-	return retval;
-}
-
 static int hpc_query_power_fault(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
--
2.19.1

