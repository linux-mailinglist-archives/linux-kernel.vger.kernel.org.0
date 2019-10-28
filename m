Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0645E6CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfJ1HHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:07:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:19783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbfJ1HHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 00:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="205111234"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 00:07:18 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 3/7] intel_th: msu: Fix missing allocation failure check on a kstrndup
Date:   Mon, 28 Oct 2019 09:06:47 +0200
Message-Id: <20191028070651.9770-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Commit 615c164da0eb ("intel_th: msu: Introduce buffer interface") forgot
to add a NULL pointer check for the value returned from kstrdup(), which
will be troublesome if the allocation fails.

Fix that by adding the check.

Addresses-Coverity: ("Dereference null return")
Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
[alexander.shishkin: amended the commit message]
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/lkml/20190726120421.9650-1-colin.king@canonical.com/
---
 drivers/hwtracing/intel_th/msu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 51021020fa3f..201a166fdff5 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1848,6 +1848,9 @@ mode_store(struct device *dev, struct device_attribute *attr, const char *buf,
 		len = cp - buf;
 
 	mode = kstrndup(buf, len, GFP_KERNEL);
+	if (!mode)
+		return -ENOMEM;
+
 	i = match_string(msc_mode, ARRAY_SIZE(msc_mode), mode);
 	if (i >= 0)
 		goto found;
-- 
2.23.0

