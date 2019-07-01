Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C222F13BB1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfEDSj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:39:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40550 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfEDSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so6513366lfl.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZ/s404ieYgdn4mQFhvC58ROcLVfKpqdhGJe0FRX5g4=;
        b=Lj+27z3yDhXU/s5TVB3xbtLKxZH8kGgkvUMWqrm0f0IDsTcoTrD9ShSb63qix3YQye
         Pp027sJpFP5IUQnV/KaixmTaS0oUiR/o0VohjaKI8a5ijoLnzm3ZG8vCP+F+7/eqhLBS
         kZN/+pkSPx991NN1NEFuvoNgnhr/0CII0atCLG3IGJ6NFIyjKIrYvPTq4BbJMM9aneGO
         7usZ8RxzOolNAurWmUEzhr8Ly09YxvXDPkEEPJzvKIlRAeUKG/hpYNbv3nq5wYxrjgWz
         sdph5xSJ6LA7nxzcCKUgM77xTQRVAujbr+KXEbvY5FYPlzuGXeo/5cMmF97wwqynImWK
         QUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZ/s404ieYgdn4mQFhvC58ROcLVfKpqdhGJe0FRX5g4=;
        b=dKjmHx/nzrvcc3nlDIpKDW3znd7NwTm8q2Nlqk2s8iTM6c8sfvvlwmx9bOpoBhE5pE
         q+05C/sI+I07fZRaOnyTAG9Qidy1uggNyRdrcWQ8LVqFn+DQSegI8dpDvB/IfwFbGf6I
         +vRyaMNlJrpU/ZUeWuvycO9dzMSufHOZNSKzjZTR88SxD+ahu974wf3Pjb6eftd/fI7v
         c42uxj9naFxoPM9CfKAAvq6yXFuzmnVSwfmJys1Lnhg++fLofuoDfU25YUATsxoDQMjd
         6sCXWUm7whv2WwicOO1oosPpwhFu1zy7uXb11hAAgMsY/ZQ+UkCNORH56B4AjEZaKEYG
         GA7Q==
X-Gm-Message-State: APjAAAWsU/Y3+0BlVuyRAM9hp8ogmnkZI7vE+dNtOYwfzIViEagbfzE5
        +vcd9RjOKOx1k6qFOfCfvarePTAHslJE5g==
X-Google-Smtp-Source: APXvYqzCcqKYE6OJsQ/luR7GsAIatvCYUlAQ9OsTOmayHXQji0ElwCme+lrVRV87KXt8NymPJXXEwA==
X-Received: by 2002:a19:550d:: with SMTP id n13mr8393362lfe.127.1556995121314;
        Sat, 04 May 2019 11:38:41 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:40 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/26] lightnvm: pblk: fix update line wp in OOB recovery
Date:   Sat,  4 May 2019 20:38:01 +0200
Message-Id: <20190504183811.18725-17-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

In case of OOB recovery, we can hit the scenario when all the data in
line were written and some part of emeta was written too. In such
a case pblk_update_line_wp() function will call pblk_alloc_page()
function which will case to set left_msecs to value below zero
(since this field does not track emeta region) and thus will lead to
multiple kernel warnings. This patch fixes that issue.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 017874e03253..357e52980f2f 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
 static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
 				u64 written_secs)
 {
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	int i;
 
 	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
-		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
+		__pblk_alloc_page(pblk, line, pblk->min_write_pgs);
+
+	spin_lock(&l_mg->free_lock);
+	if (written_secs > line->left_msecs) {
+		/*
+		 * We have all data sectors written
+		 * and some emeta sectors written too.
+		 */
+		line->left_msecs = 0;
+	} else {
+		/* We have only some data sectors written. */
+		line->left_msecs -= written_secs;
+	}
+	spin_unlock(&l_mg->free_lock);
 }
 
 static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

