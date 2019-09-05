Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F17AA28B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfIEMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 08:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25979 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbfIEMDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94377883822;
        Thu,  5 Sep 2019 12:03:21 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF57010002B8;
        Thu,  5 Sep 2019 12:03:20 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] tools/power/x86/intel-speed-select: Fix help option typo
Date:   Thu,  5 Sep 2019 08:03:04 -0400
Message-Id: <20190905120311.15286-3-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 05 Sep 2019 12:03:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help is -h, not --h.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 91c5ad1685a1..d32af8210427 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1491,7 +1491,7 @@ static void usage(void)
 	printf("intel-speed-select [OPTIONS] FEATURE COMMAND COMMAND_ARGUMENTS\n");
 	printf("\nUse this tool to enumerate and control the Intel Speed Select Technology features,\n");
 	printf("\nFEATURE : [perf-profile|base-freq|turbo-freq|core-power]\n");
-	printf("\nFor help on each feature, use --h|--help\n");
+	printf("\nFor help on each feature, use -h|--help\n");
 	printf("\tFor example:  intel-speed-select perf-profile -h\n");
 
 	printf("\nFor additional help on each command for a feature, use --h|--help\n");
-- 
2.21.0

