Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA10F5BB6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 00:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKHXR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 18:17:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:17:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A0DE612C8; Fri,  8 Nov 2019 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573255002;
        bh=8M/QhUhPyQVnQEz/O/iwKGOaISD+goxqLlUSrKk39v4=;
        h=From:To:Cc:Subject:Date:From;
        b=RQP9s7ubYlCzrW5AonMwtnRFCoWcbW+E1MaJaVwtNJyt8PjU0xZYuRFms+a5m/ysV
         ZUdcpyIB92ZwCwhVx+kXJT4FLGwd2MMb51Y7l0lJ3kWTOltPaHPrSH491fOrrb52jw
         HNwoe5UbKsFA9rwvJzdir0DNbgl4S1nLXMq81n5g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3181C60591;
        Fri,  8 Nov 2019 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573255001;
        bh=8M/QhUhPyQVnQEz/O/iwKGOaISD+goxqLlUSrKk39v4=;
        h=From:To:Cc:Subject:Date:From;
        b=OwLf3n5b0oEbvaNu4B0eo4zwOT4Uq9LXoZkVR5PjMqSpJOFTkJ7C68FlS8E4O71Uy
         j7aS/Wwbka7RuIMlVt/qJl/VCcxav9LvpNtWNLBUtn1DfJ/VWiysBfPCvoL/eugILK
         BfjPpE2di2REx3mxGPIacT7NmbNCn1zfmxferiGw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3181C60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v8 0/4] MSM8998 Multimedia Clock Controller
Date:   Fri,  8 Nov 2019 16:16:27 -0700
Message-Id: <1573254987-10241-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multimedia clock controller (mmcc) is the main clock controller for
the multimedia subsystem and is required to enable things like display and
camera.

v8:
-drop dts changes from series per Stephen's request
-fix the mislabeled mmcc example
-drop Stephen as maintainer of the mmcc binding

v7:
-port to gcc.yaml.  Drop reviewed-by for DT changes as they got completely
rewritten
-drop "clk: qcom: smd: Add XO clock for MSM8998".  Will need to find another
solution and this is not blocking right now
-convert mmcc to yaml
-drop errant clk.h include
-use blank entries in the DT when no clock is available

v6:
-drop clk_get from mmcc clock provider

v5:
-handle the case where gcc uses rpmcc for xo, but the link is not specified in dt
-have gcc select rpmcc

v4:
-fix makefile to use correct config item
-pick up tags
-fix ordering of clocks and clock-names in dt
-drop MODULE_ALIAS
-wait for xo in mmcc since that was found to be useful in some debug configs

v3:
-Rebase onto linux-next to get the final version of the clk parent rewrite
series
-Moved the bindings header to the bindings patch per Rob
-Made xo manditory for GCC to work around the lack of clk orphan probe defer
to avoid the uart console glitch

v2:
-Rebased on the "Rewrite clk parent handling" series and updated to the clk init
mechanisms introduced there.
-Marked XO clk as CLK_IGNORE_UNUSED to avoid the concern about the XO going away
"incorrectly" during late init
-Corrected the name of the XO clock to "xo"
-Dropped the fake XO clock in GCC to prevent a namespace conflict
-Fully enumerated the external clocks (DSI PLLs, etc) in the DT binding
-Cleaned up the weird newlines in the added DT node
-Added DT header file to msm8998 DT for future clients

Jeffrey Hugo (4):
  dt-bindings: clock: Document external clocks for MSM8998 gcc
  dt-bindings: clock: Convert qcom,mmcc to DT schema
  dt-bindings: clock: Add support for the MSM8998 mmcc
  clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver

 .../devicetree/bindings/clock/qcom,gcc.yaml        |   47 +-
 .../devicetree/bindings/clock/qcom,mmcc.txt        |   28 -
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   95 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/mmcc-msm8998.c                    | 2913 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-msm8998.h      |  210 ++
 7 files changed, 3261 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
 create mode 100644 drivers/clk/qcom/mmcc-msm8998.c
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h

-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

