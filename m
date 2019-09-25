Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF439BE35F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505177AbfIYR3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 13:29:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46988 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440306AbfIYR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:29:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so7900592wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbzmetsD6Lz/aWGAxlmMTspSEJY0ESydP11xnAcJuGM=;
        b=u1KuHXdU573uqmfXZ/x1Wvpg+xUcBs8KUqjcBin9/4st2GZYL0dEqYCTlfdBtYlOY6
         sTXOwJhPLMsbXiIKrzf9UgYJZaqVjT8OE+b3/0t9ghw+zYAhz7Dm/U4xPwKHNGGDOcDX
         YPR9NrYQJTTUKaIPbsxjjRdqoJ7nN8ZHN9uAVYAF5fxxlUNYUci37mTLCXVxI7kkX/0T
         8TPAQjqE8EfrgzI7Gi9bZw5ztJUOPttHz02wcNLKMHF7XMM62+lhCDSYZuojrexRQfeN
         Hz53aUQ5U8zUHRBCPp3nQUey43CUM6GV46RaYbBpbxLSeyi/UPHEe0ANGQVsN841hRVb
         J24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbzmetsD6Lz/aWGAxlmMTspSEJY0ESydP11xnAcJuGM=;
        b=I+83/WdAd0VxIbiwIFFaYiysHfd0pF2dtGTERkB+pLMKxZE2eVThlOd6yR5nMJ+dc9
         1MuUt7Rf4dqxhVUDumtkaSdfrHYByiq+sEMdNyg3h0MfTMpUDc0egaF2TNkba3FEC/Zk
         RC/Gb2K5HBMni1lR9Z+BMkiCoWk6e7Td+x65Ys4Pac0hm7EHiERPvuBWTtTSW+6YjMae
         ebiV/0LEPY7yJZS5w9hFQxeuNYP4AnggqrSrOUN5NI3YbStslrijdKBO3P+2ngWV/Fi+
         1jqX/cvmQCY3PT5FHUJi4Fw5GVd/s+mFn0FzCtZzz+VBSHOGT1e3lzFLzhNsBTd1BboP
         4l3Q==
X-Gm-Message-State: APjAAAUjY3zm9ydLiOfQT0uRo9+xe62jBo48cKmFHGI1HHKAXsNAEAOO
        r6gHMHkMfZzs+omOKpjAUGo=
X-Google-Smtp-Source: APXvYqwesHcGIMJ0zEp72wq5LPS0e6dgV2wPk3zLQj4xSSIIZ2Lv+u8hug1AOwyhunY7qAuUGhBzMQ==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr9610105wrn.299.1569432580970;
        Wed, 25 Sep 2019 10:29:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a7sm6142778wra.43.2019.09.25.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 10:29:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Bolvansky <david.bolvansky@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tracing: Fix clang -Wint-in-bool-context warnings in IF_ASSIGN macro
Date:   Wed, 25 Sep 2019 10:29:15 -0700
Message-Id: <20190925172915.576755-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After r372664 in clang, the IF_ASSIGN macro causes a couple hundred
warnings along the lines of:

kernel/trace/trace_output.c:1331:2: warning: converting the enum
constant to a boolean [-Wint-in-bool-context]
kernel/trace/trace.h:409:3: note: expanded from macro
'trace_assign_type'
                IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,
                ^
kernel/trace/trace.h:371:14: note: expanded from macro 'IF_ASSIGN'
                WARN_ON(id && (entry)->type != id);     \
                           ^
264 warnings generated.

Add the implicit '!= 0' to the WARN_ON statement to fix the warnings.

Link: https://github.com/llvm/llvm-project/commit/28b38c277a2941e9e891b2db30652cfd962f070b
Link: https://github.com/ClangBuiltLinux/linux/issues/686
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/trace/trace.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 26b0a08f3c7d..f801d154ff6a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -365,11 +365,11 @@ static inline struct trace_array *top_trace_array(void)
 	__builtin_types_compatible_p(typeof(var), type *)
 
 #undef IF_ASSIGN
-#define IF_ASSIGN(var, entry, etype, id)		\
-	if (FTRACE_CMP_TYPE(var, etype)) {		\
-		var = (typeof(var))(entry);		\
-		WARN_ON(id && (entry)->type != id);	\
-		break;					\
+#define IF_ASSIGN(var, entry, etype, id)			\
+	if (FTRACE_CMP_TYPE(var, etype)) {			\
+		var = (typeof(var))(entry);			\
+		WARN_ON(id != 0 && (entry)->type != id);	\
+		break;						\
 	}
 
 /* Will cause compile errors if type is not found. */
-- 
2.23.0

