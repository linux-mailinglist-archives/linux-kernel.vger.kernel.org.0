Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8212ABED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfLZLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 06:30:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:30:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so10365859plj.5;
        Thu, 26 Dec 2019 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=quLGNZb7ZQN7mncU2FVNFHiswtw4Rne1IcTNi3v2IO0=;
        b=LMXn37wP47nJbWqD4jAQyH9O5y4EcESwiOrSn9yCb/xrT3DBkElFltMm8ATx/3NpFM
         RC2oGnlI9DRBrhalHj4ioZ/vdBzl8GN4ChbsPYA6nW4YUHYs/5sGJF0wYzbCLeuSVFQ/
         3YJn9C54oMfu39aWjqpYs/c+tbPWjYm4voI9PMkRg1FN1RSopiIQBmviBUHknhZ5FgE8
         K2E8fF36szqOefeZMn/zAzumP8yfUAAQikSZ7yfYB+NbY+e+zUZr+Hq51z6kOM7KAmD1
         d6OlAGs//p5k6QU0yz8lOQo9x3zXHZOwqFUbS5uv5alyFR8aPS+clWP8vmNcbpgkEnKF
         47WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=quLGNZb7ZQN7mncU2FVNFHiswtw4Rne1IcTNi3v2IO0=;
        b=RkSS2zmPdsw7ACDQeKlvbaxz4j1rcSfQFasn1ZfunSSrvKZb3NsxAys2AbBcYB39SG
         vWFYqLz/k4i1tCpwm1rNPDqpLJTWMvwVM90LnmTex06wlncih5oX4YbuX1uDJ3ouRjz6
         rk4kq3+nvXv4JOdYImILKv7L5eiGpC0YuK24pCWL93mGh+TSaT+gdQnsHIcuLUR67TTx
         S/iLWdEAR0H3nkviK6ZrvsW07vkJgWfGW5srqubPjFSAv4XK6x1a37JMK001K+csfZzu
         4qiy4y0SEiZbeVIKC+dGnrHXd3Rl1MJC2h3yLDXlnnvvrRD8khfSRnNHgFRyWxjbqvNI
         DYng==
X-Gm-Message-State: APjAAAVW92U/5l51TP5n1U85YgwiZz7+qjttHaHxDpWrlcSJWHcxbGJd
        tA3dvLKP4LzzHXg480ZCK8I=
X-Google-Smtp-Source: APXvYqz53AKJgzrL1puS0TxjQVUpaZg8sUTprhQFCBATj7P5qaGnqKtakT2zgkxHOC9EVqOP0Mn83w==
X-Received: by 2002:a17:90a:c983:: with SMTP id w3mr12876025pjt.121.1577359848207;
        Thu, 26 Dec 2019 03:30:48 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y6sm33743287pgc.10.2019.12.26.03.30.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Dec 2019 03:30:47 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: host: hsq: Support request_atomic() API
Date:   Thu, 26 Dec 2019 19:29:21 +0800
Message-Id: <5616323e045e6b64ec9c24e056609ee0f5a26f4a.1577358666.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1577358666.git.baolin.wang7@gmail.com>
References: <cover.1577358666.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to submit a request by request_atomic() API.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index f5a4f93..6a6bdd0 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -40,7 +40,10 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 
 	spin_unlock_irqrestore(&hsq->lock, flags);
 
-	mmc->ops->request(mmc, hsq->mrq);
+	if (mmc->ops->request_atomic)
+		mmc->ops->request_atomic(mmc, hsq->mrq);
+	else
+		mmc->ops->request(mmc, hsq->mrq);
 }
 
 static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
-- 
1.7.9.5

