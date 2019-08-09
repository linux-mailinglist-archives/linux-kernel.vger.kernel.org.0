Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5F87600
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406193AbfHIJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 05:32:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:51811 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405957AbfHIJco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:32:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BB13ED63BD;
        Fri,  9 Aug 2019 11:32:35 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RBewaE-fcJTT; Fri,  9 Aug 2019 11:32:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F3F7CD63C0;
        Fri,  9 Aug 2019 11:32:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gOklHG2eGQZ3; Fri,  9 Aug 2019 11:32:08 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 88485D6350;
        Fri,  9 Aug 2019 11:32:07 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 00/19] Initial support for Marvell MMP3 SoC
Date:   Fri,  9 Aug 2019 11:31:39 +0200
Message-Id: <20190809093158.7969-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set adds support for the Marvell MMP3 processor. MMP3 is used
in OLPC XO-4 laptops, Panasonic Toughpad FZ-A1 tablet and Dell Wyse 3020
Tx0D thin clients.

Apart from the adjustments in mach-mmp/, the patch makes necessary
changes to the irqchip driver and adds an USB2 PHY driver. The latter
has a dependency on the mach-mmp/ changes, so it can't be submitted
separately.

The patch set has been tested to work on Wyse Tx0D and not ruin MMP2
support on XO-1.75.

Lubo


