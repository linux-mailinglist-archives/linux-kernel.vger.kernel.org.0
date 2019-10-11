Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCED3FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfJKMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 08:50:44 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44367 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJKMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:50:44 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 265A3E0009;
        Fri, 11 Oct 2019 12:50:42 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/3] Add new Overkiz Kizbox3 support
Date:   Fri, 11 Oct 2019 14:50:19 +0200
Message-Id: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Kizbox3 Overkiz SAS boards.
Those boards are based on the Atmel SAMA5D27 SoC.

Kamel Bouhara (3):
  dt-bindings: Add vendor prefix for Overkiz SAS
  dt-bindings: arm: at91: Document Kizbox3 HS board binding
  ARM: at91: add Overkiz KIZBOX3 board

 .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/at91-kizbox3-hs.dts         | 309 +++++++++++++
 arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 412 ++++++++++++++++++
 5 files changed, 731 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizbox3-hs.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox3_common.dtsi

--
2.23.0

