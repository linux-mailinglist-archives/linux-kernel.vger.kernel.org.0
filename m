Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5085FC4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 12:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKNLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 06:02:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34165 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:02:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id y186so4707617lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 03:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDUvIPPyRNx4rgOl/6jUmNuj/P2ZCCnD4pYUmkyMZ1k=;
        b=R5x9uzjscvPLquHJeOkh0tku1Ct5Uszt9lT+ldmBnhaup737IDiCn6xBY4f+17YT/D
         NHJZI85eLG2Vg7nH1JxNhI60rbgz5XgR2JyOKzIL07H2QJ1EEir75BttnwCggKIfm20Q
         HuuUVZf0ypsiSLkGOb3rF25Cz6EtuX8aPMfOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDUvIPPyRNx4rgOl/6jUmNuj/P2ZCCnD4pYUmkyMZ1k=;
        b=PcroGuGWigodD4UdFE/3uNld1xpkElhRGoW4h4DFTLbL3ZSjb2Q27f/kDwUGpBM4Ia
         Qla8OCMn8QIDYYxekBcu7hBoFrb/Lzmw46XgQaPSfLVJep1sxivuAve48CxKkknEY94z
         ebkXstkqnfABk6wQytTGxv44Hw0+3nxPKm3mn0I03Jv5QW7Lr0vwjyWSZsYgNbZ+yx6v
         V0a/yCjYYGrbzUsZAPss/MPlbCdm44hrnF8kdU6dNxEdIQkutYMhHz+4uIppCo6hDfxa
         hfayoUnjHa/NcfLTJ5FCteZ6p+nLCklUdeVgWWgKBbckrC5ghWOwRyNBPiya9K4xVW2k
         G9+w==
X-Gm-Message-State: APjAAAWe7hQXw/NS2SuY3z7wMI+HRz3xThLFqUzVVZCmmEkI6Ce7YrWa
        TBZDQP0CGLwoGZgxYi9LyWNCbw==
X-Google-Smtp-Source: APXvYqx+dcqdEMfunFaJ5aoDcBHQugDvO/1iPG/YCzjkmgCH3CM0yjGR8tExVmakG+Y6L4JFcIYfTw==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr6295630lfo.87.1573729376716;
        Thu, 14 Nov 2019 03:02:56 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x5sm2498795lfg.71.2019.11.14.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:02:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/2] ARM: dts: ls1021a: define and use external interrupt lines
Date:   Thu, 14 Nov 2019 12:02:51 +0100
Message-Id: <20191114110254.32171-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A device tree binding documentation as well as a driver implementing
support for the external interrupt lines on the ls1021a has been
merged into irqchip-next, so will very likely appear in v5.5. See

87cd38dfd9e6 dt/bindings: Add bindings for Layerscape external irqs
0dcd9f872769 irqchip: Add support for Layerscape external interrupt lines

present in next-20191114.

These patches simply add the extirq node to the ls1021a.dtsi and make
use of it on the LS1021A-TSN board. I hope these can be picked up so
they also land in v5.5, so we don't have to wait a full extra release
cycle.

v2: fix interrupt type in 2/2 (s/IRQ_TYPE_EDGE_FALLING/IRQ_TYPE_LEVEL_LOW/).

Rasmus Villemoes (1):
  ARM: dts: ls1021a: add node describing external interrupt lines

Vladimir Oltean (1):
  ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs

 arch/arm/boot/dts/ls1021a-tsn.dts |  4 ++++
 arch/arm/boot/dts/ls1021a.dtsi    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.23.0

