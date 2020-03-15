Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216AC185E56
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgCOP4V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 15 Mar 2020 11:56:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728634AbgCOP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:56:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-XA3QFsmIPzmvSf13aYxi3Q-1; Sun, 15 Mar 2020 11:56:16 -0400
X-MC-Unique: XA3QFsmIPzmvSf13aYxi3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A42A3477;
        Sun, 15 Mar 2020 15:56:12 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B79C5DA76;
        Sun, 15 Mar 2020 15:56:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH perf/urgent] perf expr: Fix copy/paste mistake
Date:   Sun, 15 Mar 2020 16:56:09 +0100
Message-Id: <20200315155609.603948-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy/paste leftover from recent refactor.

Fixes: 26226a97724d ("perf expr: Move expr lexer to flex")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.l | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 1928f2a3dddc..eaad29243c23 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -79,10 +79,10 @@ symbol		{spec}*{sym}*{spec}*{sym}*
 	{
 		int start_token;
 
-		start_token = parse_events_get_extra(yyscanner);
+		start_token = expr_get_extra(yyscanner);
 
 		if (start_token) {
-			parse_events_set_extra(NULL, yyscanner);
+			expr_set_extra(NULL, yyscanner);
 			return start_token;
 		}
 	}
-- 
2.24.1

