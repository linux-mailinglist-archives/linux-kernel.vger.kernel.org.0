Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88328A6CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfICPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 11:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDF618665D;
        Tue,  3 Sep 2019 15:37:40 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D14819C78;
        Tue,  3 Sep 2019 15:37:40 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] tools/power/x86/intel-speed-select: Fix package typo
Date:   Tue,  3 Sep 2019 11:37:27 -0400
Message-Id: <20190903153734.11904-2-prarit@redhat.com>
In-Reply-To: <20190903153734.11904-1-prarit@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 03 Sep 2019 15:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

packag_ should be package_.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index f368b8323742..0d9a53a5da2d 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -133,7 +133,7 @@ static void format_and_print(FILE *outf, int level, char *header, char *value)
 	last_level = level;
 }
 
-static void print_packag_info(int cpu, FILE *outf)
+static void print_package_info(int cpu, FILE *outf)
 {
 	char header[256];
 
@@ -261,7 +261,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 	char value[256];
 	int i, base_level = 1;
 
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 
 	for (i = 0; i <= pkg_dev->levels; ++i) {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
@@ -397,7 +397,7 @@ void isst_ctdp_display_information_end(FILE *outf)
 void isst_pbf_display_information(int cpu, FILE *outf, int level,
 				  struct isst_pbf_info *pbf_info)
 {
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4);
 	format_and_print(outf, 1, NULL, NULL);
 }
@@ -406,7 +406,7 @@ void isst_fact_display_information(int cpu, FILE *outf, int level,
 				   int fact_bucket, int fact_avx,
 				   struct isst_fact_info *fact_info)
 {
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 	_isst_fact_display_information(cpu, outf, level, fact_bucket, fact_avx,
 				       fact_info, 4);
 	format_and_print(outf, 1, NULL, NULL);
-- 
2.21.0

