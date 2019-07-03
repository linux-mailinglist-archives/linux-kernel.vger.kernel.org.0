Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B215DCE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfGCD2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 23:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfGCD17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:27:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E85B21850;
        Wed,  3 Jul 2019 03:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124478;
        bh=99d55T9cuUfMP0EyyCJQ1FLUdvQZNjVn+eTsenbN3dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvJ6zt1rKsJm9p/22k9yvZO7K+m69fELbHfcwp4LHzoHGF/PSjCeXoAGkEl/1C/Rc
         Knr8hPThlCAjJG6a9voPmKiXkyLITZM6Mrj37G+9i1QFSkhfB1HpwcNgHLP3+7vllt
         enTAxy6DlPdMFYTsn8s/THROgQRUVZLV9DkPJ5DQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/18] objtool: Fix build by linking against tools/lib/ctype.o sources
Date:   Wed,  3 Jul 2019 00:27:29 -0300
Message-Id: <20190703032746.21692-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Fix objtool build, because it adds _ctype dependency via isspace call patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 7bd330de43fd ("tools lib: Adopt skip_spaces() from the kernel sources")
Link: http://lkml.kernel.org/r/20190702121240.GB12694@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/objtool/Build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 749becdf5b90..8dc4f0848362 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -9,6 +9,7 @@ objtool-y += special.o
 objtool-y += objtool.o
 
 objtool-y += libstring.o
+objtool-y += libctype.o
 objtool-y += str_error_r.o
 
 CFLAGS += -I$(srctree)/tools/lib
@@ -17,6 +18,10 @@ $(OUTPUT)libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 $(OUTPUT)str_error_r.o: ../lib/str_error_r.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-- 
2.20.1

