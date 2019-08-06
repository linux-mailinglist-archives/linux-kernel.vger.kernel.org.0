Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05F832A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfHFNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 09:21:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:32585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:21:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 06:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325632007"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2019 06:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 501E6146; Tue,  6 Aug 2019 16:21:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tracing: Be more clever when dumping hex in __print_hex()
Date:   Tue,  6 Aug 2019 16:21:27 +0300
Message-Id: <20190806132127.43924-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hex dump as many as 16 bytes at once in trace_print_hex_seq()
instead of byte-by-byte approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/trace/trace_output.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cab4a5398f1d..ef52807473b7 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -219,10 +219,10 @@ trace_print_hex_seq(struct trace_seq *p, const unsigned char *buf, int buf_len,
 {
 	int i;
 	const char *ret = trace_seq_buffer_ptr(p);
+	const char *fmt = concatenate ? "%*phN" : "%*ph";
 
-	for (i = 0; i < buf_len; i++)
-		trace_seq_printf(p, "%s%2.2x", concatenate || i == 0 ? "" : " ",
-				 buf[i]);
+	for (i = 0; i < buf_len; i += 16)
+		trace_seq_printf(p, fmt, min(buf_len % 16, 16), &buf[i]);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.20.1

