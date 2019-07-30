Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB40F7B4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbfG3VUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 17:20:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46176 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbfG3VUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:20:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so7351072pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7dnDK6H9SahbARleR/Q2DwmEq2lmdqCyjjpFTu4H3s=;
        b=KFPaOPrQyZw+bawZZpKuOF9eMNcb8SWFtgMrxbvJiFsbTq5bXGuhq61Iu+DoFjYLjr
         uMxxWqhK9E9zQT6WGNFKGzvJRPN36hycRmMSNrycTuU0G54Kc40jfiKXKSvcQ4wfppsN
         cE4nYGlFbyZLZ3T/+z6w7SqMyOJwofXkmrCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7dnDK6H9SahbARleR/Q2DwmEq2lmdqCyjjpFTu4H3s=;
        b=oLDTKZJsRdbAHdM1/vwD2aGLB7+WIylVpGFwgLEw64lR/2zRCCRXKUG9t5m5e/U4wY
         NYgjjybxPhLKd3OeKNWvuRTdNBQZVWNmUMf7agqwVqp+CY0G+YQ3cBoWeA+uG1zk87J9
         tZZj9ncA1UOQBFQr37FD6cDYbprIGNJituqQ89pDFtzn41xUt3S7cj62ve6ft+e4RULv
         KE++bar4Q7qefKmrqcj+4rYucJ15CJ/tMCsLDGfi93wbj5tFoEjAT+vCvnKvv5iiwhPN
         bLSXGoKvSeU4AaAirHppjT6YZ1PPKiXC/DIdDCsrC+l42rTrDhlJHsk+OEg3DKosycR2
         gWqA==
X-Gm-Message-State: APjAAAVVNjsTRwsMYsw6LRSZlZU2ipe8cFHbSKJ+gvAoTQtMZKl4Vf9X
        XGpQw5g107KM19XU5KA08p0Vsg==
X-Google-Smtp-Source: APXvYqzsTyh96T1xkgu3NVZAClAdd/dL910dpPjg5fs+kLb+t+7VvwS6e3WVven83W+AxHF33v5QRQ==
X-Received: by 2002:a65:4489:: with SMTP id l9mr114011518pgq.207.1564521650996;
        Tue, 30 Jul 2019 14:20:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n140sm68205686pfd.132.2019.07.30.14.20.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:20:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] idr: Document that ida_simple_{get,remove}() are deprecated
Date:   Tue, 30 Jul 2019 14:20:48 -0700
Message-Id: <20190730212048.164657-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730212048.164657-1-swboyd@chromium.org>
References: <20190730212048.164657-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are deprecated. Users should call ida_alloc() or
ida_free() respectively instead. Add documentation to this effect until
the macro can be removed.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Tri Vo <trong@android.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/idr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 5bb026007044..12f7233c7adb 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -314,6 +314,10 @@ static inline void ida_init(struct ida *ida)
 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
 }
 
+/*
+ * ida_simple_get() and ida_simple_remove() are deprecated. Use
+ * ida_alloc() and ida_free() instead respectively.
+ */
 #define ida_simple_get(ida, start, end, gfp)	\
 			ida_alloc_range(ida, start, (end) - 1, gfp)
 #define ida_simple_remove(ida, id)	ida_free(ida, id)
-- 
Sent by a computer through tubes

