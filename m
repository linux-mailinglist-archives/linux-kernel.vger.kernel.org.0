Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53E6EB238
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfJaOLJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Oct 2019 10:11:09 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:44198 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfJaOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:11:01 -0400
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 37EFC1C80DC9;
        Thu, 31 Oct 2019 21:56:22 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct 2019
 21:56:21 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct
 2019 15:56:18 +0200
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Thu, 31 Oct 2019 15:56:18 +0200
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id CD7FF1A4;
        Thu, 31 Oct 2019 15:56:18 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AAFE160275; Thu, 31 Oct 2019 15:56:18 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <yuenn@google.com>, <venture@google.com>,
        <benjaminfair@google.com>, <avifishman70@gmail.com>,
        <joel@jms.id.au>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/3] reset: npcm: add NPCM reset driver support
Date:   Thu, 31 Oct 2019 15:56:14 +0200
Message-ID: <20191031135617.249303-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds reset controller support
for the Nuvoton NPCM Baseboard Management Controller (BMC).

Apart of controlling all NPCM BMC reset module lines the NPCM reset driver
support NPCM BMC software reset to restarting the NPCM BMC.

Supporting NPCM USB-PHY reset as follow:

NPCM BMC USB-PHY connected to two modules USB device (UDC) and USB host.

If we will restart the USB-PHY at the UDC probe and later the
USB host probe will restart USB-PHY again it will disable the UDC
and vice versa.

The solution is to reset the USB-PHY at the reset probe stage before
the UDC and the USB host are initializing.

NPCM reset driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Philipp Zabel : https://lkml.org/lkml/2019/10/29/712
                                   https://lkml.org/lkml/2019/10/29/713
                                   https://lkml.org/lkml/2019/10/29/731
 - kbuild test robot : https://lkml.org/lkml/2019/10/30/29

Changes since version 2:
 - Remove unnecessary details in the dt-binding documentation.
 - Modify device tree binding constants.
 - initialize gcr_regmap parameter to NULL.
 - Add of_xlate support.
 - Enable NPCM reset driver by default.
 - Remove unused header include.
 - Using devm_platform_ioremap_resource instead of_address_to_resource
        and devm_ioremap_resource.
 - Modify number of resets.
 - Using devm_reset_controller_register instead reset_controller_register.
 - Remove unnecessary probe print.

Changes since version 1:
 - Check if gcr_regmap parameter initialized before using it.

Tomer Maimon (3):
  dt-binding: reset: add NPCM reset controller documentation
  dt-bindings: reset: Add binding constants for NPCM7xx reset controller
  reset: npcm: add NPCM reset controller driver

 .../bindings/reset/nuvoton,npcm-reset.txt     |  32 ++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-npcm.c                    | 281 ++++++++++++++++++
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h |  91 ++++++
 5 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
 create mode 100644 drivers/reset/reset-npcm.c
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h

--
2.22.0



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
