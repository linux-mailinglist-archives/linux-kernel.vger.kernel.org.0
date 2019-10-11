Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71388D421B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfJKOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 10:05:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727950AbfJKOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:05:17 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BE10P4032018;
        Fri, 11 Oct 2019 16:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Qn5aFd2HVDlFPaJf/8ibkjRYXsR+9F43fhoUK4LTDXA=;
 b=VB1+1CFORogfEpYP7u+ZAdtbfhLJgn+Cjz8PKuwSMIYaAHeFCfONEnxOxA2dJ7wQxt8L
 +w8SuHVSTip9ePKFuFME50ii8MZU2OoOuoKuvK7iDqqFWGMSkA4CKQydXUSCB+wFDCCH
 fVDU2f/8FttnmHE9sWZ4ygAxRpdLzgL+HSCeOJEhgfrDY2h95fgk7nOwQIMVEqe5n7Aj
 As00dShZy8FqGQr98HNM8Y1Y5dKOyI4JegSAILhD5qoZAXWoCBSKiYvR4W7AcpgehU9x
 gf7g5/nzXsZFevTakp7GdF87uhFiIASCqzslWuI/QQooiLMl1LqT9bo1fOLxoZ/GXK5s EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2ptntt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 16:05:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE77F10002A;
        Fri, 11 Oct 2019 16:05:02 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 801CC22251F;
        Fri, 11 Oct 2019 16:05:02 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Oct 2019 16:05:02
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>
Subject: [PATCH 0/4] update regulator configuration for stm32mp157 boards
Date:   Fri, 11 Oct 2019 16:04:41 +0200
Message-ID: <20191011140445.32288-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch-set is to
- add support of PWR blok regulators on the stm32mp157 boards
- undapte various regulator configurations

Pascal Paillet (4):
  ARM: dts: stm32: add PWR regulators support on stm32mp157
  ARM: dts: stm32: change default minimal buck1 value on stm32mp157
  ARM: dts: stm32: Fix active discharge usage on stm32mp157
  ARM: dts: stm32: disable active-discharge for vbus_otg on
    stm32mp157a-avenger96

 arch/arm/boot/dts/stm32mp157a-avenger96.dts |  8 +++++--
 arch/arm/boot/dts/stm32mp157a-dk1.dts       |  9 ++++++--
 arch/arm/boot/dts/stm32mp157c-dk2.dts       |  8 -------
 arch/arm/boot/dts/stm32mp157c-ed1.dts       | 25 ++++++---------------
 arch/arm/boot/dts/stm32mp157c.dtsi          | 23 +++++++++++++++++++
 5 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.17.1

