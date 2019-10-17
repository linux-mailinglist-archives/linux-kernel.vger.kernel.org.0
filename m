Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC4DA7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439081AbfJQIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 04:54:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34537 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408371AbfJQIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:54:12 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4DE2E20014;
        Thu, 17 Oct 2019 08:54:09 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/2] Add a Kizbox2 dtsi and documentation
Date:   Thu, 17 Oct 2019 10:54:03 +0200
Message-Id: <20191017085405.12599-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short serie add a Kizbox2 DSTI file for the Overkiz's
SAMAD31 based boards and add their documentation.

Kamel Bouhara (2):
  dt-bindings: arm: at91: Document Kizbox2 boards binding
  ARM: dts: at91: add a common kizbox2 dtsi file

 .../devicetree/bindings/arm/atmel-at91.yaml   |  35 +++
 arch/arm/boot/dts/Makefile                    |   6 +-
 arch/arm/boot/dts/at91-kizbox.dts             | 173 ++++++------
 arch/arm/boot/dts/at91-kizbox2-0.dts          |  17 ++
 arch/arm/boot/dts/at91-kizbox2-1.dts          |  22 ++
 arch/arm/boot/dts/at91-kizbox2-2.dts          |  26 ++
 arch/arm/boot/dts/at91-kizbox2-3.dts          |  30 ++
 arch/arm/boot/dts/at91-kizbox2-rev2.dts       |  34 +++
 arch/arm/boot/dts/at91-kizbox2.dts            | 244 -----------------
 arch/arm/boot/dts/at91-kizbox2_common.dtsi    | 258 ++++++++++++++++++
 10 files changed, 512 insertions(+), 333 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-0.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-1.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-3.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2-rev2.dts
 delete mode 100644 arch/arm/boot/dts/at91-kizbox2.dts
 create mode 100644 arch/arm/boot/dts/at91-kizbox2_common.dtsi

--
2.23.0

