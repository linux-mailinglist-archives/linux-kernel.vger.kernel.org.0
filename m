Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBFD51B90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfFXTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:41:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfFXTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so15136613wrl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atnBayrLpc2AX2svhMGsm60ysNZ9T7b+BNR7ZDTK0cg=;
        b=loOF0OsDukaQjB4gzqEHf33xXpdkbvyUk80B+5eIPhILYl3VwyDSvqJO1sDzZPH6vR
         rYRmMEWXgZZ+gLv5AELdm+O8YH2kQdVu5DaDMI8iW08rgE1dfcsAHgsEalivjQKP7Jk5
         ccts3YWXMX9OGdxCu3hjcf8sqVTErfRXU8/mZo9lefPBvJg7DWfUfAEC10ylbMWRFaoO
         +xisJCFcz4ITFGyNEpO6/c8P6ktheNpleL+RrZ09eT0srbMUAvnBR3usvSU1419Bmp9e
         GDd6dNe/u6Axk6UZpZxbMgrpyHrxioQvGQOnpNn7WlkjsFbxeTQA/5Wg4ZJTcbJlMJlA
         7stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atnBayrLpc2AX2svhMGsm60ysNZ9T7b+BNR7ZDTK0cg=;
        b=LA4+D327dght5JSdzEziXRzCyzzGBOxVZVxhzYp0/0B7GP/UlXBwLkMnl7K5spAi9n
         d4gH4r/Ehc5qZ25Bzl1aZ3wMuqgyN1XPvddMs5zFTkyRR9MW6iG4C0+7hLJZS2R6aL1f
         jo5ViM0TI5tXdwoebPG/W/xQDk6FX8SfkXJxq6VQ2Umyc2QuQapQa/78Hz48yZy13dD0
         rsYUaeyvQIF9gptIfNIg8QgGYSf/rWiqE659KQyAa/eFqG9Fq3qfOaT8ek4I1c+mR8QA
         MdVsKnZnNGIqf4qTlN9NmzGKRpJGI/9SjF22i7+wYVSqn7LX0FnziEKdI7P37b/FVXA7
         PgbQ==
X-Gm-Message-State: APjAAAWYQW5XgwIEzj7V+ErNosnpfc9aJJUFYElJ+ooDI3pEbtALMHNo
        jZaYrVPgq1/vPav8orCNpXQMJg==
X-Google-Smtp-Source: APXvYqwqN7K2xUrBvStkw/0/+NWC3qsndEhJuGUuF96jm/cvwuGDunI66D16FAF8RBYMz+iCOUSBqg==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr34579834wrn.160.1561405267903;
        Mon, 24 Jun 2019 12:41:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 2/7] block, bfq: fix rq_in_driver check in bfq_update_inject_limit
Date:   Mon, 24 Jun 2019 21:40:37 +0200
Message-Id: <20190624194042.38747-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the cases where the parameters for injection may be updated is
when there are no more in-flight I/O requests. The number of in-flight
requests is stored in the field bfqd->rq_in_driver of the descriptor
bfqd of the device. So, the controlled condition is
bfqd->rq_in_driver == 0.

Unfortunately, this is wrong because, the instruction that checks this
condition is in the code path that handles the completion of a
request, and, in particular, the instruction is executed before
bfqd->rq_in_driver is decremented in such a code path.

This commit fixes this issue by just replacing 0 with 1 in the
comparison.

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9bc10198ddff..05041f84b8da 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5481,8 +5481,14 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 * total service time, and there seem to be the right
 	 * conditions to do it, or we can lower the last base value
 	 * computed.
+	 *
+	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
+	 * request in flight, because this function is in the code
+	 * path that handles the completion of a request of bfqq, and,
+	 * in particular, this function is executed before
+	 * bfqd->rq_in_driver is decremented in such a code path.
 	 */
-	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 0) ||
+	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
 		bfqq->last_serv_time_ns = tot_time_ns;
 		/*
-- 
2.20.1

