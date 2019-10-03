Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC70C9E22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJCMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 08:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfJCMLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4FC0302C07C;
        Thu,  3 Oct 2019 12:11:24 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 550F75C226;
        Thu,  3 Oct 2019 12:11:24 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2 5/7] intel-speed-select: Implement CascadeLake-N help and command functions structures
Date:   Thu,  3 Oct 2019 08:11:10 -0400
Message-Id: <20191003121112.25870-6-prarit@redhat.com>
In-Reply-To: <20191003121112.25870-1-prarit@redhat.com>
References: <20191003121112.25870-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 03 Oct 2019 12:11:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CascadeLake-N only supports SST-BF and needs some of the perf-profile
commands, and the base-freq commands.

Add help functions, and create an empty command structures (the functions
will be implemented later in this patchset).  Call these functions
when running on CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 .../x86/intel-speed-select/isst-config.c      | 37 ++++++++++++++-----
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 164c4e5e6ccb..3ab0edade5ec 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1632,6 +1632,10 @@ static void get_clos_assoc(int arg)
 	isst_ctdp_display_information_end(outf);
 }
 
+static struct process_cmd_struct clx_n_cmds[] = {
+	{ NULL, NULL, NULL, 0 }
+};
+
 static struct process_cmd_struct isst_cmds[] = {
 	{ "perf-profile", "get-lock-status", get_tdp_locked, 0 },
 	{ "perf-profile", "get-config-levels", get_tdp_levels, 0 },
@@ -1820,12 +1824,15 @@ static void isst_help(void)
 		TDP, etc.\n");
 	printf("\nCommands : For feature=perf-profile\n");
 	printf("\tinfo\n");
-	printf("\tget-lock-status\n");
-	printf("\tget-config-levels\n");
-	printf("\tget-config-version\n");
-	printf("\tget-config-enabled\n");
-	printf("\tget-config-current-level\n");
-	printf("\tset-config-level\n");
+
+	if (!is_clx_n_platform()) {
+		printf("\tget-lock-status\n");
+		printf("\tget-config-levels\n");
+		printf("\tget-config-version\n");
+		printf("\tget-config-enabled\n");
+		printf("\tget-config-current-level\n");
+		printf("\tset-config-level\n");
+	}
 }
 
 static void pbf_help(void)
@@ -1875,6 +1882,12 @@ static struct process_cmd_help_struct isst_help_cmds[] = {
 	{ NULL, NULL }
 };
 
+static struct process_cmd_help_struct clx_n_help_cmds[] = {
+	{ "perf-profile", isst_help },
+	{ "base-freq", pbf_help },
+	{ NULL, NULL }
+};
+
 void process_command(int argc, char **argv,
 		     struct process_cmd_help_struct *help_cmds,
 		     struct process_cmd_struct *cmds)
@@ -2031,11 +2044,15 @@ static void cmdline(int argc, char **argv)
 	set_max_cpu_num();
 	set_cpu_present_cpu_mask();
 	set_cpu_target_cpu_mask();
-	ret = isst_fill_platform_info();
-	if (ret)
-		goto out;
 
-	process_command(argc, argv, isst_help_cmds, isst_cmds);
+	if (!is_clx_n_platform()) {
+		ret = isst_fill_platform_info();
+		if (ret)
+			goto out;
+		process_command(argc, argv, isst_help_cmds, isst_cmds);
+	} else {
+		process_command(argc, argv, clx_n_help_cmds, clx_n_cmds);
+	}
 out:
 	free_cpu_set(present_cpumask);
 	free_cpu_set(target_cpumask);
-- 
2.18.1

