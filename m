Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB479291
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfG2RtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 13:49:04 -0400
Received: from dougal.metanate.com ([90.155.101.14]:17159 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfG2RtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ArcKfcvrR2IxMjJeccc6MrDKlauBdncErN/c3B3yI9o=; b=gK5OQ1SW34NR3x8PbuSNBlUX6j
        HJbJA6BlFZPz6piqk2RvbjJoEQbQzVni0EjKJFqf+IhPFPD5PKDCLdV4dJjC0T82vS/1fL7SL4Uvk
        70hB+KD2lz4GmcDcFRGmRqAy/CLclEe2ysvR0xX2+Bqn6BCdxt3LvZLhz1UrARRa1ysIaFtWdZMR0
        AfWie0uPLlTN/dmqZyJKwRVa/JxbamEEgDRgVY/Qs0tgDoTbd15PFOL3Yenf/4+paWRqif3pBtGwY
        R2BjiX7EB64JMX27BMIX5Sib7BA+VdaFPVK+nxebahu55H10s6AmR9HqxP7H8m39iZgxULAoCYo3A
        LP0zn4Yw==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1hs9OM-0001Uh-Tc; Mon, 29 Jul 2019 18:24:59 +0100
From:   John Keeping <john@metanate.com>
Cc:     John Keeping <john@metanate.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf map: use zalloc for map_groups
Date:   Mon, 29 Jul 2019 18:24:29 +0100
Message-Id: <20190729172430.14880-1-john@metanate.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we will add new fields to map_groups and we need
these to be null if no value is assigned.  The simplest way to achieve
this is to request zeroed memory from the allocator.

Signed-off-by: John Keeping <john@metanate.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 668410b1d426..44b556812e4b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -636,7 +636,7 @@ bool map_groups__empty(struct map_groups *mg)
 
 struct map_groups *map_groups__new(struct machine *machine)
 {
-	struct map_groups *mg = malloc(sizeof(*mg));
+	struct map_groups *mg = zalloc(sizeof(*mg));
 
 	if (mg != NULL)
 		map_groups__init(mg, machine);
-- 
2.22.0

