Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA212222E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfLQCvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 21:51:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:38898 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfLQCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:51:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551083; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RI6hFTXW5A6mYS/cai6mDSEfFJSEvJbNcxniuS3AFR4=; b=OqothzBSDSu9+m//fwMRa9EIehpGNd2324vVziqTQWXPRalveqbiA3XWvQ0xuE1EQ6nDtwjx
 QlVTsiziZSIHrBFQFyVCNq0746UO0P3EQq0oDg6ajscNx5U9856PHqAdxdP8oBZz4j1di7Im
 MSsxQoHJHt/zyTFtxwy8bp7fpGA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842a9.7fca66562e30-smtp-out-n01;
 Tue, 17 Dec 2019 02:51:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD73AC4479C; Tue, 17 Dec 2019 02:51:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 417C1C433A2;
        Tue, 17 Dec 2019 02:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 417C1C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 0/9] SD card bug fixes
Date:   Mon, 16 Dec 2019 18:50:33 -0800
Message-Id: <cover.1576540906.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches include SD card genernal bug fixes.

Bao D. Nguyen (2):
  mmc: core: Add a cap to use long discard size
  mmc: sd: Fix trivial SD card issues

Can Guo (2):
  mmc: core: fix SD card request queue refcount underflow during
    shutdown
  mmc: core: fix one NULL pointer dereference after SD card is removed

Sahitya Tummala (1):
  mmc: sdhci-msm: Ignore data timeout error for R1B commands

Subhash Jadavani (1):
  mmc: core: remove shutdown handler

Sujith Reddy Thumma (1):
  mmc: core: Skip frequency retries for SDCC slots

Vijay Viswanath (1):
  mmc: host: Add device_prepare pm for mmc_host

Ziqi Chen (1):
  mmc: core: allow hosts to specify a large discard size

 drivers/mmc/core/block.c |  4 ++--
 drivers/mmc/core/bus.c   | 13 +++++++++++++
 drivers/mmc/core/core.c  | 26 +++++++++++++-------------
 drivers/mmc/core/host.c  | 19 +++++++++++++++++++
 drivers/mmc/core/mmc.c   | 22 ----------------------
 drivers/mmc/core/queue.c | 10 +++++++---
 drivers/mmc/core/sd.c    | 10 ++++++----
 drivers/mmc/host/sdhci.c | 15 +++++++++------
 drivers/mmc/host/sdhci.h |  7 +++++++
 include/linux/mmc/host.h |  1 +
 10 files changed, 77 insertions(+), 50 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
