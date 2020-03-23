Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6718FC53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 19:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCWSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 14:07:26 -0400
Received: from mr85p00im-zteg06021901.me.com ([17.58.23.194]:55056 "EHLO
        mr85p00im-zteg06021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbgCWSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584986846; bh=Lz+pG/PsJEEZHzsgsUcnNiVD88/w5Vqoinxpr1eJOCM=;
        h=From:To:Subject:Date:Message-Id;
        b=rm/ViKCOsa5GtE+XNAmAUziuSTB0puOSkVRW/4RMLyJfC8vMPZTF/5ej20zkfOpXD
         6zCiAGw1Ron9s7aSgU2JPTVvZfcSPn9XsIVXE0xLF4lb4ENKc1UTexRikoGhPQ4Q9p
         ljFB1ne5iN60+tW9YYCjzLU/OH2Nd1vCMMWoNZwxigCVsAVDO954KgomAEzJX9Zs07
         vwxg3jIJhOAF22ck7g2JQpr0sDFttmTg7jmFAOufNIdcw9Aa2y8pTOoMg6TcXm2JoN
         OcbrXN5S/cMkUiIHEzkprdqrQK7UE9V6tJGk4BsawQli8qk2H+h9DcxlYlcVKqknaT
         KsmTZOeVmhX2Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 7A7EB7206B2;
        Mon, 23 Mar 2020 18:07:25 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     patrice.chotard@st.com, avolmat@me.com
Subject: [PATCH 0/2] arm: sti: LL_UART updates & STiH418 addition
Date:   Mon, 23 Mar 2020 19:06:37 +0100
Message-Id: <20200323180639.8481-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=841 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003230094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small serie updates the STi platform LL_UART code to rely on
DEBUG_UART_PHYS/DEBUG_UART_VIRT and add the STiH418 SoC support.

Alain Volmat (2):
  arm: use DEBUG_UART_PHYS and DEBUG_UART_VIRT for sti LL_UART
  arm: sti LL_UART: add STiH418 SBC UART0 support

 arch/arm/Kconfig.debug       | 38 +++++++++++++++++++++++++-----------
 arch/arm/include/debug/sti.S | 26 ++----------------------
 2 files changed, 29 insertions(+), 35 deletions(-)


