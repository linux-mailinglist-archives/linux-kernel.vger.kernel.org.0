Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9417E719
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCIS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:27:24 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:57012 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCIS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:27:21 -0400
Received: by mail-wm1-f73.google.com with SMTP id g26so164541wmk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUzRbTx+9+5SLlU+YVj83grWFXbPGAYyGcx3oLf377g=;
        b=X5DyJAXj9e7DuXNJVjgflVf85gLiik5YQz/efq+eIbb/KFoMPqv9scT5owFu90/eVl
         DvuQaXBu+ev+8Fd9ik4Ar6xTviw5JmilkpSeCNmTAjepizZzxmfnz0mWplOqoBgNEYME
         yaDCgcpz+qOg5fp+p6FJhdBHzXZkd/dv5lrIpyEaabo1g+tT1hrhqd/QkWdZOVgIb4Ns
         g775BMmh2IzYfaJDq+O5XHDykXRB/ezjeP8ylgRQFgDgxDFWzmp0y8fWWh3V6le1rqs2
         FCvuUBiIPWXW75a9FcTICy/IyB4k5U0QPfm2ASFzzI67TUHvyxZTjLq7jQH0Y/ZXzaxJ
         jrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUzRbTx+9+5SLlU+YVj83grWFXbPGAYyGcx3oLf377g=;
        b=UPq+TcT5zWLfdHjGGj7xeDZp7tTc5UGsQgKcEQyvgZImRnItCIFtBeXsEZ2TNtWUD6
         tHCiWnL/GDNbOd/+lZWvaZES3+RMNrQ29jwYqe8qu280SNf8yOra9OVVU+OcaVbs1x+J
         2Lt/aWA0Q+2XICpS1k2CTL7rwaPwCTDqp6cc2YW8LM5drrA68bk8TgnQrfZAx2ffWvUS
         lyOJ7R6z664hVA9Wo4LYK7VGiDX/OH/Xrfm3Ivv5awpo8yN5VOzy8RVNvRobKVjFLT1x
         t93fQJeHmPG+Pyd+vlrQO49y66JNGXpuW/w3q5PHKKnAjMRa5/fFdTyqQNbdlVHAITFJ
         bDCQ==
X-Gm-Message-State: ANhLgQ3MxEtxRpcYOLaVCMWQOLlK43m9ALu91UvMgJC9A2ps5+aBU7Y3
        wCFa8ndbgXwuAEdOOTleMN+ZJtChHo9BlbcK
X-Google-Smtp-Source: ADFU+vv1SmBVli5DwvbZPkth9L0o2RHMWkXt2Q48SpLf15TTdS0o3jAjVeFPKC3S2n6naVFz0k0PGvlvQZhLeaxz
X-Received: by 2002:adf:b19d:: with SMTP id q29mr22015214wra.211.1583778439920;
 Mon, 09 Mar 2020 11:27:19 -0700 (PDT)
Date:   Mon,  9 Mar 2020 19:27:06 +0100
In-Reply-To: <cover.1583778264.git.andreyknvl@google.com>
Message-Id: <32bce32c8b88c2f88cd0a8acfcdb5d3a6e894632.1583778264.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1583778264.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2 3/3] usb: core: kcov: collect coverage from usb complete callback
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start/stop() callbacks around the urb
complete() callback that is executed in softirq context when dummy_hcd
is in use. As the result, kcov can be used to collect coverage from those
those callbacks, which is used to facilitate coverage-guided fuzzing with
syzkaller.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index aa45840d8273..de624c47e190 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
+#include <linux/kcov.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
@@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	/* pass ownership to the completion handler */
 	urb->status = status;
+	kcov_remote_start_usb((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
+	kcov_remote_stop();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
-- 
2.25.1.481.gfbce0eb801-goog

