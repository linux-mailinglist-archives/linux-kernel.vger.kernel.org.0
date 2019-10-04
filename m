Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE6CC5D2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 00:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbfJDW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 18:27:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfJDW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so3765711pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DB10pg/WIJaO+aJTgK4OR+kGpHxX86yfhLw/UszwpCo=;
        b=F5uG1Agmj1h9uJUlUsYaVzT9Nk4sqGpyY9EGmbmREWfkyCLX2Jypf/Vry8EYBqlg6y
         +5mmeuhecQk1H+/FUJ58m8WKZSUIoDROJ8cXuO1cXJvn/DtQTX99y99UNqV/CUfGWq8C
         SLXTxvc6qPmiBMbAvEABZWldwZ1/NsRYGGkdCpPAC6bXZkrlGLpbaVIa2KJrd/ryeSUT
         XXIocsOg0tgXtlaZzEHywwXICMIe9YedFnHjO/H7IocH1cuUcRViUrK4sRCS4QF4iFGg
         WyQKekfWYrwKHwUU39tkpVTyLDxjY9zrGkI6vCGtwxbHZyG1TjIYCAIyJ/jk6sDNyRf9
         mTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DB10pg/WIJaO+aJTgK4OR+kGpHxX86yfhLw/UszwpCo=;
        b=A9QICf/oqn2u5AqVJ7abjWQlrmjV2u2Dbj60L6HEo52O4o/f9OOFwCqbF8CUhdWzvh
         FAclkEvBMLR5WKdKmur/GcdfqVZUGI5TZWhEVbZC1EVzISBPN8jpt53Bb9zL9XLjcXVM
         ou/PPRF8LUt4j0zoDvJDdwfx2DzZiQsAv/fDvRBAYhWm2ju/LCQLzIFnCkMTn4ccMYsx
         ou1KlnbH6IcdnyJ9CRXJjFxBqSGSQ8im9jdcf/zGiSj3XfFOibq/WPh3PSh2y/FVMk5b
         s1vy1ScNt+meYQjeYetx/FH+jq0rUNc4g+fnvaBFJ1L9szQmw+JkJV4YkY5+TTZ94Zvx
         VBDQ==
X-Gm-Message-State: APjAAAU9A1iAS1vrFE0PrkPQP+dYeBZtojGc9k17a6qynIAPqa8+DWYt
        ua4pnKEXhU1T0WbNa4ShXIbOSw==
X-Google-Smtp-Source: APXvYqzCVLSpk4OE/L2LUrTXd1xxgCf0fxLXYqqbD9oR0XvRr6RzlVdImC6SxgRlG2DIsUN1EbXjmQ==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr3333013plb.317.1570228029737;
        Fri, 04 Oct 2019 15:27:09 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x37sm6328136pgl.18.2019.10.04.15.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 15:27:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/6] rpmsg: glink: Fix reuse intents memory leak issue
Date:   Fri,  4 Oct 2019 15:26:57 -0700
Message-Id: <20191004222702.8632-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191004222702.8632-1-bjorn.andersson@linaro.org>
References: <20191004222702.8632-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

Memory allocated for re-usable intents are not freed during channel
cleanup which causes memory leak in system.

Check and free all re-usable memory to avoid memory leak.

Fixes: 933b45da5d1d ("rpmsg: glink: Add support for TX intents")
Cc: stable@vger.kernel.org
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/qcom_glink_native.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 621f1afd4d6b..9355ce26fd98 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -241,10 +241,19 @@ static void qcom_glink_channel_release(struct kref *ref)
 {
 	struct glink_channel *channel = container_of(ref, struct glink_channel,
 						     refcount);
+	struct glink_core_rx_intent *tmp;
 	unsigned long flags;
+	int iid;
 
 	spin_lock_irqsave(&channel->intent_lock, flags);
+	idr_for_each_entry(&channel->liids, tmp, iid) {
+		kfree(tmp->data);
+		kfree(tmp);
+	}
 	idr_destroy(&channel->liids);
+
+	idr_for_each_entry(&channel->riids, tmp, iid)
+		kfree(tmp);
 	idr_destroy(&channel->riids);
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
 
-- 
2.18.0

