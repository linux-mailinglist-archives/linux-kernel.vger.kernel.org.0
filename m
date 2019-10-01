Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0888DC32BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfJALig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:38:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:46305 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfJALif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="391165497"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2019 04:38:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EB73D1DF; Tue,  1 Oct 2019 14:38:30 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/22] thunderbolt: Log switch route string on config read/write timeout
Date:   Tue,  1 Oct 2019 14:38:10 +0300
Message-Id: <20191001113830.13028-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps to point out which switch config read/write triggered the
timeout.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/ctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 2ec1af8f7968..d97813e80e5f 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -962,8 +962,8 @@ int tb_cfg_read(struct tb_ctl *ctl, void *buffer, u64 route, u32 port,
 		return tb_cfg_get_error(ctl, space, &res);
 
 	case -ETIMEDOUT:
-		tb_ctl_warn(ctl, "timeout reading config space %u from %#x\n",
-			    space, offset);
+		tb_ctl_warn(ctl, "%llx: timeout reading config space %u from %#x\n",
+			    route, space, offset);
 		break;
 
 	default:
@@ -988,8 +988,8 @@ int tb_cfg_write(struct tb_ctl *ctl, const void *buffer, u64 route, u32 port,
 		return tb_cfg_get_error(ctl, space, &res);
 
 	case -ETIMEDOUT:
-		tb_ctl_warn(ctl, "timeout writing config space %u to %#x\n",
-			    space, offset);
+		tb_ctl_warn(ctl, "%llx: timeout writing config space %u to %#x\n",
+			    route, space, offset);
 		break;
 
 	default:
-- 
2.23.0

