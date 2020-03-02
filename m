Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1E175285
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 05:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCBEM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 23:12:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCBEM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:12:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so4875711pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaNPcBjkoKZw1bZcJWbUbEpJEQzWw7qCsLqY7OuM15k=;
        b=oWp+xew/5VjbY2VZwDp/ZZ+7rQIDc5nONr9JZ0WBHtYgxkp8TZKiW6Xt4YDwrvz/wQ
         48yqizhHxj8W+QO0pIzDkLiTUq8OlPJp90EVOR8A/tYZgWea2xDVx9T89gpr0Xd3WfN3
         T0EeKnLT5zM4RdcMPkPrY5pyjmF83jONU0rms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaNPcBjkoKZw1bZcJWbUbEpJEQzWw7qCsLqY7OuM15k=;
        b=g/qDqvzih/OzfULdd0vefrALv4HiQ4J4+0TwBdOyJYVQVBMY7xl/2MdmednHAGkbqT
         v4sUHv5++a4sR54VGUqTTLyvbOnKkzLg/lboKdtAhtQ5aW/1THizYoTr9ZmLo89j0Mnk
         LU8ljIXBUIhX+0AsaRIvusDiYI8MEJW6BodIdm6tIvx9og/e3MVfWwBCnmF4nZZOwn9O
         OD3mN7g6Es3mDsz86ioxOQYu/GJImBHi6bOpFA8ZaD/rdlVSjH/kXnK2Ie+5xfa7jkMV
         OdzHgV0GBb/X+xN4BYgWBppqRzi2FTuiinr8NgGABPs+WENdzGC4FKKlJvMCqsmTWOgy
         HRCQ==
X-Gm-Message-State: APjAAAXazBmYsZlu6juoJmYUTfkkrnXvk6+ajVWcPWGOqisnlxIFixSI
        T0NhpLbnDDFhaiaoctiJnA0wwQ==
X-Google-Smtp-Source: APXvYqxV8HL12nYDfQCZsn/ISpkGM1DIsy5iTaoNK/U3rk4TatYUKSuRZ0YeY+zUlf2XkmWLJvKI5g==
X-Received: by 2002:a63:2b0a:: with SMTP id r10mr18087328pgr.213.1583122375798;
        Sun, 01 Mar 2020 20:12:55 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d82sm1698114pfd.187.2020.03.01.20.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:12:55 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 06/11] videobuf2: factor out planes prepare/finish functions
Date:   Mon,  2 Mar 2020 13:12:08 +0900
Message-Id: <20200302041213.27662-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302041213.27662-1-senozhatsky@chromium.org>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code, no functional changes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/common/videobuf2/videobuf2-core.c   | 52 +++++++++++--------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 3ca0545db7ee..c2a1eadb26cf 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -296,6 +296,32 @@ static void __vb2_buf_dmabuf_put(struct vb2_buffer *vb)
 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
 }
 
+/*
+ * __vb2_buf_mem_prepare() - call ->prepare() on buffer's private memory
+ * to sync caches
+ */
+static void __vb2_buf_mem_prepare(struct vb2_buffer *vb)
+{
+	unsigned int plane;
+
+	for (plane = 0; plane < vb->num_planes; ++plane)
+		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
+	vb->synced = 1;
+}
+
+/*
+ * __vb2_buf_mem_finish() - call ->finish on buffer's private memory
+ * to sync caches
+ */
+static void __vb2_buf_mem_finish(struct vb2_buffer *vb)
+{
+	unsigned int plane;
+
+	for (plane = 0; plane < vb->num_planes; ++plane)
+		call_void_memop(vb, finish, vb->planes[plane].mem_priv);
+	vb->synced = 0;
+}
+
 /*
  * __setup_offsets() - setup unique offsets ("cookies") for every plane in
  * the buffer.
@@ -951,7 +977,6 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	unsigned long flags;
-	unsigned int plane;
 
 	if (WARN_ON(vb->state != VB2_BUF_STATE_ACTIVE))
 		return;
@@ -971,12 +996,8 @@ void vb2_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state state)
 	dprintk(4, "done processing on buffer %d, state: %d\n",
 			vb->index, state);
 
-	if (state != VB2_BUF_STATE_QUEUED) {
-		/* sync buffers */
-		for (plane = 0; plane < vb->num_planes; ++plane)
-			call_void_memop(vb, finish, vb->planes[plane].mem_priv);
-		vb->synced = 0;
-	}
+	if (state != VB2_BUF_STATE_QUEUED)
+		__vb2_buf_mem_finish(vb);
 
 	spin_lock_irqsave(&q->done_lock, flags);
 	if (state == VB2_BUF_STATE_QUEUED) {
@@ -1301,7 +1322,6 @@ static int __buf_prepare(struct vb2_buffer *vb)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	enum vb2_buffer_state orig_state = vb->state;
-	unsigned int plane;
 	int ret;
 
 	if (q->error) {
@@ -1345,11 +1365,7 @@ static int __buf_prepare(struct vb2_buffer *vb)
 		return ret;
 	}
 
-	/* sync buffers */
-	for (plane = 0; plane < vb->num_planes; ++plane)
-		call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
-
-	vb->synced = 1;
+	__vb2_buf_mem_prepare(vb);
 	vb->prepared = 1;
 	vb->state = orig_state;
 
@@ -1969,14 +1985,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
 				call_void_vb_qop(vb, buf_request_complete, vb);
 		}
 
-		if (vb->synced) {
-			unsigned int plane;
-
-			for (plane = 0; plane < vb->num_planes; ++plane)
-				call_void_memop(vb, finish,
-						vb->planes[plane].mem_priv);
-			vb->synced = 0;
-		}
+		if (vb->synced)
+			__vb2_buf_mem_finish(vb);
 
 		if (vb->prepared) {
 			call_void_vb_qop(vb, buf_finish, vb);
-- 
2.25.0.265.gbab2e86ba0-goog

