Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788AB122290
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 04:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfLQDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 22:21:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46652 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfLQDV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:21:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so3891521pjq.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLtgY/i7b05+S0YBZciCIKSTFFVYN6319xkmCCskTpQ=;
        b=oZeCVq/hPIb3xxcfajQ5UCYzJhDjrTKoI88hT6q9n5jtZhfAczWwh2b87k3RDH/L7x
         VtpK3IlBurnJzyYXucvjKhimVHVfjHzNnAP2J7W5g1XoMGLLsLf2tr5vWsanGgKjQSVN
         ZVeIy69+i79n+vQdHPu0kw/MSdgWwPmQd+yGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLtgY/i7b05+S0YBZciCIKSTFFVYN6319xkmCCskTpQ=;
        b=a7LoWrjQKYhCFyzxaIZa5J4+fKbVOAcdFQOWJmzCAVyYLuTEi9OheUFOIg3qAUBXUM
         Xr2KmRjtVMx11QyZgCfNHzzJN2Apax8HyaRxS+2Fnb2zzRcwFOM2bS5iACa/EM+BNC+o
         +h+EyWW+1tUkALfxHqWKbLzszD+9OuHtQcur5URzB1XzxmEiI9JHv+2E9aOlfPgd0QZJ
         3xQWerEIIANgMM8kN93Pot201kp7JFWrBP7wYUF0kzFwKX1Jc57J9ZJ4dDLfoNWUPk+3
         wHMKCorWccUMFYJRmPCj2bQi0PDCNNqmhDTGJRJrV/p4J802XeN406qNUnmB+KzWfn7y
         ADZg==
X-Gm-Message-State: APjAAAUfUzS7tZU7Ezg6Mf6Nfm3nkkarLH+S4g4JgnGYDw26O4hq2Aqw
        18mqeNr5OUxmfwgl8QlZg85gbg==
X-Google-Smtp-Source: APXvYqy9neE00p2QbLZnLgRtVcCyK+YWY7iVQlwytjfc2kPnP1pU+M0e4nObBdie3cLEqsIJ7ZArgw==
X-Received: by 2002:a17:902:fe05:: with SMTP id g5mr20418282plj.3.1576552889059;
        Mon, 16 Dec 2019 19:21:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id j3sm24387455pfi.8.2019.12.16.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:21:28 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF queues
Date:   Tue, 17 Dec 2019 12:20:32 +0900
Message-Id: <20191217032034.54897-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191217032034.54897-1-senozhatsky@chromium.org>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA-exporter is supposed to handle cache syncs, so we can
avoid ->prepare()/->finish() syncs from videobuf2 core for
DMABUF buffers.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 1762849288ae..2b9d3318e6fb 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -341,8 +341,22 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
 				   struct vb2_buffer *vb,
 				   struct v4l2_buffer *b)
 {
-	vb->need_cache_sync_on_prepare = 1;
+	/*
+	 * DMA exporter should take care of cache syncs, so we can avoid
+	 * explicit ->prepare()/->finish() syncs.
+	 */
+	if (q->memory == VB2_MEMORY_DMABUF) {
+		vb->need_cache_sync_on_finish = 0;
+		vb->need_cache_sync_on_prepare = 0;
+		return;
+	}
 
+	/*
+	 * For other ->memory types we always need ->prepare() cache
+	 * sync. ->finish() cache sync, however, can be avoided when queue
+	 * direction is TO_DEVICE.
+	 */
+	vb->need_cache_sync_on_prepare = 1;
 	if (q->dma_dir != DMA_TO_DEVICE)
 		vb->need_cache_sync_on_finish = 1;
 	else
-- 
2.24.1.735.g03f4e72817-goog

