Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346B74A412
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfFROdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 10:33:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44169 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFROdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:33:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so5796554plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q8xB/YadZoNJx3Y8wqv+Dxx79XsGQjUqciElxu2cGY0=;
        b=WiWcz9mdvHT2WhcsEpVhWi/GMN2860+gOEwjgEO6mLiqra2vj6vdK3fl1uX5MTdHf0
         9WXckyrOqb0XKOwEsmNuwYbkReNzM8FIQ1NJDeDSsAIzCSs2JOfTv9ipYmQa48LlvwO8
         1ExrlmCsLK+x+4NjktCWdaW3nVChHDCAHHubpxR60zjyvu+hI7iioK1B1Vf7JvrzGMKT
         QpNjTkOh7aSGPtq9ojJj4CuN1g92Vaa2J4+Wpprkqzin2qLxiFzkMH4ZfaIeedI8Qp7G
         h/N7hSODpvrCmlsRit5VlBdH90A3QW/HE2XqztaDN1MVbsTjSD7jnAnHWOp4m+KQ3M4U
         fkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q8xB/YadZoNJx3Y8wqv+Dxx79XsGQjUqciElxu2cGY0=;
        b=PsLTB3zLZVGsj1AFUDAuATSe2fXJKXjgSPPV+A+vmpVxzuAedVL+STHLdnZEcaAzru
         bf0QE2gGEawcSWd29CzKHQ37mrlRlkqSyivhtZ5yRtGSzlw7B9OwhOu75pIoa8IKn1+4
         zGJFHpbqyEWcxvE7GFdYpbPxPj/9C0g+ROET+Ljx6+AD+/mdNjeNY9P49JV0UBcejyHJ
         axnx+FoVT1Oypxja/X5Y3ICByMYhOqVTexCE7iqIcK+4vhWqOi66aeb834vZ2f/9DLQ4
         WfY//ES7UtwWthG350W7zeScQewEuDRCzqPel1NgVLiU6eMvq7aoF/YtMc1LIAB75zQ1
         njMA==
X-Gm-Message-State: APjAAAUbLPLyG2DL05gyDMSfPK5Q9WsxFbRFJBNoRLqkVGmQ57DeKmRV
        EKQds+t48lhQruXPOmVp4MM=
X-Google-Smtp-Source: APXvYqwHOk9vyC81K/UXycEb4q4wi5uCzKKQQckOPlJ/FTU4ofhSLQOy1EclaBTenKkwTJ4sJehCQA==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr32565013plg.142.1560868412386;
        Tue, 18 Jun 2019 07:33:32 -0700 (PDT)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id y1sm2718158pjw.5.2019.06.18.07.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:33:31 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     joel@joelfernandes.org, tglx@linutronix.de, mingo@kernel.org,
        rostedt@goodmis.org, frederic@kernel.org,
        paulmck@linux.vnet.ibm.com, alexander.levin@verizon.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] softirq: Replace this_cpu_write with __this_cpu_write if irq is disabled
Date:   Tue, 18 Jun 2019 22:33:05 +0800
Message-Id: <20190618143305.2038-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Irq is disabled before this_cpu_write(), so we can Replace this_cpu_write()
with __this_cpu_write().

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2c3382378d94..eaf3bdf7c749 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -650,7 +650,7 @@ static int takeover_tasklets(unsigned int cpu)
 	/* Find end, append list for that CPU. */
 	if (&per_cpu(tasklet_vec, cpu).head != per_cpu(tasklet_vec, cpu).tail) {
 		*__this_cpu_read(tasklet_vec.tail) = per_cpu(tasklet_vec, cpu).head;
-		this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
+		__this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
 		per_cpu(tasklet_vec, cpu).head = NULL;
 		per_cpu(tasklet_vec, cpu).tail = &per_cpu(tasklet_vec, cpu).head;
 	}
-- 
2.17.1

