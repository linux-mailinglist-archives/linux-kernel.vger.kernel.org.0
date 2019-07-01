Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038442DE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE2Nhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfE2Nhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:37:36 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EFD720883;
        Wed, 29 May 2019 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137055;
        bh=G/LcTvsZAXoLdG5rhr5qBME/rfiETDMFENgQFMGSJ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpYsmDeEffDMmO0sd7192SRJayC0X7yOKZ+wEeGzelrnYD2U3fTjXgRyH/HZ+eteP
         R5PTvD0wI2K017If0uJS++n2XYpb8a89RcPGuhCDKAegd1ymhzo4QCKcjzDhxT19t2
         dYuYwuyJFXn8t/YHVCJ//WObgQkxXZwX8kYOINXY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 17/41] perf trace beauty clone: Handle CLONE_PIDFD
Date:   Wed, 29 May 2019 10:35:41 -0300
Message-Id: <20190529133605.21118-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In addition to the older flags. This will allow something like this to
be implemented in 'perf trace"

  perf trace -e clone/PIDFD in flags/

I.e. ask for strace like tracing, system wide, looking for 'clone'
syscalls that have the CLONE_PIDFD bit set in the 'flags' arg.

For now we'll just see PIDFD if it is set in the 'flags' arg.

Cc: Christian Brauner <christian@brauner.io>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-drq9h7s8gcv8b87064fp6lb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 6eb9a6636171..1a8d3be2030e 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -25,6 +25,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(FS);
 	P_FLAG(FILES);
 	P_FLAG(SIGHAND);
+	P_FLAG(PIDFD);
 	P_FLAG(PTRACE);
 	P_FLAG(VFORK);
 	P_FLAG(PARENT);
-- 
2.20.1

