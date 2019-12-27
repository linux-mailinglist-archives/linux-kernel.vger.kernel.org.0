Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA912B385
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL0JUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 04:20:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:6016 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0JUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:20:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 01:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="367987606"
Received: from tchen40-mobl.gar.corp.intel.com (HELO M5530.gar.corp.intel.com) ([10.255.129.32])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2019 01:19:50 -0800
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf/x86/intel/rapl: Add Comet Lake support
Date:   Fri, 27 Dec 2019 17:19:46 +0800
Message-Id: <20191227171944.1.Id6f3ab98474d7d1dba5b95390b24e0a67368d364@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comet Lake supports the same RAPL counters like Kaby Lake and Skylake.
After this, on CML machine the energy counters appear in perf list.

Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 arch/x86/events/intel/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 5053a403e4ae..09913121e726 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -741,6 +741,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_COMETLAKE_L,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_COMETLAKE,		model_skl),
 	{},
 };
 
-- 
2.24.1

