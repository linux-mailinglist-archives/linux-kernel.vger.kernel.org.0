Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5CC94B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfHSR0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 13:26:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHSR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:26:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 7F62F28B120
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     dafna.hirschfeld@collabora.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        kernel@collabora.com
Subject: [PATCH v4 0/2] add imx8mq nitrogen support - changes since v3
Date:   Mon, 19 Aug 2019 19:26:04 +0200
Message-Id: <20190819172606.6410-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change log:
patch 1: no changes
patch 2:
- gpio-key,wakeup -> source-wakeup
- newline between property list and child nodes.
- settting pinctrl nodes names to: "pinctrl_xxx: xxxgrp {"

Gary Bisson (2):
  dt-bindings: arm: imx: add imx8mq nitrogen support
  arm64: dts: imx: Add i.mx8mq nitrogen8m basic dts support

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 405 ++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts

-- 
2.20.1

