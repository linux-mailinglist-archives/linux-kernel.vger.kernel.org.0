Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01543A29DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfH2Wl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfH2Wl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974F2107DD00;
        Thu, 29 Aug 2019 22:41:26 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A280D6060D;
        Thu, 29 Aug 2019 22:41:25 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] perf: Update .gitignore file
Date:   Thu, 29 Aug 2019 17:41:19 -0500
Message-Id: <03acbc6c2fbc72054861f6c301875db75db33030.1567118001.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1567118001.git.jpoimboe@redhat.com>
References: <cover.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 29 Aug 2019 22:41:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a "make tools/perf", git reports the following untracked files:

  tools/perf/feature/
  tools/perf/fixdep
  tools/perf/libtraceevent-dynamic-list

Add these generated files to perf's .gitignore file.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/perf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 3e5135dded16..bf1252dc2cb0 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -34,3 +34,6 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
+feature/
+fixdep
+libtraceevent-dynamic-list
-- 
2.20.1

