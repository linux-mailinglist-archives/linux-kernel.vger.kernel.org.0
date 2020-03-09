Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E217EA7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 21:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCIUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 16:53:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49865 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCIUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:53:28 -0400
X-Originating-IP: 82.66.179.123
Received: from localhost (unknown [82.66.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CC5E720008;
        Mon,  9 Mar 2020 20:53:23 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 0/2] clk: meson: axg: Remove MIPI enable clock gate
Date:   Mon,  9 Mar 2020 22:01:55 +0100
Message-Id: <20200309210157.29860-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed here [0], HHI_MIPI_CNTL0 is part of the MIPI/PCIe analog
PHY region and is not related to clock one. Since MIPI/PCIe PHY driver
has been added with [1], this region can be removed from the clock
driver.

Please not that this serie depends on [1] to be merged first.

[0] https://lkml.org/lkml/2019/12/16/119
[1] https://lkml.org/lkml/2020/1/23/945

Remi Pommarel (2):
  clk: meson: axg: Remove MIPI enable clock gate
  clk: meson-axg: remove CLKID_MIPI_ENABLE

 drivers/clk/meson/axg.c              | 3 ---
 drivers/clk/meson/axg.h              | 1 -
 include/dt-bindings/clock/axg-clkc.h | 1 -
 3 files changed, 5 deletions(-)

-- 
2.25.0

