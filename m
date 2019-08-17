Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497169123B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHQSgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 14:36:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfHQSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:36:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so4782286pfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TYFN6M5tjjpbtaEM4uAxus9mFpMdmZ5s9oBsAJJfRNk=;
        b=W1q7I+UtSxvLCsOfP1ANnjofm861kfljn0ZDN8h266Yx8otiFUcWD3qKj3IUaUVGc4
         zO5HB8zAcP7rlWfCz4pxO0uRHaPBkXIJW0sGJTmrgseCNFp52AJSqAcWUIxBD0Ri4r/f
         Rmed6NdJNLP2rHqcda1rc/gPGJk9Hbh4wGHpmZfi3wjCzMKlndNOPUNOBts+srAwMXOZ
         lBBEzCvp06/JXFAs4HUwX4pC9srfWfVxruXFjpjw9dclWIyZ5hmh8R4fjerOLG9Xbh8C
         usnlSp0idwS/UBut8KxJHrSI9Ab8S6egQTVFGtpvpNkKHP5hPb6iNV/+ssCfQHDjKZSh
         OPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TYFN6M5tjjpbtaEM4uAxus9mFpMdmZ5s9oBsAJJfRNk=;
        b=hQB7m8jziiXnZr0zgjIrZEDFKuXiU5Zwj7dQztsjLiGmJzUUVEQ2XIlGt1gBjpM5vy
         M6LyfEkQIHnrhobnR9lUppY3Q492/qhwqnYq852pCPXdyxfRM5SDmYTvezxgLTCbwiPB
         hX7x/D/LTtrwKetpHg0EiVHNHHBFXfeyR+mcY9n+DDirY0WYGO8ZaztwO71nCKNY0qDN
         sULjfuv2Walcz2paWHOPKIEZVMcBMAHgkcFBCy2VmjrLCpWQJ4iKGJQ7E2wCFt7h/+71
         q7g3zODx9z7IhvhJdkoyi7uUJfixhWx3Xj+z8vL/S3G3Div9STklihLjR+yYddN/WshK
         YNHw==
X-Gm-Message-State: APjAAAUlmAJ5uVNQ+QW9KkTFtJKOqZTr0fOVboONRM3NPw/Rtvx4SQiJ
        cx4Mb+7Knp6hDhSUnOxypRnH
X-Google-Smtp-Source: APXvYqzDyVwW24KFvVTD1hBgM9aPkOgx2uIUZcYoIGKzwdSiKZHulC0zXcLlrRvOoNGE+nork01H9g==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr12202255pjw.58.1566066991360;
        Sat, 17 Aug 2019 11:36:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:909:4559:9185:a772:a21d:70ac])
        by smtp.gmail.com with ESMTPSA id 33sm8588640pgy.22.2019.08.17.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 11:36:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/7] Add Bitmain BM1880 clock driver
Date:   Sun, 18 Aug 2019 00:06:07 +0530
Message-Id: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds common clock driver for Bitmain BM1880 SoC clock
controller. The clock controller consists of gate, divider, mux
and pll clocks with different compositions. Hence, the driver uses
composite clock structure in place where multiple clocking units are
combined together.

This patchset also removes UART fixed clock and sources clocks from clock
controller for Sophon Edge board where the driver has been validated.

Thanks,
Mani

Changes in v2:

* Converted the dt binding to YAML
* Incorporated review comments from Stephen (majority of change is switching
  to new way of specifying clk parents)

Manivannan Sadhasivam (7):
  dt-bindings: clock: Add devicetree binding for BM1880 SoC
  arm64: dts: bitmain: Add clock controller support for BM1880 SoC
  arm64: dts: bitmain: Source common clock for UART controllers
  clk: Add common clock driver for BM1880 SoC
  MAINTAINERS: Add entry for BM1880 SoC clock driver
  clk: Warn if clk_init_data is not zero initialized
  clk: Zero init clk_init_data in helpers

 .../bindings/clock/bitmain,bm1880-clk.yaml    |  83 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |   9 -
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  28 +
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-bm1880.c                      | 970 ++++++++++++++++++
 drivers/clk/clk-composite.c                   |   2 +-
 drivers/clk/clk-divider.c                     |   2 +-
 drivers/clk/clk-fixed-rate.c                  |   2 +-
 drivers/clk/clk-gate.c                        |   2 +-
 drivers/clk/clk-mux.c                         |   2 +-
 drivers/clk/clk.c                             |   8 +
 include/dt-bindings/clock/bm1880-clock.h      |  82 ++
 14 files changed, 1185 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 create mode 100644 drivers/clk/clk-bm1880.c
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

-- 
2.17.1

