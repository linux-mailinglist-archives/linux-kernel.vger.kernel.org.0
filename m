Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE214911D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 23:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgAXWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 17:43:17 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:51380 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgAXWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:43:17 -0500
Received: by mail-pj1-f50.google.com with SMTP id d15so441456pjw.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvWTwYISlf/IH0hjT9PbQOmz3mWIewJ1JoKDaTvkOQg=;
        b=hF7bk4vuR6CtJ0Fssbu/x7/X7YqvKoZfK3zZrSkctxYMr+/+DZV1MV73/GwOz/1hz0
         PWE8CFBsu4VlC7ZxMSzjSZF5H2dUX8C8IeFI7Xr7YY25y4SBHggn7G31YjZRds6PROXN
         KeBKeGsLOxtsDj12B4akLhlZLbBPXpo0KOWD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvWTwYISlf/IH0hjT9PbQOmz3mWIewJ1JoKDaTvkOQg=;
        b=pNoutatJtb9+ip7/4xWqXGsSsln6jaQiIKzzC5ksDQz1sC4aFZKfzZlTkTNLU5Mfim
         NC4cBq7agvCMcEzejjvZ/ulItIYzItAGOlubYrDQmcNWcN8xSX0BBkEv2kvenSF58dNr
         tcfEssmO61JBJ9WXvseambsJUOA4BO1VDygRolihIrouez35zVw2RGKaCOsGt+9yIHOE
         LAyXWYnyqUWEWSxvU7wa+3CGp1KG0vh3UR+dtYPnZL9hLruglQVWdKBmmLz3pIxMGrfO
         r5pt3g/CCuHhM+13M6detE3pISr7Qoc9hRxBHA5OKrFMikroJH/zew+92qAZj4RW8liR
         sGhQ==
X-Gm-Message-State: APjAAAUAPDusRaQVN5mrlm+Ivv/uzaQl53Sw3fNb5T2AsLKNcMGSW9IL
        OzGWenM4xORz9jxoR6Q7q7TrlA==
X-Google-Smtp-Source: APXvYqyVW7tLqpJuby8Nh3t3UXD03Vfv+QfRhxyzORFnDeMvIHt6BFh9wx/Yjojz/+d0Ge2D/iQgXg==
X-Received: by 2002:a17:902:c693:: with SMTP id r19mr6264543plx.25.1579905795881;
        Fri, 24 Jan 2020 14:43:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm7690948pjo.26.2020.01.24.14.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:43:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        mka@chromium.org, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        hoegsberg@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 00/10] clk: qcom: Fix parenting for dispcc/gpucc/videocc
Date:   Fri, 24 Jan 2020 14:42:15 -0800
Message-Id: <20200124224225.22547-1-dianders@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this series is to get the dispcc and gpucc in a workable
shape upstream for sc7180.  I personally wasn't focusing on (and
didn't test) videocc but pulled it along for the ride.

Most of the work in this series deals with the fact that the parenting
info for these clock controllers was in a bad shape.  It looks like it
was half transitioned from the old way of doing things (relying on
global names) to the new way of doing things (putting the linkage in
the device tree).  This should fully transition us.

As part of this transition I update the sdm845.dtsi file to specify
the info as per the new way of doing things.  Although I've now put
the linkage info in the sdm845.dtsi file, though, I haven't updated
the sdm845 clock drivers in Linux so they still work via the global
name matching.  It's left as an exercise to the reader to update the
sdm845 clock drivers in Linux.

This series passes these things for me on linux-next:

  ARCH=arm64 make dtbs_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
  ARCH=arm64 make dtbs_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,dispcc.yaml
  ARCH=arm64 make dtbs_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,videocc.yaml
  ARCH=arm64 make dt_binding_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,videocc.yaml
  ARCH=arm64 make dt_binding_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
  ARCH=arm64 make dt_binding_check \
    DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/qcom,dispcc.yaml

I have confirmed that (with extra patches) the display/gpu come up on
sc7180 and sdm845-cheza.  You can find the top of my downstream tree at:
  https://crrev.com/c/2017976/3

I have confirmed that sdm845-cheza display / GPU come up atop
next-20200124, which is what this series is posted against.

This series is marked as 'v2' because in it I have snarfed up Taniya's
dts patch adding the clock controller nodes to sc7180.dtsi and this is
"v2" of that patch.  Everything else is brand new.

Changes in v2:
- Patch ("clk: qcom: rcg2: Don't crash...") new for v2.
- Patch ("dt-bindings: clock: Fix qcom,dispcc...") new for v2.
- Patch ("arm64: dts: qcom: sdm845: Add...dispcc") new for v2.
- Patch ("dt-bindings: clock: Fix qcom,gpucc...") new for v2.
- Patch ("clk: qcom: Fix sc7180 dispcc parent data") new for v2.
- Patch ("arm64: dts: qcom: sdm845: Add...gpucc") new for v2.
- Patch ("clk: qcom: Fix sc7180 gpucc parent data") new for v2.
- Patch ("dt-bindings: clock: Cleanup qcom,videocc") new for v2.
- Patch ("arm64: dts: qcom: sdm845: Add...videocc") new for v2.
- Added includes
- Changed various parent names to match bindings / driver

Douglas Anderson (9):
  clk: qcom: rcg2: Don't crash if our parent can't be found; return an
    error
  dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
  arm64: dts: qcom: sdm845: Add the missing clocks on the dispcc
  dt-bindings: clock: Fix qcom,gpucc bindings for sdm845/sc7180/msm8998
  clk: qcom: Fix sc7180 dispcc parent data
  arm64: dts: qcom: sdm845: Add the missing clocks on the gpucc
  clk: qcom: Fix sc7180 gpucc parent data
  dt-bindings: clock: Cleanup qcom,videocc bindings for sdm845/sc7180
  arm64: dts: qcom: sdm845: Add the missing clock on the videocc

Taniya Das (1):
  arm64: dts: sc7180: Add clock controller nodes

 .../bindings/clock/qcom,dispcc.yaml           | 87 +++++++++++++++----
 .../devicetree/bindings/clock/qcom,gpucc.yaml | 42 ++++++---
 .../bindings/clock/qcom,videocc.yaml          | 10 ++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 41 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 20 ++++-
 drivers/clk/qcom/clk-rcg2.c                   |  3 +
 drivers/clk/qcom/dispcc-sc7180.c              | 63 +++++---------
 drivers/clk/qcom/gpucc-sc7180.c               | 11 ++-
 8 files changed, 199 insertions(+), 78 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

