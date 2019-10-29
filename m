Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE902E9310
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 23:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfJ2WgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 18:36:09 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41745 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2WgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:36:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id m125so597153qkd.8;
        Tue, 29 Oct 2019 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAJA1RNDhAkbm1xO3/krIWUAY9zwBPAKxHWFAJSdUMY=;
        b=uCw4jKnURRfwfJVwzUVthW/4p4oxCjYTxVp1YNNuyOMFS6EuZtRCFiWR5BsmhPOB0u
         qg/UrUSKGJnODRuLeHpe8qcmCNxJbuS8l+qQlZWrd47EsAc5iSV/bt3Q/348XLydOSb+
         13rtoDBaK7MsDyzy5mI8FyTw+JKeoOHtTTUt60x27MkPgAyNHkhwVpn6Hf3BeFKUyCAP
         reJXOHB/pkWERSpU9kRgRlZuRd7JWj36RMs2igTybqsY2cX97Bl0t3w8OkRE0+EFtQKt
         JQhP/qO2Y9AFSHT/8yyNcOqnKOX7MXefl9DXJPZRVLyYekAN1Pkis+9JL4O++3GU7rJX
         agCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAJA1RNDhAkbm1xO3/krIWUAY9zwBPAKxHWFAJSdUMY=;
        b=KTY/FRgXBWIGgFfe4sZJ0rHqOAFo3pWjzJA/7RlEkvSg5HAqoobk6xvOPPw7AXtjtN
         Sx77cv2tpBzvh71AEX72UfJ2aoFJaMYLRfUo+iVEl63fcBKRhe9Pv9uDLDdM/zTiX7yQ
         apH5HUwtq/Sact16amgYiBjfbLuvFafWuGmTqxDcW0TAuA4lTzT/WjfwxrVQlEFIHJkR
         TCYhj1Jab9iKc5MCOHa0+EoKZV0NyXnEgc6OWpD0uYBccVaOwkdtTJ5JrMd/FCthzTWS
         ZGrh6jJaVRdOJRAHX1MO1L+Y+O4ZYfvXyWPqBJp6M4K0FpBT6BWYqUjLSAQGoBBbZ6qs
         4H5w==
X-Gm-Message-State: APjAAAXpMwOyzugfJpcAruqPT6z/wnpuqmHBpkbrTx7saVjv71Lt1bDm
        JXPPMvha+UcVSU7i2htR6j8=
X-Google-Smtp-Source: APXvYqxX3/Dih9xw7OuewPjGxo+KlUk390K7jqpAmpvsdtJR0mrxqr9Lkuzl5t8fTEdk2Sl0jWDj0g==
X-Received: by 2002:a37:d02:: with SMTP id 2mr24922492qkn.307.1572388567956;
        Tue, 29 Oct 2019 15:36:07 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id c21sm72374qtg.61.2019.10.29.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:36:07 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] blk-mq: Fix typo in comment
Date:   Tue, 29 Oct 2019 19:35:56 -0300
Message-Id: <20191029223556.2289-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in words: 'vector' and 'query'.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 block/blk-mq-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 488341628256..7b8a42c35102 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -16,7 +16,7 @@
  * @first_vec:	first interrupt vectors to use for queues (usually 0)
  *
  * This function assumes the virtio device @vdev has at least as many available
- * interrupt vetors as @set has queues.  It will then queuery the vector
+ * interrupt vectors as @set has queues.  It will then query the vector
  * corresponding to each queue for it's affinity mask and built queue mapping
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
-- 
2.20.1

