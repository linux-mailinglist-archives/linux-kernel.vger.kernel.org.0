Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7065A21638
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfEQJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 05:25:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34440 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfEQJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:25:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so4937309wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fq3qggbvMmKlUmJPKM8jOY0rCZq4or8EQED5if34yzQ=;
        b=nk2IUJ/kjh4krjgUGUKSrTbk3y6M+yF+1hyYfCdswnW9AKfLyX42XFFWO10ikjnMn/
         rHMjDjjygG2xVnagvqoK5or10W9UitPuzDx8uTsIXTyiuEkNnpoqBWpPhGNU3pJdy0vH
         RDhlDaiU9oTPV8EbtjAYs8M6v7RLrHqW1CTMpsnWwdYU77OI/dofXVilECl5lx+PzueV
         SF1MRZ6cGejQ+Oc2Z0aIxFuXsUCdqIn0ClCgXhAHjAKZPQAC0iynzf/iqcTjSMbZo8D6
         ba+Gu7NAO+TF9Ktxu4/z6bzwvWcRUmkygqoj2uvR/kMeYYC2L/5QeS8S5LtPBHBFU6Cm
         +RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fq3qggbvMmKlUmJPKM8jOY0rCZq4or8EQED5if34yzQ=;
        b=c6PpY+Lk0TcrIHf5Osjb6caamR4/9VNGJ4ADtCkwHy2CjlbYzQil0uUUzthp+r4U2q
         AN7tPl7rbjb60MjkRleXuPaxEYlCgXxTJJ+ZBbfa3DgDpfafKDkkXsUWPSD1IaCWTmDh
         GJJ76zWw6G52S/aSddzJ0zOYDLWaeXbZHNcTrUfgTzCqX3NcgV31ZtaxQGW3MJI/9VZ1
         +7KM+MuLSLhBnnUvp+MLpiecw3qqgyUPP68ZTLFwTjP25FLsGfxvLGU6LYcpEYTi6QK4
         dYwCDZPtKvwewI9c3Z8C5AtRCmfXXCIW99C74mxhmVJr5vQ2n8VggJI/errB1id7EPCG
         /2nA==
X-Gm-Message-State: APjAAAWNAeH14OvSzF5frBw1tURqqK6jj9QmxYsYsDneHOTZlVBcrhev
        dBUXnPEkIpu9uGCEvVvi2l6wBreK
X-Google-Smtp-Source: APXvYqzzd6fDMGlW8IDjoJtTwj+KrBrWDkuYeiWyAdgI+X2tVRde4I8tzXBPfJ3mR5RIlKYXChyaIg==
X-Received: by 2002:adf:9022:: with SMTP id h31mr5594268wrh.46.1558085143149;
        Fri, 17 May 2019 02:25:43 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id j206sm9003862wma.47.2019.05.17.02.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 02:25:42 -0700 (PDT)
Date:   Fri, 17 May 2019 11:25:02 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: silence GCC 9 array bounds warning
Message-ID: <20190517092502.GA22779@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with GCC 9, -Warray-bounds detects cases when memset is called
starting on a member of a struct but the size to be cleared ends up
writing over further members.

Such a call happens in the trace code to clear, at once, all members
after and including `seq` on struct trace_iterator:

    In function 'memset',
        inlined from 'ftrace_dump' at kernel/trace/trace.c:8914:3:
    ./include/linux/string.h:344:9: warning: '__builtin_memset' offset
    [8505, 8560] from the object at 'iter' is out of the bounds of
    referenced subobject 'seq' with type 'struct trace_seq' at offset
    4368 [-Warray-bounds]
      344 |  return __builtin_memset(p, c, size);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to avoid GCC complaining about it, we compute the address
ourselves by adding the offsetof distance instead of referring
directly to the member.

Since there are two places doing this clear (trace.c and trace_kdb.c),
take the chance to move the workaround into a single place in
the internal header.

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 kernel/trace/trace.c     |  7 +------
 kernel/trace/trace.h     | 14 ++++++++++++++
 kernel/trace/trace_kdb.c |  7 +------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca1ee656d6d8..37990532351b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8627,12 +8627,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 		cnt++;
 
-		/* reset all but tr, trace, and overruns */
-		memset(&iter.seq, 0,
-		       sizeof(struct trace_iterator) -
-		       offsetof(struct trace_iterator, seq));
-		iter.iter_flags |= TRACE_FILE_LAT_FMT;
-		iter.pos = -1;
+		trace_iterator_reset(&iter);
 
 		if (trace_find_next_entry_inc(&iter) != NULL) {
 			int ret;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..80ad656f43eb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1964,4 +1964,18 @@ static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 
 extern struct trace_iterator *tracepoint_print_iter;
 
+/* reset all but tr, trace, and overruns */
+static __always_inline void trace_iterator_reset(struct trace_iterator * iter)
+{
+	/*
+	 * Equivalent to &iter->seq, but avoids GCC 9 complaining about
+	 * overwriting more members than just iter->seq (-Warray-bounds)
+	 */
+	memset((char *)(iter) + offsetof(struct trace_iterator, seq), 0,
+	       sizeof(struct trace_iterator) -
+	       offsetof(struct trace_iterator, seq));
+	iter->iter_flags |= TRACE_FILE_LAT_FMT;
+	iter->pos = -1;
+}
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 810d78a8d14c..0a2a166ee716 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -41,12 +41,7 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
 
 	kdb_printf("Dumping ftrace buffer:\n");
 
-	/* reset all but tr, trace, and overruns */
-	memset(&iter.seq, 0,
-		   sizeof(struct trace_iterator) -
-		   offsetof(struct trace_iterator, seq));
-	iter.iter_flags |= TRACE_FILE_LAT_FMT;
-	iter.pos = -1;
+	trace_iterator_reset(&iter);
 
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
-- 
2.17.1

