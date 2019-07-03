Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A705E6C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGCOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:32:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:32:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EWCwJ3327574
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:32:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EWCwJ3327574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164333;
        bh=Z9akKVXthSQ1diJEYxsZKafQroP9LWqtZrxos/7+oO4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x9V6cAiBJkNUts4bJlnYGWwgO9EjQrUrD3/ssfF5X1+IpxX9dN7SdlC9KZNNVKm+p
         8wxfODOvejAZuqosN73Fgm/mCFbe+V7FnHaPQG2vvXXWORRv2bOen522J1wHUFqGLt
         8gKDnapkm7dWBfJUzTIHmC7J+rttghK7ymG3YwD8gP3RDngUUDWKDxIsKGIxy6fTVl
         JyxVdi+XW18ciw25JrPxKfYF2eH1oSV8SNlagLztdvfSEJV6FjyRUvK9g3zUZQRf3I
         qkQua1/2aLEnXCcly7hRCUIPa7DFCGT8dOM5NYgQC798nyQpFwFTb56dWmOhepG6Kn
         LCUPQtZqGGztg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EWCa33327571;
        Wed, 3 Jul 2019 07:32:12 -0700
Date:   Wed, 3 Jul 2019 07:32:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0c69b93112428d43b8c103d032143ea89b895d43@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        williams@redhat.com, andre.goddard@gmail.com, jolsa@kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com, namhyung@kernel.org,
          jolsa@kernel.org, andre.goddard@gmail.com, williams@redhat.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190702121240.GB12694@krava>
References: <20190702121240.GB12694@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] objtool: Fix build by linking against
 tools/lib/ctype.o sources
Git-Commit-ID: 0c69b93112428d43b8c103d032143ea89b895d43
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0c69b93112428d43b8c103d032143ea89b895d43
Gitweb:     https://git.kernel.org/tip/0c69b93112428d43b8c103d032143ea89b895d43
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Tue, 2 Jul 2019 14:12:40 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 10:49:31 -0300

objtool: Fix build by linking against tools/lib/ctype.o sources

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
