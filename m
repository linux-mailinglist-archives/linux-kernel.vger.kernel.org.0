Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA598522A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfFYFNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 01:13:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbfFYFNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so1376143wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwWPXATMjzsrThYG9AxfqAA38GUZEp5E9KeCsI7Vd04=;
        b=LUWYoAI0RIV2kR9YiKqtLKhr7jPVpGW/qnnu3/EArBmigcVqRS4njao+hxXF4mPymS
         OA5I39ma3J3gmFXeP6z+9v0md0a8qsPaPT/3MKAEdUA46eEbUU9Dnxh37yaB792iizJe
         VXL/d1z3ZwztcxcZEjEwa9zfyN/JFj8mRIzSV5pwMYv7aKkQQj+5eE/u+UeDfLs4HLYN
         Ko/rfNODIZGh37y6CdTioKuB/eOoCC/392y0WRxWth84g8XcFwhKbm5pPsOkBKvJUfnS
         YXCQ3I/uCvi/hiws7bN+uiOHh52uCJALNb+gxbOWHAQ4qfc7m6f4bIPce0UNKITQOORF
         B69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwWPXATMjzsrThYG9AxfqAA38GUZEp5E9KeCsI7Vd04=;
        b=EOSGtidXh8McW2v4WIVr3d8iVZ4TZW54NxJLLmEgiE4neIPoNP4yfB3WmaeK713w96
         /OiE5d+Sr/9nhWX3ZYLzw3dM2LBXBj5tktOqQhXdxoaguWqTpG5cri4/WHL/hEg4lYRr
         lxlN+qgpmxak3ZdWrzFEznYjeiqgcNNVkZ6dPqmQJJ0RGz5jRARQAvHVVepktQlthOec
         GTwqO6T/+57ZgFhaypmuZd1t/iGuNYHaQYaJteEXFa7KH6pnxPhgzvr7FyT4URlNdctb
         jxDal26tc8ls9yA4Dzjl/0kH20esLD2MfFS062LxP1gxtGSYtmvyyZ0+QpFH1YaRji6V
         B/Aw==
X-Gm-Message-State: APjAAAX1rCWCyHVCSN1hvsQ1hgmKf7jshf+gHhFklMjrBjOWZl15Nt5b
        7FNGB7x2ni+NliUSrf9QNk2LAQ==
X-Google-Smtp-Source: APXvYqxmFzDMq45w/U4TvH/tFfi2O7AaVFDU5wqiPW1cSH4kZC3au3aiFsC8sAHsor17QaeU7rcVMQ==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr18023346wma.68.1561439587593;
        Mon, 24 Jun 2019 22:13:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 3/7] block, bfq: update base request service times when possible
Date:   Tue, 25 Jun 2019 07:12:45 +0200
Message-Id: <20190625051249.39265-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I/O injection gets reduced if it increases the request service times
of the victim queue beyond a certain threshold.  The threshold, in its
turn, is computed as a function of the base service time enjoyed by
the queue when it undergoes no injection.

As a consequence, for injection to work properly, the above base value
has to be accurate. In this respect, such a value may vary over
time. For example, it varies if the size or the spatial locality of
the I/O requests in the queue change. It is then important to update
this value whenever possible. This commit performs this update.

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 05041f84b8da..62442083b147 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5496,7 +5496,18 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 		 * start trying injection.
 		 */
 		bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
-	}
+	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
+		/*
+		 * No I/O injected and no request still in service in
+		 * the drive: these are the exact conditions for
+		 * computing the base value of the total service time
+		 * for bfqq. So let's update this value, because it is
+		 * rather variable. For example, it varies if the size
+		 * or the spatial locality of the I/O requests in bfqq
+		 * change.
+		 */
+		bfqq->last_serv_time_ns = tot_time_ns;
+
 
 	/* update complete, not waiting for any request completion any longer */
 	bfqd->waited_rq = NULL;
-- 
2.20.1

