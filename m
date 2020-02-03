Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9981503E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBCKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:09:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16558 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727511AbgBCKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:09:46 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013A7laG019683;
        Mon, 3 Feb 2020 11:08:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+4sb3dxn9Wm1UXCadNBKjHSse+85wiCwWOp50/uIgYk=;
 b=GHPTUpU7vWN8TA0QE+qyk7CUOKxWDYcSA1qrfaYorG8q4wKKfYPX90r8nJiV7zrwUBwF
 fSC1ATigccIeEonEyDk51oKNrCsqjZKM2aSr6t3cIDYSWTKtHab9VPjkAUcvr4R/aTPv
 WfKLrhVp7yVrUJvdVFKJWXixmVqk3m8V86WfldlJScUizvxUK68Uy9mII67LbER2Lii9
 EPtas/rc+SVGKFuwppF2G0cJPi8LIPkC37Jr10WbJI/L3b7bvRDKACpVkuoQoHSRm2T/
 6CLWZF8YKAhcWC612OdeNsEJRP1YICChZsgl+gHCSeF8IY/d6csRg0buL+gXnh9Oq30i MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybdrs6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 11:08:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BA6D10002A;
        Mon,  3 Feb 2020 11:08:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A28A92BE22D;
        Mon,  3 Feb 2020 11:08:48 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 11:08:47
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 0/6] ASoC: stm32: improve error management on probe
Date:   Mon, 3 Feb 2020 11:08:08 +0100
Message-ID: <20200203100814.22944-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_02:2020-02-02,2020-02-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve management of error on probe for STM32 SAI, SPDIFRX and I2S drivers.
- Handle errors when the driver fails to get a reset controller.
- Do not print an error trace when deferring probe.

Olivier Moysan (6):
  ASoC: stm32: sai: manage error when getting reset controller
  ASoC: stm32: spdifrx: manage error when getting reset controller
  ASoC: stm32: i2s: manage error when getting reset controller
  ASoC: stm32: sai: improve error management on probe deferral
  ASoC: stm32: spdifrx: improve error management on probe deferral
  ASoC: stm32: i2s: improve error management on probe deferral

 sound/soc/stm/stm32_i2s.c     | 39 +++++++++++++++++++++++++----------
 sound/soc/stm/stm32_sai.c     | 26 ++++++++++++++++-------
 sound/soc/stm/stm32_sai_sub.c | 11 +++++++---
 sound/soc/stm/stm32_spdifrx.c | 29 ++++++++++++++++++--------
 4 files changed, 74 insertions(+), 31 deletions(-)

-- 
2.17.1

