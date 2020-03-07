Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132BC17C947
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCGAAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 19:00:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34563 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCGAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:00:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id 23so77692pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtwnhE0dOU4dEaL21NqjZxyyLnhVLXbLrNjUI3+1LHU=;
        b=Ajyi7mY5V2YVrTRed4RoA9Adv9oko3wM83sy5Rryw4RSC0yYjH2yyl3If2ZOinXpDl
         MDQ0hoLsbVrsQ/cLdx5AWK6RzDQlM0bEQq8iyCL4JkNDHnY1CeoKftRiJJ0Or8c7ZJmL
         IriehFYK1/mzJRESqSQwtjqEZnW8etENDx1cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtwnhE0dOU4dEaL21NqjZxyyLnhVLXbLrNjUI3+1LHU=;
        b=ebeduOlqNQ8/YH4FznXZWM+hGVe/MOEAU4lDN7Kb0SQBxUV7kvJE6+a77jaKzVod1a
         J4tT0ZqdHcLlp4DvFblW4l4lOsGC5cWLbIN05JJGCly5FJqZqzQKYdC8mEeUErXMI6oM
         vTo3abmPwNaMxSKcP2H9QfTbZfzgobeOFUuQLkQPdk2t9z6hjHWVgwUnALDJZmltewJ0
         ysO40uBZnMLvAIcfORo/ZMsScx/wZtjA9lA6GtHCPpCkKxJQ8kGj86qjYZxhJlTePY3b
         pMxhyZbwzadTJzxE5WNqfG4jur2MhvHHQQ5UmNWMBCg07wZ3HmJTbP5aVeoLz1TPTxXb
         fOHA==
X-Gm-Message-State: ANhLgQ26d8kradTZgWIrltuESJs9u6eIklXEJ5hP9Kor9UpKHISePzQI
        sUrqZxgECAK7XZq16U/EZCKbAw==
X-Google-Smtp-Source: ADFU+vvPZPH6LeaFVHC3vVUKJVwBy5v8MzIfDt0+CiXXwiCQmtCmO7Iem66x5vbOyW+E9YuGYPnJ1Q==
X-Received: by 2002:a63:c00a:: with SMTP id h10mr5445417pgg.31.1583539229083;
        Fri, 06 Mar 2020 16:00:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 9sm32302246pge.65.2020.03.06.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:00:28 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 7/9] drivers: qcom: rpmh-rsc: Warning if tcs_write() used for non-active
Date:   Fri,  6 Mar 2020 15:59:49 -0800
Message-Id: <20200306155707.RFT.7.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306235951.214678-1-dianders@chromium.org>
References: <20200306235951.214678-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcs_write() is documented to only be useful for writing
RPMH_ACTIVE_ONLY_STATE.  Let's be loud if someone messes up.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c63441182358..693873fce895 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -550,6 +550,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
 	unsigned long flags;
 	int ret;
 
+	/*
+	 * It only makes sense to grab a whole TCS for ourselves if we're
+	 * triggering right away, which we only do for ACTIVE_ONLY.
+	 */
+	WARN_ON(msg->state != RPMH_ACTIVE_ONLY_STATE);
+
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
-- 
2.25.1.481.gfbce0eb801-goog

