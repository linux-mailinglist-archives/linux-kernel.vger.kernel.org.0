Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8010F13693
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfEDA3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 20:29:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:11134 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfEDA3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:29:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="170430434"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2019 17:29:40 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/8] soundwire: mipi_disco: fix master/link error
Date:   Fri,  3 May 2019 19:29:20 -0500
Message-Id: <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DisCo specification for SoundWire defines the
"mipi-sdw-link-N-subproperties", not the master-N properties. Fix to
parse firmware information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index c1f51d6a23d2..6df68584c963 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -40,7 +40,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-		 "mipi-sdw-master-%d-subproperties", bus->link_id);
+		 "mipi-sdw-link-%d-subproperties", bus->link_id);
 
 	link = device_get_named_child_node(bus->dev, name);
 	if (!link) {
-- 
2.17.1

