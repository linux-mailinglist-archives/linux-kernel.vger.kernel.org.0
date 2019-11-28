Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAA10C9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfK1Nlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfK1Nl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:27 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA8F21789;
        Thu, 28 Nov 2019 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948487;
        bh=4W5lmUp57I07jpiDCIQgF2mFUZ4tOl3slL+ewf40+fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxIeuZjYoaB1X5BJnoQKpZ1lyOScUHrAbskKGqlS6XRO0XycAXjFkZjYQTe9RmwuC
         EPNDjHYaLLC1OlGnyG0TPovBVw1vDR05vJoTJEQwFVVeimDanX6suAgKjv0zPL5COq
         1CfAqO8Kve2dcTkqQn+S+Rbw7Vz00vt9VkHP8UFY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/22] perf diff: Use llabs() with 64-bit values
Date:   Thu, 28 Nov 2019 10:40:21 -0300
Message-Id: <20191128134027.23726-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To fix these build errors on a debian mipsel cross build environment:

  builtin-diff.c: In function 'block_cycles_diff_cmp':
  builtin-diff.c:550:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    550 |  l = labs(left->diff.cycles);
        |      ^~~~
  builtin-diff.c:551:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    551 |  r = labs(right->diff.cycles);
        |      ^~~~

Fixes: 99150a1faab2 ("perf diff: Use hists to manage basic blocks per symbol")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 376dbf10ad64..eae879376283 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -547,8 +547,8 @@ static int64_t block_cycles_diff_cmp(struct hist_entry *left,
 	if (!pairs_left && !pairs_right)
 		return 0;
 
-	l = labs(left->diff.cycles);
-	r = labs(right->diff.cycles);
+	l = llabs(left->diff.cycles);
+	r = llabs(right->diff.cycles);
 	return r - l;
 }
 
-- 
2.21.0

