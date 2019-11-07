Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982F8F37BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfKGTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKGTBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:00 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C2F21D6C;
        Thu,  7 Nov 2019 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153259;
        bh=yU93yReK12c6wAESh1i2vJfOWq+QCYol9+J7+1btwBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdAi9TgnCdFwfvjWop8OnEj8PZj3Tbq0SHzFOM/0za7By4SRNTGRDr78DQi2hdUDF
         x+R7jtlUk76L521ugt0hYKBX1eSrglfwrAT5EwwZ8ZnWEf/4GvFs1i3JI3J0QQSlmD
         xwJbBB4BuT/q+hnePcQJW6bO1/ZVUd5OOyxLRo/0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/63] perf session: Fix indent in perf_session__new()"
Date:   Thu,  7 Nov 2019 15:59:12 -0300
Message-Id: <20191107190011.23924-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Fix up indentation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lore.kernel.org/lkml/20191007112027.GD6919@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6cc32f5ec043..0266604b8bc2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -227,8 +227,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			/* Open the directory data. */
 			if (data->is_dir) {
 				ret = perf_data__open_dir(data);
-			if (ret)
-				goto out_delete;
+				if (ret)
+					goto out_delete;
 			}
 		}
 	} else  {
-- 
2.21.0

