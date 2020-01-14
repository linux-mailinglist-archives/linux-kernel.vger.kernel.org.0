Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A146F13B2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgANTWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 14:22:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:48040 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgANTWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:22:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 11:22:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="423259144"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jan 2020 11:22:20 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/5] platform/x86: ISST: Allow additional core-power mailbox commands
Date:   Tue, 14 Jan 2020 11:22:13 -0800
Message-Id: <20200114192217.580364-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
References: <20200114192217.580364-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To discover core-power capability, some new mailbox commands are added. Allow
those commands to execute.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel_speed_select_if/isst_if_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 3de5a3c66529..0c2aa22c7a12 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -50,6 +50,8 @@ static const struct isst_valid_cmd_ranges isst_valid_cmds[] = {
 	{0x7F, 0x00, 0x0B},
 	{0x7F, 0x10, 0x12},
 	{0x7F, 0x20, 0x23},
+	{0x94, 0x03, 0x03},
+	{0x95, 0x03, 0x03},
 };
 
 static const struct isst_cmd_set_req_type isst_cmd_set_reqs[] = {
@@ -59,6 +61,7 @@ static const struct isst_cmd_set_req_type isst_cmd_set_reqs[] = {
 	{0xD0, 0x03, 0x08},
 	{0x7F, 0x02, 0x00},
 	{0x7F, 0x08, 0x00},
+	{0x95, 0x03, 0x03},
 };
 
 struct isst_cmd {
-- 
2.24.1

