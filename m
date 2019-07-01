Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6C21EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfEQTlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfEQTl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:41:29 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7660E2087B;
        Fri, 17 May 2019 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122088;
        bh=U6WHpdZMUQhCOrVHyGnlHHKWrkzMb4yxZqaJLz5Vpm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AACXpLqUR+v50hSgMLXyKV6i8KmUwOoZxTWGSGx2uAmLgeVwzwLMTrJk/Tz43lGEv
         lmUQ58Ha3FqpzaSOjAz7ddWuFgpzh5qiAJTWX4GNjR3Rut3a80ccb0iMOWOw4K92My
         Oyd+QdRWmcRE/t4Je+BJSNed2fUEfl+eNJynYFCQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 70/73] perf docs: Add description for stderr
Date:   Fri, 17 May 2019 16:36:08 -0300
Message-Id: <20190517193611.4974-71-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

'perf report' displays recorded data on the screen and emits warnings
and debug messages in the status line (last one on screen).

perf also supports the possibility to write all debug messages to stderr
(instead of writing them to the status line).

This is achieved with the following command:

  # ./perf --debug stderr=1 report -vvvvv -i ~/fast.data 2>/tmp/2
  # ll /tmp/2
  -rw-rw-r-- 1 tmricht tmricht 5420835 May  7 13:46 /tmp/2
  #

The usage of variable stderr=1 is not documented, so add it to the perf
man page.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190513080220.91966-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 864e37597252..401f0ed67439 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -22,6 +22,8 @@ OPTIONS
 	  verbose          - general debug messages
 	  ordered-events   - ordered events object debug messages
 	  data-convert     - data convert command debug messages
+	  stderr           - write debug output (option -v) to stderr
+	                     in browser mode
 
 --buildid-dir::
 	Setup buildid cache directory. It has higher priority than
-- 
2.20.1

