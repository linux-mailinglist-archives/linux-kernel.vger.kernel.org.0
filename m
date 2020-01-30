Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A389314D6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 07:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgA3Gwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 01:52:53 -0500
Received: from mx.socionext.com ([202.248.49.38]:26330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgA3Gwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:52:53 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jan 2020 15:52:52 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 56077603AB;
        Thu, 30 Jan 2020 15:52:52 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 Jan 2020 15:53:57 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id AB1E61A01BB;
        Thu, 30 Jan 2020 15:52:51 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/7] phy: socionext: Add some improvements and legacy SoC support
Date:   Thu, 30 Jan 2020 15:52:38 +0900
Message-Id: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds some improvements to PHY interface drivers, and
adds legacy SoC support that needs to manage gio clock and reset.

Changes since v1:
- dt-bindings: Add Reviewed-by: line
- Add SoC-dependent phy-mode function support for pcie-phy

Kunihiko Hayashi (7):
  phy: socionext: Use devm_platform_ioremap_resource()
  dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from
    usb3-hsphy
  phy: uniphier-usb3ss: Add Pro5 support
  phy: uniphier-usb3hs: Add legacy SoC support for Pro5
  phy: uniphier-usb3hs: Change Rx sync mode to avoid communication
    failure
  phy: uniphier-pcie: Add legacy SoC support for Pro5
  phy: uniphier-pcie: Add SoC-dependent phy-mode function support

 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |  13 ++-
 .../bindings/phy/uniphier-usb3-hsphy.txt           |   6 +-
 .../bindings/phy/uniphier-usb3-ssphy.txt           |   5 +-
 drivers/phy/socionext/phy-uniphier-pcie.c          | 102 +++++++++++++++++----
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |  92 ++++++++++++++-----
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |   8 +-
 6 files changed, 172 insertions(+), 54 deletions(-)

-- 
2.7.4

