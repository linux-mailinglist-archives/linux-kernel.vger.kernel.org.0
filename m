Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2EA181DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgCKQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:29:55 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57849 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgCKQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:29:55 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BC2B74C30D;
        Wed, 11 Mar 2020 16:29:47 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megous@megous.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Add support for PinePhone LCD panel
Date:   Thu, 12 Mar 2020 00:29:31 +0800
Message-Id: <20200311162936.221613-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1583944194;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=9aZ3S84mHw4qXcjY/Kp+GSG14l46FAM2R96fwhUnoLw=;
        b=CB0z2emeUteq4K+Vm+Fl3YW5AeDzN+fR9fgavG6U/oahKEFAAdnW8kuNmiSZ7oWpDQm9IV
        WxcSkkn8AlLXmy5KwmN3BH1rHXhyzPyBnIS0/fRTlxGEaAQhAwQe2WnYfS/EHTF0xhIF1d
        grHLKR2JssBVmHAnD79ImiHiNXFJZcQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the LCD panel of PinePhone.

The first 3 patches are for the panel itself, and the last 2 patches are
for enabling it on PinePhone.

PATCH 4 is the fix of a bug in sun6i_mipi_dsi which will gets triggered
on XBD599.

Icenowy Zheng (5):
  dt-bindings: vendor-prefixes: Add Xingbangda
  dt-bindings: panel: add binding for Xingbangda XBD599 panel
  drm: panel: add Xingbangda XBD599 panel
  drm/sun4i: sun6i_mipi_dsi: fix horizontal timing calculation
  arm64: allwinner: dts: a64: add LCD-related device nodes for PinePhone

 .../display/panel/xingbangda,xbd599.yaml      |  50 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  37 ++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-xingbangda-xbd599.c   | 367 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  10 +-
 7 files changed, 471 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/xingbangda,xbd599.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-xingbangda-xbd599.c

-- 
2.24.1

