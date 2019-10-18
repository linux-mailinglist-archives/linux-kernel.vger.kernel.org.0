Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73373DC6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501880AbfJRODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 10:03:15 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46097 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbfJRODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:03:15 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 84EA320004;
        Fri, 18 Oct 2019 14:03:12 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH RESEND 0/2] Add Kizboxmini boards support
Date:   Fri, 18 Oct 2019 16:03:02 +0200
Message-Id: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Overkiz's SAM9G25 based boards and document them.

Kamel Bouhara (2):
  dt-bindings: arm: at91: Document Kizboxmini boards binding
  ARM: dts: at91: add a common kizboxmini dtsi file

 .../devicetree/bindings/arm/atmel-at91.yaml   |  14 ++
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/at91-kizboxmini-mb.dts      |  38 ++++
 arch/arm/boot/dts/at91-kizboxmini-rd.dts      |  54 ++++++
 arch/arm/boot/dts/at91-kizboxmini_common.dtsi | 166 ++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini_common.dtsi

--
2.23.0

