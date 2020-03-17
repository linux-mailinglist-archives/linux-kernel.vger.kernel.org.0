Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E01189088
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCQVeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQVeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC192076D;
        Tue, 17 Mar 2020 21:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480851;
        bh=nDaCAdkt0N2dWJGyFb2243xTSO6Sw/PyGrciZLkdn4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzA1MWHFRCj7vB/Q5nEbu66w+dsalKNui7PtzlRO/UTr0JlAiY4aSnb6h37nabJPV
         w1S+1rA92h88YeRJ5y6Ne32QhYXOACWuC6XWnhnr2dyaha1gpw2iWjmepdZFEmRieH
         LxunkHtU9AUX8iRcMSesEMUQUX7knYDYYw4/nOjc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 17/23] perf intel-pt: Update intel-pt.txt file with new location of the documentation
Date:   Tue, 17 Mar 2020 18:32:53 -0300
Message-Id: <20200317213259.15494-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Make it easy for people looking in intel-pt.txt to find the new file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200311122034.3697-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/perf/Documentation/intel-pt.txt

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
new file mode 100644
index 000000000000..fd9241a1b987
--- /dev/null
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -0,0 +1 @@
+Documentation for support for Intel Processor Trace within perf tools' has moved to file perf-intel-pt.txt
-- 
2.21.1

