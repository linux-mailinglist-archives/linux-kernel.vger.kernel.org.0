Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6C9F1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfH0RgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:36:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34396 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:36:25 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so157689ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OrHiG8ZkzhZsHqSisGBWWpJnATlfuQ86+HaFYyJA8I=;
        b=deVT/vbYc4ecP5ExASXcivwIhq9LaGe6lFZQ5X7PEbp1VNmmEvZVoRpTfFuXXega+w
         g5J6LR1Nmy5GvXW0bBy1RTX8IbvUJvrVfUOm/wokhFpRJdimSUYKhxkWeiyxhTfjKEbb
         YK8UDkRp/IR35lmplPD4vbkH5JrSz3drDIZHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OrHiG8ZkzhZsHqSisGBWWpJnATlfuQ86+HaFYyJA8I=;
        b=CXwhSg8gQbU/wrX9Drwp4b1guF3BgDDSy2JLU48zUhi58yLrPQY41vTl0UUkgh+W8u
         o60dld3wyMmMKRPPS3QbNISkxTmLYqHK++FKIqlkJjrJiPb6JIiKzex5NqZd/BRWbpdz
         bgdAayuJR9YwU+B9m5Qu9M7KZ6cGpQ7+5MaKak7aH11qjx5oahH3RJM/94uO0QY/niwK
         M74cFtCnMj+32Ym6WrQCq6jRMgkHrKJNh/EPr3ppFqQEoO9+c61w4+tYiCt66acCkKA2
         IzI0vyqpHnvWd7JnNp9w8ub1Rsy9wmYIO+sykZAdYT3OzhtBTX1ukWR/29cwbXAeqqxy
         hTjQ==
X-Gm-Message-State: APjAAAXLVpcDv7MvCnmVAo2kvfDDnteqQbdi+iR1xpAzO02UqWta+qpB
        ZIe+ngcuA387s3GZJaDT6hBq4A==
X-Google-Smtp-Source: APXvYqw10pFnr5k3LJbhhD6xNDvDhQzuQL69lTHbE6Fa0PE6dkSJMKuw5olJU9OTjMhs+2qHEEJZqA==
X-Received: by 2002:a02:bb8c:: with SMTP id g12mr24679646jan.116.1566927384789;
        Tue, 27 Aug 2019 10:36:24 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id z3sm15276592ioi.54.2019.08.27.10.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:36:24 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     keescook@chromium.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK
Date:   Tue, 27 Aug 2019 11:36:19 -0600
Message-Id: <20190827173619.170065-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkdtm/bugs.c:94:2: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
  pr_info("Calling function with %d frame size to depth %d ...\n",
  ^
THREAD_SIZE is defined as a unsigned long, cast CONFIG_FRAME_WARN to
unsigned long as well.

Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Changes in v2:
- Correctly cast CONFIG_FRAME_WARN so the type is consistent.

 drivers/misc/lkdtm/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 1606658b9b7e..24245ccdba72 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -22,7 +22,7 @@ struct lkdtm_list {
  * recurse past the end of THREAD_SIZE by default.
  */
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
-#define REC_STACK_SIZE (CONFIG_FRAME_WARN / 2)
+#define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
 #define REC_STACK_SIZE (THREAD_SIZE / 8)
 #endif
@@ -91,7 +91,7 @@ void lkdtm_LOOP(void)
 
 void lkdtm_EXHAUST_STACK(void)
 {
-	pr_info("Calling function with %d frame size to depth %d ...\n",
+	pr_info("Calling function with %lu frame size to depth %d ...\n",
 		REC_STACK_SIZE, recur_count);
 	recursive_loop(recur_count);
 	pr_info("FAIL: survived without exhausting stack?!\n");
-- 
2.23.0.187.g17f5b7556c-goog

