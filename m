Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BCCED7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfJGUcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 16:32:09 -0400
Received: from vps.xff.cz ([195.181.215.36]:46254 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1570480327; bh=bc7QpEyDlGvpiVxiz/5velrN3mxOhwlvsZHJx3BTmiA=;
        h=From:To:Cc:Subject:Date:From;
        b=Qa/eySJqBG5qucKIh31HlYSo2vDu+NzWyou2O+no6F39oMNlAk9UDSeFd3m8f32c6
         /GYFk0dOTFXv0d3knAXMyUFWPOGQLbI5/CEJGuTlWCR2QitCbru+BXb1RF6EKokYzt
         grQoCFJ1mKdR0hJAd676Z4ZMLUuxF0hpsPy7WjCM=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 0/2] Add bluetooth support for Orange Pi 3
Date:   Mon,  7 Oct 2019 22:31:50 +0200
Message-Id: <20191007203152.3889947-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

(Re-send for Maxime, with already applied patches dropped. Nothing new.)

This series implements bluetooth support for Xunlong Orange Pi 3 board.

The board uses AP6256 WiFi/BT 5.0 chip.

Summary of changes:

- add more delay to let initialize the chip
- let the kernel detect firmware file path
- add new compatible and update dt-bindings
- update Orange Pi 3 / H6 DTS

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (2):
  arm64: dts: allwinner: h6: Add pin configs for uart1
  arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth

 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 19 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 10 ++++++++++

-- 
2.23.0

