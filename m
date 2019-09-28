Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88194C0F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfI1B3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 21:29:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1B3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:29:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E627261891; Sat, 28 Sep 2019 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634185;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=jdLmQCsiO9HYXs8znTwNscXxxZ3dPTYN5nu02NTb7v+2mXopnQd4Vx/fQl1g68EUY
         5yiCQTlSr8ma0be+5PXc978pG9WUozJMdAGPvVe/6xKcBSf1aGS9qZJcrRa/2FN8zZ
         ngUJYhXlbkinjiO9QkMbudDYK4jxyacMqZArXAZ8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jeykumar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jsanka@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A229461213;
        Sat, 28 Sep 2019 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634184;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=KzP1ej4f4iI1qU8X43fnEsgqdxkbzPmd2NRAv7b5GdiVHrM2Up2PO47cwks0MUjST
         G3keEYaxGsE9F2V+3pdw1Ru7q8HCSnjLDdphYvSgNS/TU9lld3NL9su6erlHpo+AZu
         sV5xeMWTnQJmylse77VcBXgCuvvbbd35CLm3Nrp8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A229461213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jsanka@codeaurora.org
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>, narmstrong@baylibre.com,
        seanpaul@chromium.org, robdclark@gmail.com, jcrouse@codeaurora.org
Subject: [PATCH] Add framebuffer max width/height fields to drm_mode_config
Date:   Fri, 27 Sep 2019 18:29:30 -0700
Message-Id: <1569634171-13970-1-git-send-email-jsanka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below two discussion threads will provide the context behind this patch.

https://www.spinics.net/lists/dri-devel/msg229070.html
https://lore.kernel.org/linux-arm-msm/db26145b-3f64-a334-f698-76f972332881@baylibre.com/T/

Seperating out the core framework patch from vendor implementation.

Jeykumar Sankaran (1):
  drm: add fb max width/height fields to drm_mode_config

 drivers/gpu/drm/drm_framebuffer.c | 17 +++++++++++++----
 include/drm/drm_mode_config.h     |  3 +++
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

