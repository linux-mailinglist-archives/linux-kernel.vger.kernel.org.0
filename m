Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D1E119C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEBNJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 09:09:28 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:50940 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfEBNJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:09:27 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 09:09:25 EDT
Received: from std-ryzen.beckhoff.com (172.17.66.182) by
 NT-Mail02.beckhoff.com (10.1.0.27) with Microsoft SMTP Server (TLS) id
 14.3.301.0; Thu, 2 May 2019 15:04:18 +0200
From:   <linux-kernel-dev@beckhoff.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table
Date:   Thu, 2 May 2019 15:03:51 +0200
Message-ID: <20190502130351.5341-2-linux-kernel-dev@beckhoff.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
References: <20190502130351.5341-1-linux-kernel-dev@beckhoff.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.17.66.182]
X-OLX-Disclaimer: Done
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

There are several Beckhoff Automation industrial PC boards which use
pmc_plt_clk* clocks for ethernet controllers. This adds affected boards
to critclk_systems DMI table so the clocks are marked as CLK_CRITICAL and
not turned off.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/platform/x86/pmc_atom.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index a311f48ce7c9..b1d804376237 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -413,6 +413,30 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
 		},
 	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB3163",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB6263",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB6263"),
+		},
+	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB6363",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 
-- 
2.21.0
