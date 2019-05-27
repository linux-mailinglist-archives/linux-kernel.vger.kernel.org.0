Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697902B4EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfE0MXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:23:13 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:47220 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:23:12 -0400
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id HQPB200053XaVaC01QPBcm; Mon, 27 May 2019 14:23:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEel-0001Ts-0U; Mon, 27 May 2019 14:23:11 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEek-0001Wv-UV; Mon, 27 May 2019 14:23:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] perf: Spelling s/EACCESS/EACCES/
Date:   Mon, 27 May 2019 14:23:09 +0200
Message-Id: <20190527122309.5840-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct spelling is EACCES:

include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ab99c7b652d41b1..10569e25b5a9b656 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -289,7 +289,7 @@ struct pmu {
 	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
 	 *  -EINVAL	-- @event is for this PMU but @event is not valid
 	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
-	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
+	 *  -EACCES	-- @event is for this PMU, @event is valid, but no privilidges
 	 *
 	 *  0		-- @event is for this PMU and valid
 	 *
-- 
2.17.1

