Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690328E8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfHOKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 06:02:14 -0400
Received: from dougal.metanate.com ([90.155.101.14]:3523 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730715AbfHOKCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ySEK8TYJv9AwklGcX4We/Bt69pH8uXoVB7SweWB7fEc=; b=r2zY3cY0II9RiE2iq4phIhnvvK
        PTiy3ccX1IDF6rM8sOfvpT+p+faXbothY0boe6u/f1Tq18/PyJgbT+BpkMaWrSRBWjT+8Vek5aJbv
        mjzpnORsKfQBpMi7wTPqaN/tQLc5p3oYIKnG7D4i7G9uwqXHXsWerEeAIXjXAf5MvDuHBRlkNU/NG
        bY2z7p5SrgR8lzKZFx+cYW4ziksNjdgp6O92rEW36J5W2zk69XzzxTDTQDuyYEFm+S3ok0BD7cRSm
        gRe5eEVwRIJ/Wq4JJJjaYegcf/PgUXcqGafSxTjO2+m9423T9c4ainHE4h0WmmAwmGN5XyuSMo6G4
        IoMDvpNQ==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1hyCZu-0001ER-HN; Thu, 15 Aug 2019 11:01:55 +0100
From:   John Keeping <john@metanate.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 1/3] perf map: use zalloc for map_groups
Date:   Thu, 15 Aug 2019 11:01:44 +0100
Message-Id: <20190815100146.28842-1-john@metanate.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190804124434.204da4ac.john@metanate.com>
References: <20190804124434.204da4ac.john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the next commit we will add new fields to map_groups and we need
these to be null if no value is assigned.  The simplest way to achieve
this is to request zeroed memory from the allocator.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
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

