Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20874A278
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfFRNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 09:39:08 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:50160 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:39:07 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2019 09:39:06 EDT
Received: from std-ryzen.beckhoff.com (172.17.66.182) by
 NT-Mail02.beckhoff.com (10.1.0.27) with Microsoft SMTP Server (TLS) id
 14.3.301.0; Tue, 18 Jun 2019 15:34:04 +0200
From:   <linux-kernel-dev@beckhoff.com>
CC:     Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: pmc_atom: Add CB4063 Beckhoff Automation board to critclk_systems DMI table
Date:   Tue, 18 Jun 2019 15:31:02 +0200
Message-ID: <20190618133102.8083-1-linux-kernel-dev@beckhoff.com>
X-Mailer: git-send-email 2.22.0
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

The CB4063 board uses pmc_plt_clk* clocks for ethernet controllers. This
adds it to the critclk_systems DMI table so the clocks are marked as
CLK_CRITICAL and not turned off.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/platform/x86/pmc_atom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index be802fd2182d..551ed44dd361 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -412,6 +412,14 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
 		},
 	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident = "Beckhoff CB4063",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
+			DMI_MATCH(DMI_BOARD_NAME, "CB4063"),
+		},
+	},
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident = "Beckhoff CB6263",
-- 
2.22.0
