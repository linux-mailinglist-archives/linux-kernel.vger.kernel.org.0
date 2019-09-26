Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC4BE984
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfIZAds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbfIZAdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:46 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C5F222C4;
        Thu, 26 Sep 2019 00:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458025;
        bh=8COpvKSop04QGbUX2tWofzLcn1BWXIq9NmOn50fqxrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whOHBShurf3PPJYEtdkCh62Q0R1LFGANNDjSieOJp/LFrBplNOYLUhZTuW0mfClRe
         bUYACr46WdZ+agsOJjSwVnsl4iMBW5PHD+DImC9iJJmuNPnWai2hdgMlJ98UvnMI5Y
         pm07VXXLvbDh35jsASnuEs2haEtNPVddmoOK2xJU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/66] libtraceevent: Add tep_get_event() in event-parse.h
Date:   Wed, 25 Sep 2019 21:31:49 -0300
Message-Id: <20190926003244.13962-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

The tep_get_event() function is an official libtracevent API, described
in the library man pages. However, it cannot be used by the library users because
it is not declared in the event-parse.h file, where all libtracevent APIs are.
The function declaration is added in event-parse.h file.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190808113721.13539-1-tz.stoyanov@gmail.com
Link: http://lore.kernel.org/lkml/20190919212542.058025937@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index d438ee44289f..b77837f75a0d 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -441,6 +441,8 @@ int tep_register_print_string(struct tep_handle *tep, const char *fmt,
 			      unsigned long long addr);
 bool tep_is_pid_registered(struct tep_handle *tep, int pid);
 
+struct tep_event *tep_get_event(struct tep_handle *tep, int index);
+
 #define TEP_PRINT_INFO		"INFO"
 #define TEP_PRINT_INFO_RAW	"INFO_RAW"
 #define TEP_PRINT_COMM		"COMM"
-- 
2.21.0

