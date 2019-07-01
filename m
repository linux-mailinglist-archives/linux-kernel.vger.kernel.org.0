Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCF23E71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392911AbfETRYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:24:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390525AbfETRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:24:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so15537370wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9f53yOiq05lWNzaZ4psZ5nNqcD+KW9Z7mWrkNOPWql4=;
        b=efPBd60SOweuaEtrPmrvEAgFFXxgKxmKmyy9bpp8zJvI5p/4b8l1Mn6o8ECeNMr/8o
         TR/T60XAGyrFAEC62ziZN83mYFMvD8us0wEeBN1UQDPpg+6HiATagjokE0O0ckPxuq8a
         u81B8sI9GEMzVMYxkYjOB3RafSNgh5bJD8f2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9f53yOiq05lWNzaZ4psZ5nNqcD+KW9Z7mWrkNOPWql4=;
        b=tEkOvHPHV39QQOtTONLGbn3193G2cjopkrXdJVErKttZa90lEd20EkPOq+hI58HamL
         EX5HCwp1qS22Fb5QGZMukxSLX0HhRd775Z+0Fz4zlHDD7QjQvcNfsTlgOtodoILG0nyU
         Dnye5IaqbVxR7YTGdr4Yi5GirY8qfAZ45HwEOnnucrwneZ3OAOSA/uyuxibrFUThH+vd
         qdO2VXOfR32aaybk7YD88VwIMNjVA+xtIMDy5+Jcjz0iGyaTWKESjSE2vOZTh7RAnJ1K
         VQi9BxVFNaGP5nmrRDbLaoU3eU83/rPZ2gTXDBcq2aUgzS70muj+j5gQE1XrhRUpel7m
         XbkQ==
X-Gm-Message-State: APjAAAW43P53+4hCA2VldHvFZNWwF/q1tVyWrbdiay7oqorj0ij9KD3q
        TGFNGoSdLV2qLoVthNiR8V+ezs48NizTLg==
X-Google-Smtp-Source: APXvYqyx/q1u3qdOUfvt8mMH75in5zSdwv3nB5g27nP/2IT3WgDE13X8vLgZnhmLOLrTkenOvjl+Zw==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr30248014wrp.45.1558373083131;
        Mon, 20 May 2019 10:24:43 -0700 (PDT)
Received: from localhost.localdomain ([91.253.179.221])
        by smtp.gmail.com with ESMTPSA id b12sm180021wmg.27.2019.05.20.10.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 10:24:42 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/4] sbitmap: fix improper use of smp_mb__before_atomic()
Date:   Mon, 20 May 2019 19:23:57 +0200
Message-Id: <1558373038-5611-4-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic_set() primitive.

Replace the barrier with an smp_mb().

Fixes: 6c0ca7ae292ad ("sbitmap: fix wakeup hang after sbq resize")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 155fe38756ecf..4a7fc4915dfc6 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -435,7 +435,7 @@ static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
 		 * to ensure that the batch size is updated before the wait
 		 * counts.
 		 */
-		smp_mb__before_atomic();
+		smp_mb();
 		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
 			atomic_set(&sbq->ws[i].wait_cnt, 1);
 	}
-- 
2.7.4

