Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F217AAFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 17:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgCEQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 11:55:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:17958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCEQzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:55:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="229756725"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 05 Mar 2020 08:55:46 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 1/2] firmware: stratix10-svc: add the compatible value for intel agilex
Date:   Thu,  5 Mar 2020 11:12:25 -0600
Message-Id: <1583428346-13307-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
References: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add the compatible property value so we can reuse Intel Stratix10
Service Layer driver on Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 7ffb42b..d5f0769 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -966,6 +966,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
 static const struct of_device_id stratix10_svc_drv_match[] = {
 	{.compatible = "intel,stratix10-svc"},
+	{.compatible = "intel,agilex-svc"},
 	{},
 };
 
-- 
2.7.4

