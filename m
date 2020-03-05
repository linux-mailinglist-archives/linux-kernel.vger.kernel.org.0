Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC117B1B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCEWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:46:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:5035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCEWp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674662"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:54 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 23/27] tools/power/x86/intel-speed-select: Fix avx options for turbo-freq feature
Date:   Thu,  5 Mar 2020 14:45:34 -0800
Message-Id: <20200305224538.490864-24-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying "avx2" and "avx512" option for display filter doesn't work
with short option "-r", only works with --try-type. Also compare full
6 characters for "avx512" string.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index a44ec2f76f52..2a81fb881f04 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -2329,7 +2329,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 	option_index = start;
 
 	optind = start + 1;
-	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:hoa",
+	while ((opt = getopt_long(argc, argv, "b:l:t:c:d:e:n:m:p:w:r:hoa",
 				  long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -2355,7 +2355,7 @@ static void parse_cmd_args(int argc, int start, char **argv)
 				fact_avx = 0x01;
 			} else if (!strncmp(optarg, "avx2", 4)) {
 				fact_avx = 0x02;
-			} else if (!strncmp(optarg, "avx512", 4)) {
+			} else if (!strncmp(optarg, "avx512", 6)) {
 				fact_avx = 0x04;
 			} else {
 				fprintf(outf, "Invalid sse,avx options\n");
-- 
2.24.1

