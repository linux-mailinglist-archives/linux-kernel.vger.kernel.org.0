Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1DF4594
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfKHLV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:21:28 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:46108 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbfKHLV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:To:From:Sender:Reply-To
        :Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TStTNZM8PfBlzl4Lo1zrdZm0ddkmI3oBmBJSellfY7c=; b=Bsm8E1xcOoUl6l8gQPnHh1yQZu
        5cyykXPM9F8n+18VoakJHEBpvjYfua8LiYIcG50uzYqYkrXjJBnYIC8WRu0p4YB6yxq5+Fm/GWfCF
        rYClCAGsKjIh1o4U1iMoLwt9BzPKCAxh603lrTrHeEO09EE2PbEvsNwz4pGJeqvLhyV8=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iT2KP-0000ap-Io; Fri, 08 Nov 2019 12:21:22 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iT2IH-0004rL-Gq; Fri, 08 Nov 2019 12:19:10 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: [PATCH 0/2] dts: ARM: add Tolino Shine 3 eBook reader
Date:   Fri,  8 Nov 2019 12:18:32 +0100
Message-Id: <20191108111834.18610-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device tree for the Tolino Shine 3 eBook reader.
Name on mainboard is: 37NB-E60K00+4A4 and serials start with: E60K02
These boards are also found in the Kobo Clara HD eBook reader
but equipped with a i.MX6SLL processor.

It depends on the previously-accepted patch
ARM: dts: add Netronix E60K02 board common file

Andreas Kemnade (2):
  dt-bindings: arm: fsl: add compatible string for Tolino Shine 3
  ARM: dts: add devicetree entry for Tolino Shine 3

 Documentation/devicetree/bindings/arm/fsl.yaml |   1 +
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts     | 326 +++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine3.dts

-- 
2.11.0

