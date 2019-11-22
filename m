Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A77107594
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 17:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKVQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 11:16:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKVQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:16:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMGD83m015416;
        Fri, 22 Nov 2019 17:14:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=q+AN9vpLp99KTf4oMHYu++uvf+aTBZJ7fWpmVfAwsSA=;
 b=IxKyGc9ou7D+Y0yLJolE3vkTsh6lhR8z5J9UPgqEeKf64aStCPXkdTCnuU8AteSIMwa0
 ys6FNaDyfM33C7PUQvv4QpfXhEg/YWtOb39Dhdg4ieDZ+YBzU+dGC/5pYri3CfptKsAw
 gj9xHv5Q5OVbK0EVg1O45F5JEXtb596YVGyLvTmmb9eXLIzIw98Jd6BjMk17LQObBRVr
 xL7CiX4AGyYQn2+jE+I1aP5RJ6eVBUsrScoWqxnbof2O2ZsC8ZkLIGklPJYkuLN0nUs9
 GnBQFoQW7IoXvSqF87hVh8RIq3z5H+qxPZ2TLD7XovJhGri/eD0W34UTJz1f8YJOYjy1 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uvt3qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 17:14:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8903B100034;
        Fri, 22 Nov 2019 17:14:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B9F92D378D;
        Fri, 22 Nov 2019 17:14:38 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Nov 2019 17:14:37
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>, <srinivas.kandagatla@linaro.org>
Subject: [PATCH][RFC] ASoC: stm32: sai: manage rebind issue
Date:   Fri, 22 Nov 2019 17:14:23 +0100
Message-ID: <20191122161423.8641-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e894efef9ac7 ("ASoC: core: add support to card rebind")
allows to rebind the sound card after a rebind of one of its component.
With this commit, the sound card is actually rebound,
but is no more functional.

With the sound card rebind the simplified call sequence is:
stm32_sai_sub_probe
	snd_soc_register_component
		snd_soc_try_rebind_card
			snd_soc_instantiate_card
	devm_snd_dmaengine_pcm_register

The problem occurs because the pcm must be registered,
before snd_soc_instantiate_card() is called.

Modify SAI driver, to change the call sequence as follows:
stm32_sai_sub_probe
	devm_snd_dmaengine_pcm_register
	snd_soc_register_component
		snd_soc_try_rebind_card

---
The current patch allows to fix the issue for STM SAI driver.
However, most of the drivers register the component first.
So, this solution is perhaps not the right way to manage the problem.
This may probably be handled in ASoC framework instead.
---

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 48e629ac2d88..eb35306a1232 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1484,6 +1484,13 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register pcm dma\n");
+		return ret;
+	}
+
+
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
 					      &sai->cpu_dai_drv, 1);
 	if (ret)
@@ -1492,11 +1499,6 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
 		conf = &stm32_sai_pcm_config_spdif;
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
-	if (ret) {
-		dev_err(&pdev->dev, "Could not register pcm dma\n");
-		return ret;
-	}
 
 	return 0;
 }
-- 
2.17.1

