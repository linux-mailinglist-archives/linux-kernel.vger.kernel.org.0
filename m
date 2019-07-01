Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E725A6B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF1WHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 18:07:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:44146 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfF1WHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:07:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 15:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="338031188"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2019 15:07:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5D8D230054C; Fri, 28 Jun 2019 15:07:46 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf list: Avoid extra : for --raw metrics
Date:   Fri, 28 Jun 2019 15:07:36 -0700
Message-Id: <20190628220737.13259-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628220737.13259-1-andi@firstfloor.org>
References: <20190628220737.13259-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When printing the metrics raw, don't print : after the metricgroups.
This helps the command line completion to complete those too.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fabdb6dde88e..1c85c9624c58 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -376,7 +376,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
-			printf("%s%s%s", me->name, metrics ? ":" : "", raw ? " " : "\n");
+			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
 		if (metrics)
 			metricgroup__print_strlist(me->metrics, raw);
 		next = rb_next(node);
-- 
2.20.1

