Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1999617E584
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCIRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 13:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgCIRRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:17:04 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4ADE20828;
        Mon,  9 Mar 2020 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583774223;
        bh=5yHR3Ujn0DynzVH9Ws0JWy8TxK1tv97Kz6riXZaz3J0=;
        h=From:To:Cc:Subject:Date:From;
        b=CDi1KzsbcpSmQ2xbABBuFQQCx8uyO2Y0j+8cAr5lq6u8MDFPAeD4RaAHuLwPF9pgX
         VX3MbgqNvUX/wzaRyjH2ASXHWoAcxTsxaja8NwUcvUpdOHZGzqxqw6Weey0s5CKbxU
         3VHnxLUN+JUwa/2uSMCaMT/341doGUzO/4/0no8g=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv2 0/3] clk: agilex: add clock driver
Date:   Mon,  9 Mar 2020 12:16:50 -0500
Message-Id: <20200309171653.27630-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 2 of the patchset to add clock driver to the Agilex
platform. It's been while since I posted v1 so I want clarify the
patches a bit in this cover letter.

Since the Agilex clocking is very similar to Stratix10, the
driver is very similar and will re-use the clock data structures of
Stratix10. Thus, there needs to be updates to the Stratix10 clock
driver.

Patch 1/3 : update the Stratix10 clock driver to make use of the new
	parent data scheme
Patch 2/3 : version 2 of the documenation, converted to YAML
Patch 3/4 : version 2 of the clock driver with comments from v1
	addressed

Thanks,
Dinh

Dinh Nguyen (3):
  clk: socfpga: stratix10: use new parent data scheme
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform

 .../bindings/clock/intc,agilex.yaml           |  79 ++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/socfpga/Makefile                  |   2 +
 drivers/clk/socfpga/clk-agilex.c              | 369 ++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c            |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c          |  10 +-
 drivers/clk/socfpga/clk-pll-s10.c             |  74 +++-
 drivers/clk/socfpga/clk-s10.c                 | 110 ++++--
 drivers/clk/socfpga/stratix10-clk.h           |  10 +-
 include/dt-bindings/clock/agilex-clock.h      |  70 ++++
 10 files changed, 689 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intc,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.17.1

