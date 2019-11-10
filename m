Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57F6F6BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKJVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:55:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKJVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so7239164wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1CBPj0l9y0fENT8CQAZ8Sxb6xyW2IVfDyd8rFCJnCjc=;
        b=unsswc4y+m+psOhrMNO1v3FEvI11RfVPV8h8uXqJirtnf6l7E+HYAAZKlchxeH5OHG
         v5n5dIb/Vi8ThATAWp5ZG6djKq8AxIMI7IJFRwUNkqlVLug5qbE3g6L2jzEArDGp5+N7
         /iby8totvBXDw68Aav7fDf1VWYjWE5X0uMoy3adQoyBYDMQvUYyr8ilkg2aEa1W0UR86
         QgrsKZxB7mfhX4ldvr3ER0nwv68ZpqhZ/XYQYYiBV8FzxuyJi5UEwCde2SXFzEtmfJlY
         Sv696HxKI/VcpJW7jiCAG0/0a1UIKKiFxvab9EcVBVIZsX0OGwExCA3DsZ26/IHStfob
         oaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1CBPj0l9y0fENT8CQAZ8Sxb6xyW2IVfDyd8rFCJnCjc=;
        b=O1ZLH7IrKmB2vCPnbvnaFWMgBwiCnNhEUOnbihCc/wStwLEJXyane+pFQ5DgQEoOra
         aMlP8jFdLEeA+E88G5pJdYttfcVRAviVDj6a1gMc9fZdEtZ9JDFh0lCTmrXcN18AI8c7
         svMLTp5SdlbCSJVHsW8NUkvzIatwHqVJWYOUbtVI37VhvODuHE6UmBLrEVnBIOoo3Ixj
         TH+7L3u2+SktDFCHAbuenmtKxzq9hw1oDOM6xQJ73GCnGeeUx9U1mC1OaAEqhZstgqLC
         G7Ghl88/iEzc/Tae8df0ReVYZonU2AdyjIBpeeaFmBxPTLMBvP/y11SrVEDmB+fiOCKn
         PUEA==
X-Gm-Message-State: APjAAAWpTsOa4E2xCEdABJnSvrXn/JNOAkHZZBP+NUw4Dp0fJqf2QfAi
        vtOZaTGPcUQzNJAkWJ4JdHEfJmKm0j4=
X-Google-Smtp-Source: APXvYqz5xd65AN5s42jlSj1PI0iPPQm3THltyvoGThKLn8R1PvFxoH3s0hTEsiiWLZZT0iDTJDXYRg==
X-Received: by 2002:adf:c50a:: with SMTP id q10mr19173282wrf.374.1573422940172;
        Sun, 10 Nov 2019 13:55:40 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:39 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5/6] habanalabs: don't print error when queues are full
Date:   Sun, 10 Nov 2019 23:55:32 +0200
Message-Id: <20191110215533.754-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the queues are full and we return -EAGAIN to the user, there is no need
to print an error, as that case isn't an error and the user is expected to
re-submit the work.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 776ddafc47fb..8850f475a413 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -626,9 +626,10 @@ static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
 
 	rc = hl_hw_queue_schedule_cs(cs);
 	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to submit CS %d.%llu to H/W queues, error %d\n",
-			cs->ctx->asid, cs->sequence, rc);
+		if (rc != -EAGAIN)
+			dev_err(hdev->dev,
+				"Failed to submit CS %d.%llu to H/W queues, error %d\n",
+				cs->ctx->asid, cs->sequence, rc);
 		goto free_cs_object;
 	}
 
-- 
2.17.1

