Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789BC14ED9A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgAaNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 08:41:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728673AbgAaNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:41:54 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VDbNl5027500;
        Fri, 31 Jan 2020 14:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=sJXTIsXxfIevlb+APOWmZFM7lKhWvD+4uZfBRqTpF2E=;
 b=ITDGB5w8k/S3e5C5VjNl9gu6fvxZZUHr3VJVvgTkNtk10YqYyEQXStZ7ix/x7Na1WXtR
 VTcouFyitd6Qp7aMVchxZJOWG0DuLi4BN9PbiHnqXdERwUrrvCRW0eAE4n0nw2RGCI1B
 iMStLB6qcpzs4CQALhBFE12DDN0saPiJnR5fi5hCwP9xg4G5cPd+k5EYAI1vskn6uPii
 041EfsoKjGaMqusa9YSJ5Fh4RqForQWDFoSmiF8AqifizB+rXs0zeDeIl/MpmlM27Hhf
 qnVU6EfQ8ghTW0a7NMGTaje/mxc67Sc01Z2UbLYj1uHbapTF270avdqwfCvpxUSV0vz9 qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaye2qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 14:41:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 646D410002A;
        Fri, 31 Jan 2020 14:41:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E9E12BC7D1;
        Fri, 31 Jan 2020 14:41:28 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan 2020 14:41:27
 +0100
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Erwan Le Ray <erwan.leray@st.com>,
        Clement Peron <peron.clem@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 0/4] STM32 early console
Date:   Fri, 31 Jan 2020 14:41:19 +0100
Message-ID: <20200131134123.27775-1-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_03:2020-01-31,2020-01-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART instance configuration to STM32 F4 and F7 early console.
Add STM32 H7 and MP1 early console support.

Changes in v2:
- split "[PATCH] ARM: debug: stm32: add UART early console configuration"
  into separate patches as suggested by Clement into [1]

[1] https://lkml.org/lkml/2019/4/10/199

Erwan Le Ray (4):
  ARM: debug: stm32: add UART early console configuration for STM32F4
  ARM: debug: stm32: add UART early console configuration for STM32F7
  ARM: debug: stm32: add UART early console support for STM32H7
  ARM: debug: stm32: add UART early console support for STM32MP1

 arch/arm/Kconfig.debug         | 42 +++++++++++++++++++++++++++++-----
 arch/arm/include/debug/stm32.S |  9 ++++----
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.17.1

