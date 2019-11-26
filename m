Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C0109BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 11:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKZKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 05:07:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:62619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfKZKHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:07:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 02:07:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; 
   d="scan'208";a="409931063"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2019 02:07:15 -0800
From:   Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, andriy.shevchenko@intel.com,
        cezary.rojewski@intel.com, gustaw.lewandowski@intel.com
Subject: [PATCH] tracing: Fix __print_hex_dump scope
Date:   Tue, 26 Nov 2019 11:06:31 +0100
Message-Id: <1574762791-14883-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

undef is needed for parsing __print_hex_dump in traceevent lib.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/trace/trace_events.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7089760..472b33d 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -757,6 +757,7 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_str
 #undef __get_bitmask
 #undef __print_array
+#undef __print_hex_dump
 
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
-- 
2.7.4

