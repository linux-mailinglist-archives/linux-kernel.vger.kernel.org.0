Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A447B75B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGYXlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:41:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfGYXlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874704"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:19 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 14/40] soundwire: cadence_master: fix definitions for INTSTAT0/1
Date:   Thu, 25 Jul 2019 18:40:06 -0500
Message-Id: <20190725234032.21152-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two off-by-one errors: INTSTAT0 missed BIT(31) and INTSTAT1 is only
defined on first 16 bits.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d9d9e3d964dd..889fa2cd49ae 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -100,8 +100,8 @@
 #define CDNS_MCP_SLAVE_INTMASK0			0x5C
 #define CDNS_MCP_SLAVE_INTMASK1			0x60
 
-#define CDNS_MCP_SLAVE_INTMASK0_MASK		GENMASK(30, 0)
-#define CDNS_MCP_SLAVE_INTMASK1_MASK		GENMASK(16, 0)
+#define CDNS_MCP_SLAVE_INTMASK0_MASK		GENMASK(31, 0)
+#define CDNS_MCP_SLAVE_INTMASK1_MASK		GENMASK(15, 0)
 
 #define CDNS_MCP_PORT_INTSTAT			0x64
 #define CDNS_MCP_PDI_STAT			0x6C
-- 
2.20.1

