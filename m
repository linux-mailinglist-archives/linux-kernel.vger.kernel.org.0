Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3B9D31C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfHZPj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 11:39:59 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53071 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733196AbfHZPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:39:32 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFPrAV018373;
        Mon, 26 Aug 2019 17:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=H7DnCfFp0iZ60ErGpkBa9fhjxQJ8KQ0RkkUvFpbyyJE=;
 b=0pEDxviXDpGIDzD4OPyXYWY7GFp4XjkoggbCd8Fbo1rkG20JDMTsOjlWWxakPE3kP3bB
 3vTeTWoBjJUPPDiNSNS/v3wWr4RJK8pnK5IUYBsEDmPPMLgZt8fHeQwHNK1M7OvXQ5aT
 k6h55iqH2bjfVW28WNkGrP3rCbw2xTAt0W6oz/TGeMxh+L3qNEwzOp3o1uE0l0BUZI+7
 FE0L0FpxveE0PufaVubCe7grXDgJlhaodk/Gxppje2FS0bAkM1hKKvamWDWiSpMDmSy3
 vJ6y/qWUQrF+OtU9iuj2cRA+FVRqGnmzYemjYWoEM0JrgqQdWrge45wdRMllQLl9UUL3 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vmgh6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Aug 2019 17:39:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48F9886;
        Mon, 26 Aug 2019 15:39:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 912742BC1CA;
        Mon, 26 Aug 2019 17:38:49 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 17:38:49 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 17:38:48
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] remoteproc: stm32: allow wdg irq to be a wakeup source
Date:   Mon, 26 Aug 2019 17:38:41 +0200
Message-ID: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog IRQ which notifies the remote processor crash is used by the
remoteproc framework to perform a recovery procedure.
Since this IRQ may be fired when the Linux system is suspended, this IRQ may
be configured to wake up the system.

Fabien Dessenne (2):
  dt-bindings: remoteproc: stm32: add wakeup-source
  remoteproc: stm32: wakeup the system by wdg irq

 .../devicetree/bindings/remoteproc/stm32-rproc.txt |  3 ++
 drivers/remoteproc/stm32_rproc.c                   | 47 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.7.4

