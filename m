Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBBB17B1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCEWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:46:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:5042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbgCEWp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674678"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:57 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 27/27] tools/power/x86/intel-speed-select: Update version
Date:   Thu,  5 Mar 2020 14:45:38 -0800
Message-Id: <20200305224538.490864-28-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fair number of changes including bug fixes done to change version.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 924cb871d6d2..cd803a40ee40 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -15,7 +15,7 @@ struct process_cmd_struct {
 	int arg;
 };
 
-static const char *version_str = "v1.2";
+static const char *version_str = "v1.3";
 static const int supported_api_ver = 1;
 static struct isst_if_platform_info isst_platform_info;
 static char *progname;
-- 
2.24.1

