Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB060E63BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 16:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfJ0Pfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 11:35:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36690 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJ0Pf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:35:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so7317412wrt.3;
        Sun, 27 Oct 2019 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3S/MmicvH98fAFv7o1xeLhzn/gzJ5CI3MhpPlz2BcJs=;
        b=CcdPzJ9+2ZRxapFzTiki5D1Br/NGktw/DKIvgg1sFKFkcyUbctXv6NKmMl5Q0WBck2
         AevUl2+87zU2Wa3LUz5SIa/40XXvW0STac34I+g5S9uIhqiBzpAL+kt4tuHtrIViewJ2
         +xxeh2EYNdZZ1UbGHzpnL+3K4Pp9u2lxrGVyEzukgaXO3ho17A83lOGvDpMMTRAIGsiI
         znMMrfeX2pvkFNlTXYRTXurJRwYgQ4kC75K6IBQQG9sCLb1bREpZfGSnHAXwGUZNV/gk
         kKXDTH7NjOrJLJFwknfj0uthYQJOL8GJhoHALsu6pkkNz24rtgoumHttRhgNyeyvcvjL
         IuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3S/MmicvH98fAFv7o1xeLhzn/gzJ5CI3MhpPlz2BcJs=;
        b=XWOfdlUJ7oZsMIXcjzZZWprRDm4w7/oscknJFzVgrWPHD7yf174PEgB3BZMyWFEeYT
         oR1yl82//r11vKKWtFgzjN1ROrQhGXmPxHlwJjVOoOM5RiRp98HhJSWw1nt5VPjHiBOV
         cKqhiOPlQjq0Bl1HJpEUwCxqrG2gKLY2dTBtmmQQ+XW4lFNP6jeRMjNng4umMYZaANA+
         yaVh/KcXs6piAFnMoI1vVuIAWPq1wSZoI5+B9uciYmZK/PbD7hq8Gg5bFAwdNLtOux36
         uoTx7JknYSP4tn7nxL6QeygvwyDZhORi3sb/mHq4yAzoVuaN7eVwjg+Vln7a90KK1ZJm
         +9GA==
X-Gm-Message-State: APjAAAVtwstBRjC29BWYbnTPP9qCGe1yrkbDmtxa+9RtRZdNmdTbBQWg
        E0tk5qMjySUsR8g5fJuhYugBufxx
X-Google-Smtp-Source: APXvYqzOk5Z8yCY5T8Tn2iSvfrj1fz85HaQ79/TluViPeQbQUT1Mf6fDDxvTjV8l8pnyQE07ciehXg==
X-Received: by 2002:adf:94e2:: with SMTP id 89mr10368960wrr.259.1572190526555;
        Sun, 27 Oct 2019 08:35:26 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id k3sm4226282wrn.95.2019.10.27.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:35:26 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: merge io_submit_sqes and io_ring_submit
Date:   Sun, 27 Oct 2019 18:35:05 +0300
Message-Id: <e6171fc9b7fa93d93d2b42032420147053c7eec8.1572189860.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572189860.git.asml.silence@gmail.com>
References: <cover.1572189860.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_submit_sqes() and io_ring_submit() are mostly identical now, except
for several flags. And it's error-prone, as usually requires
synchcronously changing both of them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 88 +++++++++------------------------------------------
 1 file changed, 15 insertions(+), 73 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f65727f2ba95..949faf14345e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2640,7 +2640,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 }
 
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
-			  bool has_user)
+			  struct file *ring_file, int ring_fd,
+			  bool has_user, bool in_async)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
@@ -2682,10 +2683,12 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		}
 
 out:
+		s.ring_file = ring_file;
 		s.has_user = has_user;
-		s.in_async = true;
-		s.needs_fixed_file = true;
-		trace_io_uring_submit_sqe(ctx, true, true);
+		s.in_async = in_async;
+		s.needs_fixed_file = in_async;
+		s.ring_fd = ring_fd;
+		trace_io_uring_submit_sqe(ctx, true, in_async);
 		io_submit_sqe(ctx, &s, statep, &link);
 		submitted++;
 	}
@@ -2693,7 +2696,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	if (link)
 		io_queue_link_head(ctx, link, &link->submit, shadow_req);
 	if (statep)
-		io_submit_state_end(&state);
+		io_submit_state_end(statep);
+
+	/* Commit SQ ring head once we've consumed all SQEs */
+	io_commit_sqring(ctx);
 
 	return submitted;
 }
@@ -2822,10 +2828,8 @@ static int io_sq_thread(void *data)
 			io_fail_all_sqes(ctx);
 		} else {
 			to_submit = min(to_submit, ctx->sq_entries);
-			inflight += io_submit_sqes(ctx, to_submit,
-						   cur_mm != NULL);
-			/* Commit SQ ring head once we've consumed all SQEs */
-			io_commit_sqring(ctx);
+			inflight += io_submit_sqes(ctx, to_submit, NULL, -1,
+						   cur_mm != NULL, true);
 		}
 	}
 
@@ -2840,69 +2844,6 @@ static int io_sq_thread(void *data)
 	return 0;
 }
 
-static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
-			  struct file *ring_file, int ring_fd)
-{
-	struct io_submit_state state, *statep = NULL;
-	struct io_kiocb *link = NULL;
-	struct io_kiocb *shadow_req = NULL;
-	bool prev_was_link = false;
-	int i, submit = 0;
-
-	if (to_submit > IO_PLUG_THRESHOLD) {
-		io_submit_state_start(&state, ctx, to_submit);
-		statep = &state;
-	}
-
-	for (i = 0; i < to_submit; i++) {
-		struct sqe_submit s;
-
-		if (!io_get_sqring(ctx, &s))
-			break;
-
-		/*
-		 * If previous wasn't linked and we have a linked command,
-		 * that's the end of the chain. Submit the previous link.
-		 */
-		if (!prev_was_link && link) {
-			io_queue_link_head(ctx, link, &link->submit, shadow_req);
-			link = NULL;
-			shadow_req = NULL;
-		}
-		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
-
-		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
-			if (!shadow_req) {
-				shadow_req = io_get_req(ctx, NULL);
-				if (unlikely(!shadow_req))
-					goto out;
-				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
-				refcount_dec(&shadow_req->refs);
-			}
-			shadow_req->sequence = s.sequence;
-		}
-
-out:
-		s.ring_file = ring_file;
-		s.has_user = true;
-		s.in_async = false;
-		s.needs_fixed_file = false;
-		s.ring_fd = ring_fd;
-		submit++;
-		trace_io_uring_submit_sqe(ctx, true, false);
-		io_submit_sqe(ctx, &s, statep, &link);
-	}
-
-	if (link)
-		io_queue_link_head(ctx, link, &link->submit, shadow_req);
-	if (statep)
-		io_submit_state_end(statep);
-
-	io_commit_sqring(ctx);
-
-	return submit;
-}
-
 struct io_wait_queue {
 	struct wait_queue_entry wq;
 	struct io_ring_ctx *ctx;
@@ -4027,7 +3968,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		to_submit = min(to_submit, ctx->sq_entries);
 
 		mutex_lock(&ctx->uring_lock);
-		submitted = io_ring_submit(ctx, to_submit, f.file, fd);
+		submitted = io_submit_sqes(ctx, to_submit, f.file, fd,
+					   true, false);
 		mutex_unlock(&ctx->uring_lock);
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
-- 
2.23.0

