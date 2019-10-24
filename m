Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10755E3260
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501943AbfJXM3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 08:29:08 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:51414 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfJXM3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:29:07 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id HQV62100M5USYZQ06QV6xR; Thu, 24 Oct 2019 14:29:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNcEk-0005rv-Ej; Thu, 24 Oct 2019 14:29:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNcEk-0003Fk-CM; Thu, 24 Oct 2019 14:29:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] [trivial] perf: Spelling s/EACCESS/EACCES/, s/privilidge/privilege/
Date:   Thu, 24 Oct 2019 14:29:04 +0200
Message-Id: <20191024122904.12463-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per POSIX, the correct spelling of the error code is EACCES:

include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add POSIX reference,
  - Also correct privilidges in the same line.
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132c29c..68ccc5b1913b485b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -292,7 +292,7 @@ struct pmu {
 	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
 	 *  -EINVAL	-- @event is for this PMU but @event is not valid
 	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
-	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
+	 *  -EACCES	-- @event is for this PMU, @event is valid, but no privileges
 	 *
 	 *  0		-- @event is for this PMU and valid
 	 *
-- 
2.17.1

