Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D7B566B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFZK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 06:28:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfFZK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so2071184wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvSt9hJ9riivcaZUoiXx5QKwOryBX80+CmAuVklqVuY=;
        b=R5NXGadOK14TqMvGFxi5JBu0gnCPHKST2RzdeMIqI3j+ns642EdrPmjEwDrJlZNxdL
         0poBYaMQpPcvKLibCyqWRYdXSWbKgO8BvSHYDPFEDJSM9o4f7VgqBQOfBN7WBHSZj0kd
         amqwmru4k9QFqpsb9W5oYqGTk8bEFYdWhJdeipf4CZW4CLsI3j/r0Iul69JRS+pWdLEF
         92gr3Hg5vY/TZyZg4UYxENt89GDwoXXhIdlCRKKE24hFUtugO3hA9d7FZw/nxjhcWkUw
         BiAGE0mKurK4Jee+XfvSy+mvQ4ZknfbEW1HJZAS7wvx7F2eJtmeRT0h5QPJ2x1isr5GK
         DoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvSt9hJ9riivcaZUoiXx5QKwOryBX80+CmAuVklqVuY=;
        b=kFkRstgxcupI4Sk+OE1F9xj9I85j/usYcpnTcNqUDQcfMflirsR15fyModUU0jSVaC
         jTCZEkfOW64fWdzbj0io3PEGJPImwEysnY0x0c3JayuYzeJ4NbuogMTnvpEIZiA2EMDl
         GZloKSVmOipTeEZMWsr7/8dlXEP4oHCPDbncAKYhVQR7otxMqHI8ZmtR4llmdyheyYsj
         6hX9CSuhJmNabL80cnwU8X/mfmEOrZhvfmkuudWoPr7fdL+391eFXVj4gDuzsZrWAtlc
         Qt+DpBwOzlvMy2aJpGpFZBiTJ/bfuTWeKxPOolFbcM3y0dFMzASi3iD60vPz8dp3mNhP
         62pw==
X-Gm-Message-State: APjAAAUMFcnt1/a1KvCq8XRLLNxf9ZI+UpeYoW5G9dIWtsFLNVfLquBc
        xKwf3h5dhPEgZr2Fa0zI5G6glg==
X-Google-Smtp-Source: APXvYqyUxp2HTk10/TPYId0f9iiqXY9bc1/NCL/3FY2t/2gSKs0yuX312ojOKmF38kJFexSu2bDW1w==
X-Received: by 2002:adf:ea4a:: with SMTP id j10mr3038947wrn.3.1561544884817;
        Wed, 26 Jun 2019 03:28:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] nvmem: imx-ocotp: Add i.MX8MM support
Date:   Wed, 26 Jun 2019 11:27:31 +0100
Message-Id: <20190626102733.11708-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

This patch adds support to burn the fuses on the i.MX8MM.
https://www.nxp.com/webapp/Download?colCode=IMX8MMRM

The i.MX8MM is similar to i.MX6 processors in terms of addressing and clock
setup.

The documentation specifies 60 discreet OTP registers but, the fusemap
address space encompasses up to 256 registers. We map the entire putative
256 OTP registers.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index b7dacf53c715..340ab336f987 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -473,6 +473,12 @@ static const struct ocotp_params imx8mq_params = {
 	.set_timing = imx_ocotp_set_imx7_timing,
 };
 
+static const struct ocotp_params imx8mm_params = {
+	.nregs = 256,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  .data = &imx6q_params },
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
@@ -483,6 +489,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ .compatible = "fsl,imx7ulp-ocotp", .data = &imx7ulp_params },
 	{ .compatible = "fsl,imx8mq-ocotp", .data = &imx8mq_params },
+	{ .compatible = "fsl,imx8mm-ocotp", .data = &imx8mm_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.21.0

