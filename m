Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5807187BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 10:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgCQJ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 05:26:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:26:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so24675387wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SGKeTvW6q46o0z04U45tAiO5ENrZM8rn9zZ0ol15d5I=;
        b=wuD0ztJRI3RLuTITfffwl+JEdhxK6cXwDqiyX+R6eCSfIVykDAIXlkIeJH3BgIJI/V
         k8rsS5TdXj9gSAfu1X0oH/o1PfgARBiIBK0u5RsewiJQQs7Qel8zZySPl2VpuW67FUgh
         /+wcIqaOJetGSGiYSYS5JZKkxP7Kh+VGRW4Hzpvml4CbeIshJEf9RELwt+klC//guK1d
         u2VtoOa1RaKXqkSyjMOQ7x5lxjyLURt/sVd9XSYhu7Qmf1gJY6zRQzkUf7zIrPkcMqB0
         bCo2k9IpzhfbB2ih1/Y9LhsScAEbA2XJGzMSYqdCmzCuIqVhsPkmTj3mHovRuAEV1yV7
         ypIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SGKeTvW6q46o0z04U45tAiO5ENrZM8rn9zZ0ol15d5I=;
        b=YJOs3pDhrCxpbRE9SEH22qw/fGaIJJgX2QR0fEHwVdszbciF/mUIe8NHvikP26t862
         lxfpjleBB7Q40C1Gv78PH9CcKDuRj5k2jk9rQjisRAC0ETebyG1uW17XzOQ4Ep/DLSyl
         lrq5npHX3O1ThvDptQzfOi8UFMRA0604NXLuCBUyeWhhf/yYMn3o3rGC5j/lN2kkMhe4
         Axo3/C/JnkxFjC3CY0CIuP7quxPCIjh9Of/5iAeSAuQ/1R0KeA0iUNBzLMEd4Q0xaPWh
         H3fjsd9SrQvtm8/lY4sB09xs+bJcVrR46WsYDRTHH3spIilqLwwSw47zfvIGW+4ruVpF
         ahOw==
X-Gm-Message-State: ANhLgQ3VpR1xm8rhNM1+xLDCZLn5/HrsKpT6PBq7XKB1kG+KM2gIQM69
        fqakS5GYZ+2m5O0vDY1B6CaK1Q==
X-Google-Smtp-Source: ADFU+vvsal4oOlKksw/GljEIXMh34Te99+wzC49/nuKJ0Bgp84m/3vQweGyDMeP1xry0AFJ55Vp4gQ==
X-Received: by 2002:adf:a295:: with SMTP id s21mr4917919wra.26.1584437214268;
        Tue, 17 Mar 2020 02:26:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k12sm3899483wrm.26.2020.03.17.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:26:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: add support for get_sdw_stream()
Date:   Tue, 17 Mar 2020 09:26:45 +0000
Message-Id: <20200317092645.5705-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to new get_sdw_stream() that can help machine
driver to deal with soundwire stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 440effed6df6..ba810fbfa3c7 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -588,6 +588,13 @@ static int qcom_swrm_set_sdw_stream(struct snd_soc_dai *dai,
 	return 0;
 }
 
+static void * qcom_swrm_get_sdw_stream(struct snd_soc_dai *dai, int direction)
+{
+	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
+
+	return ctrl->sruntime[dai->id];
+}
+
 static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
@@ -632,6 +639,7 @@ static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
 	.startup = qcom_swrm_startup,
 	.shutdown = qcom_swrm_shutdown,
 	.set_sdw_stream = qcom_swrm_set_sdw_stream,
+	.get_sdw_stream = qcom_swrm_get_sdw_stream,
 };
 
 static const struct snd_soc_component_driver qcom_swrm_dai_component = {
-- 
2.21.0

