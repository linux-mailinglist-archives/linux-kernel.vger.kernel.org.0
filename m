Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E692CC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfE1QuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:50:25 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42012 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbfE1QuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:50:25 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SGYITS002904;
        Tue, 28 May 2019 11:50:21 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sq340kq11-1;
        Tue, 28 May 2019 11:50:21 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail2.cirrus.com (Postfix) with ESMTP id D321D605A6A9;
        Tue, 28 May 2019 11:50:20 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 28 May
 2019 17:50:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 28 May 2019 17:50:20 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 23D9244;
        Tue, 28 May 2019 17:50:20 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] extcon: arizona: Correct error handling on regmap_update_bits_check
Date:   Tue, 28 May 2019 17:50:20 +0100
Message-ID: <20190528165020.10320-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the case when regmap_update_bits_check fails and the change
variable is not updated is handled correctly.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 9327479c719c2..ba2d16de161f8 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -335,10 +335,12 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
 
 	arizona_extcon_pulse_micbias(info);
 
-	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				 ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
-				 &change);
-	if (!change) {
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
+				       &change);
+	if (ret < 0) {
+		dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
+	} else if (!change) {
 		regulator_disable(info->micvdd);
 		pm_runtime_put_autosuspend(info->dev);
 	}
@@ -350,12 +352,14 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 	const char *widget = arizona_extcon_get_micbias(info);
 	struct snd_soc_dapm_context *dapm = arizona->dapm;
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
-	bool change;
+	bool change = false;
 	int ret;
 
-	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				 ARIZONA_MICD_ENA, 0,
-				 &change);
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, 0,
+				       &change);
+	if (ret < 0)
+		dev_err(arizona->dev, "Failed to disable micd: %d\n", ret);
 
 	ret = snd_soc_component_disable_pin(component, widget);
 	if (ret != 0)
@@ -1726,7 +1730,7 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 	struct arizona_extcon_info *info = platform_get_drvdata(pdev);
 	struct arizona *arizona = info->arizona;
 	int jack_irq_rise, jack_irq_fall;
-	bool change;
+	bool change = false;
 
 	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
 				 ARIZONA_MICD_ENA, 0,
-- 
2.11.0

