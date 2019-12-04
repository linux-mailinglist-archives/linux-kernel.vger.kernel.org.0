Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE9112ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfLDPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:44:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21436 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbfLDPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:44:05 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FbpeK027489;
        Wed, 4 Dec 2019 16:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ndUnApLFriRUIH9MbIy0x184oz9ICIGNQt+WfTn/orM=;
 b=McZwedlzMCjQmxKdGPXYFqLjprNpFK4FINTfMN5IRJ/ochJzsodHzX2wAHbyctNsAuCU
 0mpkO6ka3QEGyK4u7MdbHqE2Rf28pVN7m+Jx6DhDU9yFS5rm+X1Jj1D9w/zX4UO6HOIL
 mXFcrTYxix996QhUk7Wm0vv+y0YqHmqGDFl2defORs/jUl70jmdBVQmts03R7iDtVW0v
 yIvGnIfHXukFIEOBgxVbsUXpdoj0wlUGjIgsAWYIi8EVDlrf6y5Gyfj8AsAh+bzzAgbA
 X6M0aWoObx/4t7ascjw2pK9KodoQl8YTvRHkVXcvXQrqYC7BKcPGH+n5e39xXUAS8cFv 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wkf2xwvyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:43:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E92A10002A;
        Wed,  4 Dec 2019 16:43:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D08F92C71B5;
        Wed,  4 Dec 2019 16:43:41 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 16:43:41
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 0/3] ASoC: stm32: spdifrx: fix race conditions
Date:   Wed, 4 Dec 2019 16:43:30 +0100
Message-ID: <20191204154333.7152-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some race conditions on STM32 SPDIFRX driver.

Olivier Moysan (3):
  ASoC: stm32: spdifrx: fix inconsistent lock state
  ASoC: stm32: spdifrx: fix race condition in irq handler
  ASoC: stm32: spdifrx: fix input pin state management

 sound/soc/stm/stm32_spdifrx.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.17.1

