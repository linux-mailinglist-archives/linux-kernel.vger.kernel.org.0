Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BD3C04A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbfFKACn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 20:02:43 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56459 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbfFKACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:02:40 -0400
Received: by mail-qk1-f201.google.com with SMTP id j128so1505179qkd.23
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ud/bw4V77SyFt8nVuKDtI0QWt52VBA0pzrjbI+vip8M=;
        b=kk0H6vSStPZDlSvOiBcvHmiKt0uyf7U/emu5hBkoxJZNRECCT/9XgONiPtPGsjwXas
         bS00kWKrVTsLWp8R3+OgwCWXL/e1eXwmWtKGR9xWFABhLMH/GP7VbBBbMtAADH8RlJZE
         635ItUZ+EyNMqDFj4wDHYP+iWwYJnUkJq/VLA/sSzagMcv8yNHyzTV/MScQsxg6PMin6
         wcF2o328hOVjuYAJ+ThS0qr+DGDcEFwXIIUjep4YqH6z5nMEUhqoyOvhgORv2+yuKFOk
         w8dNZLUUaOGluYrFhZzDNyKdhIurP5CZhWNJPQQEFUXm0cr1Xn1khoAbcDaw7F2HAEHK
         1uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ud/bw4V77SyFt8nVuKDtI0QWt52VBA0pzrjbI+vip8M=;
        b=AS08wZ1hJmK63qE7z76+WGbwAD9ioPK6lTmO35GYboLvVEMcTExX3bKMPV0Fj7xabd
         xJRZYX62dx5GXJ+TO+SpjMc1/JdN7/l8PhBHbkiZ/YJBNGFlu09Oe/EcpS5glO3nmcvB
         YjF0Odhr+afGWtAv2KmJ18DSjwvxAazCmoQVtI1qbp5krPL6DO5U58SNcxzoeyLUDske
         UIWiy2VwbR1JOe+7n5X7eY4QPa7Y2Khm1XyVM+7ziwIj8RhyHNOa4dPTO6/Z2pL39Vf0
         82b98qWIuW7XDHLt1i9IcFCL+45XuOGamzk846k/SLB2hLMAm1Ou8y7/WorFLSNs+rwa
         cWWQ==
X-Gm-Message-State: APjAAAUORYF59Y8GvP/Dg/kR2/TR8iuIjvk03VtF8/Ba6q8UVJbfHrPG
        beHmrMD6z+Q9dD7CHSPBPGSK8ik7/ZGr0uGuEEO94Det7HvIpi0UDqVplrBV4cE/xZtoe2A0Rle
        vmPhfApyH1iRs2FWdCQO+YNeVWpOWG28I8n01XWYPo3iVJVJUyBPMYZySrExn/iKZXwQ=
X-Google-Smtp-Source: APXvYqzn3zeeYknmiyQc0md/9thoqlQOR8cqsPllJeod0MANm1hDOtxcav0Y3UAZFrNPROu0Cl6Xt8VrEA==
X-Received: by 2002:a0c:d196:: with SMTP id e22mr59145391qvh.75.1560211359922;
 Mon, 10 Jun 2019 17:02:39 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:02:30 -0700
In-Reply-To: <20190611000230.152670-1-fengc@google.com>
Message-Id: <20190611000230.152670-4-fengc@google.com>
Mime-Version: 1.0
References: <20190611000230.152670-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [RESEND PATCH v3 3/3] dma-buf: add show_fdinfo handler
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

The show_fdinfo handler exports the same information available through
debugfs on a per-buffer basis.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Chenbo Feng <fengc@google.com>
---
 drivers/dma-buf/dma-buf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index c1da5f9ce44d..c4efc272fc34 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -381,6 +381,20 @@ static long dma_buf_ioctl(struct file *file,
 	}
 }
 
+static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
+{
+	struct dma_buf *dmabuf = file->private_data;
+
+	seq_printf(m, "size:\t%zu\n", dmabuf->size);
+	/* Don't count the temporary reference taken inside procfs seq_show */
+	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
+	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
+	mutex_lock(&dmabuf->lock);
+	if (dmabuf->name)
+		seq_printf(m, "name:\t%s\n", dmabuf->name);
+	mutex_unlock(&dmabuf->lock);
+}
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_release,
 	.mmap		= dma_buf_mmap_internal,
@@ -390,6 +404,7 @@ static const struct file_operations dma_buf_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= dma_buf_ioctl,
 #endif
+	.show_fdinfo	= dma_buf_show_fdinfo,
 };
 
 /*
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

