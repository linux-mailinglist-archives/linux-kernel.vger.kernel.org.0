Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465939A40D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 01:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfHVXsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 19:48:33 -0400
Received: from lekensteyn.nl ([178.21.112.251]:36351 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfHVXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=f68SK7i0b0WDwB3LuR917Oyk3WvCNjYTtI5Tug1lqAA=;
        b=OcNkOUqpjOQ0190g4OTrLWCdHt1WfSK3xH5AM5kcXam9AMO1YPK2kLyv3X4Ge64jO6YZNzWci4EQX8hCjWQO/g10tzc4Ft/8zcxuRHqAl2+8o+/HIdu30qbE592RsvBgKTAUCLiL2uj7C0/VPJ0fDg2myMXzkyA+YtypghwqMKrjHVSCRe3kWjMNxU4CVIxR8fSRoaTopIu/NGcfKLDbN0TduJJGf9K4iw74IJXJpP+Wb3Zc04+LaGJNF18wgKgcDYs6VneaRtOc3eJ02gceWKboofngUhu8q69lCB6SHrKMNg/P3q5biFzf+jgG8nWkLzBsD82pJs4tJtH6MIe/PQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1i0woa-0006I2-6J; Fri, 23 Aug 2019 01:48:24 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH] docs: ftrace: clarify when tracing is disabled by the trace file
Date:   Fri, 23 Aug 2019 00:48:23 +0100
Message-Id: <20190822234823.18594-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=unavailable autolearn_force=no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current text could mislead the user into believing that only read()
disables tracing. Clarify that any open() call that requests read access
disables tracing.

Link: https://lkml.kernel.org/r/CAADnVQ+hU6QOC_dPmpjnuv=9g4SQEeaMEMqXOS2WpMj=q=LdiQ@mail.gmail.com
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 Documentation/trace/ftrace.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..965be5c9afb3 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -125,7 +125,8 @@ of ftrace. Here is a list of some of the key files:
 
 	This file holds the output of the trace in a human
 	readable format (described below). Note, tracing is temporarily
-	disabled while this file is being read (opened).
+	disabled when the file is open for reading. Once all readers
+	are closed, tracing is re-enabled.
 
   trace_pipe:
 
@@ -139,8 +140,9 @@ of ftrace. Here is a list of some of the key files:
 	will not be read again with a sequential read. The
 	"trace" file is static, and if the tracer is not
 	adding more data, it will display the same
-	information every time it is read. This file will not
-	disable tracing while being read.
+	information every time it is read. Unlike the
+	"trace" file, opening this file for reading will not
+	temporarily disable tracing.
 
   trace_options:
 
@@ -3153,7 +3155,10 @@ different. The trace is live.
 
 
 Note, reading the trace_pipe file will block until more input is
-added.
+added. This is contrary to the trace file. If any process opened
+the trace file for reading, it will actually disable tracing and
+prevent new entries from being added. The trace_file file does
+not have this limitation.
 
 trace entries
 -------------
-- 
2.22.0

