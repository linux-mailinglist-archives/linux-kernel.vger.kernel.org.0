Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9674D36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391983AbfGYLh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 07:37:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44179 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390908AbfGYLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:37:28 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PBauCD016931;
        Thu, 25 Jul 2019 13:37:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=mUqJHmLzQrt2mbDOnM5cVdOaFubBSHL/hq22+APxamY=;
 b=SkdL9PBs9NNzqnt2E98n6EXCju4Rl2ZMHruo1yPogzuhxGrKP+wCyTbz5GXj8QRGI+WL
 /Wfod0uAW6Wc98jPeSHysY+GEzfVjKcMfKrdi4ebwpYCZG3tt+NaVEWyqQWtNkr0j7fa
 az1daSsDeyYTuzdeXAH5wXVW1h7eOe+Qp7TFQz3AOzho/8k/6O4vrAHarz3nEDhOHFqa
 SL2QSvKtiIKhK/MnD1WpIaCNcNFwDwpnNW/8hgDcAJM1m/Xi6F/rcWx+Mccv3HF3g+QV
 qJCzi+a2d2JzCAhbkoLVGZ/xl3WNka8SOkoC1PaecjEQaYkCZ7BQ22012xrjVT6r4lXb KQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tx6043f6e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Jul 2019 13:37:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87B4831;
        Thu, 25 Jul 2019 11:37:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 604402B4D;
        Thu, 25 Jul 2019 11:37:15 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 13:37:15 +0200
Received: from localhost (10.201.20.5) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul 2019 13:37:14 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] STMFX GPIO consumers update
Date:   Thu, 25 Jul 2019 13:36:45 +0200
Message-ID: <1564054607-2028-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series depends on a STMFX pinctrl driver update
(https://lkml.org/lkml/2019/7/25/536).
Now, STMFX GPIO consumers can use standard GPIO bindings.

Alexandre Torgue (2):
  ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
  ARM: dts: stm32: change pinctrl definition for joystick pins on
    stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.7.4

