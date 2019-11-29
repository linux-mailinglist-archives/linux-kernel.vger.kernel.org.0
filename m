Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3E10D36D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfK2Jqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 04:46:52 -0500
Received: from thoth.sbs.de ([192.35.17.2]:39011 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK2Jqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:46:52 -0500
X-Greylist: delayed 1632 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 04:46:50 EST
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id xAT9JVmQ023199
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Nov 2019 10:19:31 +0100
Received: from dev.vm6.ccp.siemens.com (md1quwnc.ad001.siemens.net [139.16.77.128])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id xAT9JTqo031799;
        Fri, 29 Nov 2019 10:19:30 +0100
Received: from dev.localdomain (localhost [127.0.0.1])
        by dev.vm6.ccp.siemens.com (Postfix) with ESMTP id 4B0EE23CE8B7;
        Fri, 29 Nov 2019 10:19:29 +0100 (CET)
From:   Michael Haener <michael.haener@siemens.com>
To:     andy@infradead.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: pmc_atom: Add Siemens CONNECT X300 to critclk_systems DMI table
Date:   Fri, 29 Nov 2019 10:16:49 +0100
Message-Id: <20191129091650.4765-1-michael.haener@siemens.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONNECT X300 uses the PMC clock for on-board components and gets
stuck during boot if the clock is disabled. Therefore, add this
device to the critical systems list.
Tested on CONNECT X300.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/platform/x86/pmc_atom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 07d1b911e72f..57f06ca114a6 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -429,6 +429,14 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "6AV7882-0"),
 		},
 	},
+	{
+		.ident = "CONNECT X300",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "A5E45074588")
+		},
+	},
+
 	{ /*sentinel*/ }
 };
 
-- 
2.11.0

