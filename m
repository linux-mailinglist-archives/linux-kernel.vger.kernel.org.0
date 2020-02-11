Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A550159CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBKW4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 17:56:24 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45026 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgBKW4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:56:21 -0500
Received: by mail-qt1-f202.google.com with SMTP id k20so13538qtm.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=umSesbTGPsu+nvuQqZ8fY1eTSikUabPzN6xXg7xZJNBVLypMGXMDDOtJRe0wHcws/7
         KVx131mQiaayMu32w+j2ucPHb9I5Eb8itpDFy9EHwUOdRgdnnhnKXgs7u72L/EpOwS2f
         JvJl3PKDTd9Y1naPldNOTFfg9IraAiaHTbUmM5seXxpMlK9aTnTnuqYp3Ud/ljRBeBkc
         WuPfeFuw2yoyip+1AA+8LQghHTNqWGHBzKnlUmuoOyGwGYsCIsIDAnf0JEf3eQDlIhI2
         yKiZaipNfTJ1ATmOxT4/Zj07VxlViiwp1X4wBvuGy6Hc65x02f0NtCx8qf1iy1MOde2k
         odTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=/wUiaE4lRYXVr4XT55eq69Fhu4cwbqd4vz3JObgWLSw=;
        b=HWv60T/usMalYp5clzZmywi9bdZ3O34TtAUMxunisEXdT+Ow+NNRi747zGhrSoA1Pp
         yEsj//AiSmmYDlXzxuHHQzdq0ui25eRgZqPiB7ovBRuZlBe6STI33As+vHZDNMA6xhdX
         pA0ctef3NmbXiU7IBrTLRotbGchA8VQFX3lQZWft0BtuXNDSK1DZrBbxfe81bFmvPeM+
         kabn316j9OmSNlUHcXEoi77884UoZxwiEyTk5IHQhyMQvevr7yof5MGui8b1ghvWEzti
         NIutQICseiIDzB3SellaeCaKIju5bnJ6JBMXukOhLbt+5M8rAeAlcjVSHC5GO5mSjRdU
         HSfQ==
X-Gm-Message-State: APjAAAX5tsx7SH/4RbI3xIn9wpOzzKgE+Vl+Q19Q7VOdU7Fel9KkjJ7O
        pElllzEsxSLdlHmB33c4qH6zU0To0Sc=
X-Google-Smtp-Source: APXvYqyZXCjauD7MRkh/uIhajsG5EI06HCT6AH+BThgzhc0Md1s+7ziwiBW5p3VuX5RjLJnrFmjTcG1OTEs=
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr16528854qtb.142.1581461779511;
 Tue, 11 Feb 2020 14:56:19 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:45 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-5-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 4/6] Wire UFFD up to SELinux
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change gives userfaultfd file descriptors a real security
context, allowing policy to act on them.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 07b0f6e03849..11227b94a5a7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1020,6 +1020,8 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
 {
 	int fd;
 
+	/* Regular inode here is okay: only CAP_SYS_PTRACE callers
+	 * can monitor forks.  */
 	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
 			      O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
@@ -1972,8 +1974,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
-			      O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	fd = anon_inode_getfd2("[userfaultfd]", &userfaultfd_fops, ctx,
+			       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
+			       ANON_INODE_SECURE);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.25.0.225.g125e21ebc7-goog

