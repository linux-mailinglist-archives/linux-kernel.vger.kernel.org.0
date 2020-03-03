Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A923F17835A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 20:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgCCTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 14:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgCCTsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:48:43 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5E4215A4;
        Tue,  3 Mar 2020 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583264922;
        bh=agBSg6xfa4NmUWzblX7S1g3hrA1NtlKGQJ5KXkt+MA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9dtSdKBbE/nwOFKqtLLTp9Aqip0+NEzuVGv8osb3f3Ily8/HsTOy/C8hzOTBDiAJ
         vFFuvuNsjqRkm6MpWWVxNWt3XNUDOiAIeA8atAnsAOMhUbfOjxg2RjkftAQwTihM9G
         4Z+4qsr/itALiMjo5yNZE6kYSsryx5NS5hSuyROI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/5] perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files
Date:   Tue,  3 Mar 2020 16:48:25 -0300
Message-Id: <20200303194827.6461-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303194827.6461-1-acme@kernel.org>
References: <20200303194827.6461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Make the code more compact by using asprintf() instead of malloc()+strncpy() which also uses
less memory and avoids these warnings with gcc 10:

    CC       /tmp/build/perf/util/cloexec.o
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:271:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘sys_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
  In file included from /usr/include/string.h:495,
                   from util/parse-events.h:12,
                   from util/parse-events.c:18:
  In function ‘strncpy’,
      inlined from ‘tracepoint_id_to_path’ at util/parse-events.c:273:5:
  /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ offset [275, 511] from the object at ‘evt_dirent’ is out of the bounds of referenced subobject ‘d_name’ with type ‘char[256]’ at offset 19 [-Werror=array-bounds]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/dirent.h:61,
                   from util/parse-events.c:5:
  util/parse-events.c: In function ‘tracepoint_id_to_path’:
  /usr/include/bits/dirent.h:33:10: note: subobject ‘d_name’ declared here
     33 |     char d_name[256];  /* We must not include limits.h! */
        |          ^~~~~~
    CC       /tmp/build/perf/util/call-path.o

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200302145535.GA28183@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..a14995835d85 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
 				path = zalloc(sizeof(*path));
 				if (!path)
 					return NULL;
-				path->system = malloc(MAX_EVENT_LENGTH);
-				if (!path->system) {
+				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
 					free(path);
 					return NULL;
 				}
-				path->name = malloc(MAX_EVENT_LENGTH);
-				if (!path->name) {
+				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
 					zfree(&path->system);
 					free(path);
 					return NULL;
 				}
-				strncpy(path->system, sys_dirent->d_name,
-					MAX_EVENT_LENGTH);
-				strncpy(path->name, evt_dirent->d_name,
-					MAX_EVENT_LENGTH);
 				return path;
 			}
 		}
-- 
2.21.1

