Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2619C138F74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 11:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAMKoM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jan 2020 05:44:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728787AbgAMKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:44:09 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-RqTpWpiSO0Gysgeznoudqw-1; Mon, 13 Jan 2020 05:44:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 939448D5E93;
        Mon, 13 Jan 2020 10:44:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C65E5C21B;
        Mon, 13 Jan 2020 10:44:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH 2/2] perf/ui/gtk: Fix gtk2 build
Date:   Mon, 13 Jan 2020 11:43:58 +0100
Message-Id: <20200113104358.123511-2-jolsa@kernel.org>
In-Reply-To: <20200113104358.123511-1-jolsa@kernel.org>
References: <20200113104358.123511-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: RqTpWpiSO0Gysgeznoudqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria reported issue when detecting gtk2 on Fedora 31,
where some types got deprecated:

  /usr/include/gtk-2.0/gtk/gtktypeutils.h:236:1: error: ‘GTypeDebugFlags’ is deprecated [-Werror=deprecated-declarations]
    236 | void            gtk_type_init   (GTypeDebugFlags    debug_flags);

Fixing this for perf by allowing the compile to pass
with deprecated symbols via -Wno-deprecated-declarations.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-kg8fqsa0bgq3suc9ubonh4xu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/ui/gtk/Build      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f30a89046aa3..7ac0d8088565 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -197,7 +197,7 @@ $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
 $(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
 
 $(OUTPUT)test-gtk2-infobar.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index 9b5d5cbb7af7..eef708c502f4 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -1,4 +1,4 @@
-CFLAGS_gtk += -fPIC $(GTK_CFLAGS)
+CFLAGS_gtk += -fPIC $(GTK_CFLAGS) -Wno-deprecated-declarations
 
 gtk-y += browser.o
 gtk-y += hists.o
-- 
2.24.1

