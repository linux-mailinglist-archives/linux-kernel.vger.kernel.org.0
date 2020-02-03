Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8028B15046C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgBCKla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:41:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36561 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgBCKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so16325069wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M/C89B+RPb3s/AEZzJiX5HrsMKA5pqQCZ+d/xtiimQ=;
        b=HGk1szuNHr8Rpi6K6AEB+UGzUz7mmYy5IVSIeYVQhByZzdXdbUVfmZOZXNPt+6FaDn
         9YBerNBayTRTP2fjJYfNbtSO6+LlPgjwjOIoPMubtwUGpgPGgQUiQYBBSfZRzhrcHCdO
         1JVKDUJ1QWcbscUWrS8iB06shr7HP+gyNZcHpdeRLm65/PTor0LwZ0YzW5KmgOMjfs/i
         scaIjBh4sXpXhScIiFB/DEGdD47H9x/n5w/s5dq6+znXOb7O1TVkhhehsjOkmbz1aIBR
         9crljBQOXioT5+DnOKMl5A2EdaWHjOrNys/mlU9TOGFuYovwWoVTCy5mkWfzsRSw7a2x
         80QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M/C89B+RPb3s/AEZzJiX5HrsMKA5pqQCZ+d/xtiimQ=;
        b=tk/vmiWW5wv5QStbE2cjckbmJoJSXvoddlEgnt0fl9mx25iyIUts/aUAuZIigx58Ix
         VCdIFOun6ukilgSCtHLUVbkdggy8wZ1mc8o5PZgKF67JGxSr0zG8iFLKXXxaCxP08IUd
         iXVUFP60yz7gGPvpm8S4SIHYXEOC+TKjWkuWeYKqZ2CWPFXIUlzxUm2pOhALEdk+77iY
         BiifP29XDfigJ2mIVMUzKlrFUi+WsBREN0NogTPvVAqZsT7eGpMLAnQIH0xRB41jsZrP
         vUtJNiAr+Pa6+zL6F57paRO9ajl5t/4DU6m/0CIKK9tQuiz4k39wpeYS17fge35/FR3Z
         X1dQ==
X-Gm-Message-State: APjAAAWwQ1MuEqJIGXB6weYnpYaK8OWKBQfeEqf26vk1MfkVkhIFSKU/
        iI1tUZBiblQXGudmqwbZ+iEoKg==
X-Google-Smtp-Source: APXvYqzbBaAEE1ZuOQv8l5wyfJ6burueShpn1fgakonYTcdxiPDi2XpkDNjDG+Jz74vpXyUSnQ8E/g==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr29184394wmm.145.1580726484032;
        Mon, 03 Feb 2020 02:41:24 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:23 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 7/7] block, bfq: clarify the goal of bfq_split_bfqq()
Date:   Mon,  3 Feb 2020 11:41:00 +0100
Message-Id: <20200203104100.16965-8-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exact, general goal of the function bfq_split_bfqq() is not that
apparent. Add a comment to make it clear.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fff76c920968..8c436abfaf14 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5979,6 +5979,8 @@ static void bfq_finish_requeue_request(struct request *rq)
 }
 
 /*
+ * Removes the association between the current task and bfqq, assuming
+ * that bic points to the bfq iocontext of the task.
  * Returns NULL if a new bfqq should be allocated, or the old bfqq if this
  * was the last process referring to that bfqq.
  */
-- 
2.20.1

