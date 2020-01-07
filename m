Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BAB132667
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 13:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgAGMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 07:38:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54835 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbgAGMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:54 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007CbTRF018497;
        Tue, 7 Jan 2020 13:38:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=LxTGVUsDWtY2YxgGD5UmI2rW8W4vNcqPH5eDldr9TMA=;
 b=mCKy4VfifgLqBEmMC+JyM2wd8xHWWRPlfcO9tBULwvB4WSZGM7dqwD+ZdYdGjdkeABaw
 nzDFGUMuy4C1JeFL2hIYMOJa9TcNUhsGsXov2xL5hSGELcis4+ql5PVmwdasX+JGROR8
 QtUcRhCki+UVzJ2zYIqaNS1S9Rw4q4xtXwtoV72cBOVn8DtRPDUTgIulVvj6NMkAzxd8
 +604ZsuyIvYnHFIQXCgHXUpZxohVMWMCIZOhUsBdP1e/Wp41MWH/CY5yXJrzzhN2gcI8
 3sg5Cod1EhmnclLCrwaGpj/YlTQbb+BTiZ97E4B12pWVViHkf1pZU17FgUXgqBozMSKZ wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakuqp4c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 13:38:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95642100034;
        Tue,  7 Jan 2020 13:38:31 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67CB52AFAB3;
        Tue,  7 Jan 2020 13:38:31 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan 2020 13:38:31
 +0100
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@st.com>
Subject: [PATCH 0/2] ARM: dts: stih410-b2260: Fix ethernet PHY DT node
Date:   Tue, 7 Jan 2020 13:38:26 +0100
Message-ID: <20200107123828.6586-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series is fixing a kernel Oops and is removing deprecated PHY properties: 

 - Since commit 'd3e014ec7d5e ("net: stmmac: platform: Fix MDIO init for 
   platforms without PHY")', a kernel Oops occurs and ethernet is no more
   functional.

 - Some deprecated Synopsys phy properties was always present in DT, 
   remove them.

Patrice Chotard (2):
  ARM: dts: stih410-b2260: Fix ethernet phy DT node
  ARM: dts: stih410-b2260: Remove deprecated snps PHY properties

 arch/arm/boot/dts/stih410-b2260.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

