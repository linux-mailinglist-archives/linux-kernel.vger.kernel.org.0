Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8CC8743
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJBL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 07:26:43 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42418 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfJBL0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:26:43 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0750482CE0;
        Wed,  2 Oct 2019 11:26:39 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/2] Enable USB BC detection to raise AXP813 Vbus current
Date:   Wed,  2 Oct 2019 19:25:43 +0800
Message-Id: <20191002112545.58481-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike previous AXP PMICs, the AXP813 PMIC (and AXP803) supports port
detection defined in USB Battery Charging Specification 1.2, and sets
the real Vbus current based on a pre-defined value (which is the
original Vbus current limitation field) and the port status. However,
the detection needs manual activision. If it's not active, the PMIC will
assume a SDP and limit the Vbus current to 500mA.

This patchset contains two patches, one enables the USB BC 1.2
detection, the other exports the real applied Vbus limitation.

Icenowy Zheng (2):
  power: supply: axp20x_usb_power: enable USB BC detection on AXP813
  power: supply: axp20x_usb_power: add applied max Vbus support for
    AXP813

 drivers/power/supply/axp20x_usb_power.c | 140 +++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 3 deletions(-)

-- 
2.21.0

