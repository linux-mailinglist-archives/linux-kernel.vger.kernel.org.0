Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C551622A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 09:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBRIui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 03:50:38 -0500
Received: from comms.puri.sm ([159.203.221.185]:39712 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgBRIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:50:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 93F0EE1131;
        Tue, 18 Feb 2020 00:50:37 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TOJcBN2WAsxs; Tue, 18 Feb 2020 00:50:36 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 0/9] arm64: dts: librem5-devkit: description updates
Date:   Tue, 18 Feb 2020 09:49:33 +0100
Message-Id: <20200218084942.4884-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are additions to the imx8mq-librem5-devkit devicetree description
we are running for quite some time. All users should have them:

revision history
----------------
v2: review by Shawn and Guido: remove a battery description
    add SoB tags, coding style fixes, squash and reorder audio
    descritions, remove redundant and unneeded changes.
v1: https://lore.kernel.org/linux-arm-kernel/20200205143003.28408-1-martin.kepplinger@puri.sm/

Angus Ainslie (Purism) (8):
  arm64: dts: librem5-devkit: add sai2 and sai6 pinctrl definitions
  arm64: dts: librem5-devkit: enable sai2 and sai6 audio interface
  arm64: dts: librem5-devkit: add the simcom 7100 modem and sgtl5000
    audio codec
  arm64: dts: librem5-devkit: allow modem to wake the system from
    suspend
  arm64: dts: librem5-devkit: add a vbus supply to usb0
  arm64: dts: librem5-devkit: add the regulators for DVFS
  arm64: dts: librem5-devkit: allow the redpine card to be removed
  arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Martin Kepplinger (1):
  arm64: dts: librem5-devkit: add lsm9ds1 mount matrix

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 134 +++++++++++++++++-
 1 file changed, 131 insertions(+), 3 deletions(-)

-- 
2.20.1

