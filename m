Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B3E6CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfJ1HHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:07:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:19783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbfJ1HHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 00:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="205111216"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 00:07:15 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 1/7] intel_th: gth: Fix the window switching sequence
Date:   Mon, 28 Oct 2019 09:06:45 +0200
Message-Id: <20191028070651.9770-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8116db57cf16 ("intel_th: Add switch triggering support") added
a trigger assertion of the CTS, but forgot to de-assert it at the end
of the sequence. This results in window switches randomly not happening.

Fix that by de-asserting the trigger at the end of the window switch
sequence.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/gth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index fa9d34af87ac..f72803a02391 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -626,6 +626,9 @@ static void intel_th_gth_switch(struct intel_th_device *thdev,
 	if (!count)
 		dev_dbg(&thdev->dev, "timeout waiting for CTS Trigger\n");
 
+	/* De-assert the trigger */
+	iowrite32(0, gth->base + REG_CTS_CTL);
+
 	intel_th_gth_stop(gth, output, false);
 	intel_th_gth_start(gth, output);
 }
-- 
2.23.0

