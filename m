Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52834CECCB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfJGTbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 15:31:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:26154 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbfJGTbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 12:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192372877"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 12:31:08 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/6] tools/power/x86/intel-speed-select: Make process_command generic
Date:   Mon,  7 Oct 2019 12:30:56 -0700
Message-Id: <20191007193100.36934-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

Make the process_command take any help command and command list.  This
will make it easier to help commands and a command list for CascadeLake-N.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 4927aebee306..907b79e16c68 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1816,7 +1816,9 @@ static struct process_cmd_help_struct isst_help_cmds[] = {
 	{ NULL, NULL }
 };
 
-void process_command(int argc, char **argv)
+void process_command(int argc, char **argv,
+		     struct process_cmd_help_struct *help_cmds,
+		     struct process_cmd_struct *cmds)
 {
 	int i = 0, matched = 0;
 	char *feature = argv[optind];
@@ -1827,9 +1829,9 @@ void process_command(int argc, char **argv)
 
 	debug_printf("feature name [%s] command [%s]\n", feature, cmd);
 	if (!strcmp(cmd, "-h") || !strcmp(cmd, "--help")) {
-		while (isst_help_cmds[i].feature) {
-			if (!strcmp(isst_help_cmds[i].feature, feature)) {
-				isst_help_cmds[i].process_fn();
+		while (help_cmds[i].feature) {
+			if (!strcmp(help_cmds[i].feature, feature)) {
+				help_cmds[i].process_fn();
 				exit(0);
 			}
 			++i;
@@ -1839,11 +1841,11 @@ void process_command(int argc, char **argv)
 	create_cpu_map();
 
 	i = 0;
-	while (isst_cmds[i].feature) {
-		if (!strcmp(isst_cmds[i].feature, feature) &&
-		    !strcmp(isst_cmds[i].command, cmd)) {
+	while (cmds[i].feature) {
+		if (!strcmp(cmds[i].feature, feature) &&
+		    !strcmp(cmds[i].command, cmd)) {
 			parse_cmd_args(argc, optind + 1, argv);
-			isst_cmds[i].process_fn(isst_cmds[i].arg);
+			cmds[i].process_fn(cmds[i].arg);
 			matched = 1;
 			break;
 		}
@@ -1964,7 +1966,7 @@ static void cmdline(int argc, char **argv)
 	if (ret)
 		goto out;
 
-	process_command(argc, argv);
+	process_command(argc, argv, isst_help_cmds, isst_cmds);
 out:
 	free_cpu_set(present_cpumask);
 	free_cpu_set(target_cpumask);
-- 
2.17.2

