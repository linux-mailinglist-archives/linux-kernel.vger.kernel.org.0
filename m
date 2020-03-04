Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0708178D16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 10:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgCDJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 04:07:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:17638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387739AbgCDJH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:07:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:07:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413074223"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:07:24 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 02/13] perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
Date:   Wed,  4 Mar 2020 11:06:22 +0200
Message-Id: <20200304090633.420-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304090633.420-1-adrian.hunter@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for perf text poke event for text_poke_bp_batch() callers. That
includes jump labels. See comments for more details.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/alternative.c | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 34360ca301a2..737e7a842f85 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
@@ -946,6 +947,7 @@ struct text_poke_loc {
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 old;
 };
 
 struct bp_patching_desc {
@@ -1114,8 +1116,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
+		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+	}
 
 	text_poke_sync();
 
@@ -1123,14 +1127,45 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
 		int len = text_opcode_size(tp[i].opcode);
 
 		if (len - INT3_INSN_SIZE > 0) {
+			memcpy(old + INT3_INSN_SIZE,
+			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+			       len - INT3_INSN_SIZE);
 			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
 				  (const char *)tp[i].text + INT3_INSN_SIZE,
 				  len - INT3_INSN_SIZE);
 			do_sync++;
 		}
+
+		/*
+		 * Emit a perf event to record the text poke, primarily to
+		 * support Intel PT decoding which must walk the executable code
+		 * to reconstruct the trace. The flow up to here is:
+		 *   - write INT3 byte
+		 *   - IPI-SYNC
+		 *   - write instruction tail
+		 * At this point the actual control flow will be through the
+		 * INT3 and handler and not hit the old or new instruction.
+		 * Intel PT outputs FUP/TIP packets for the INT3, so the flow
+		 * can still be decoded. Subsequently:
+		 *   - emit RECORD_TEXT_POKE with the new instruction
+		 *   - IPI-SYNC
+		 *   - write first byte
+		 *   - IPI-SYNC
+		 * So before the text poke event timestamp, the decoder will see
+		 * either the old instruction flow or FUP/TIP of INT3. After the
+		 * text poke event timestamp, the decoder will see either the
+		 * new instruction flow or FUP/TIP of INT3. Thus decoders can
+		 * use the timestamp as the point at which to modify the
+		 * executable code.
+		 * The old instruction is recorded so that the event can be
+		 * processed forwards or backwards.
+		 */
+		perf_event_text_poke(text_poke_addr(&tp[i]), old, len,
+				     tp[i].text, len);
 	}
 
 	if (do_sync) {
-- 
2.17.1

