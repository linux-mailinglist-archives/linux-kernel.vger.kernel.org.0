Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12B2753E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390618AbfGYQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:26:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41306 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390598AbfGYQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so12953516pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E85E3sDx7QmmDk1Qya6eXBYlrdWHNfL1kHhjlDR1b/g=;
        b=nc35E9AiCxeMN6103rkz1HbVehimcAIsRv5kmqeNqFtBzLYzuF5GKi8GybaCFRfkBw
         GYgFDUxn1tiZXm7chrKpcUqt7R5JlpnRHkXa3MVtg9JXROBE0lleyygvEPEhhm5Uu1eg
         GX65gtCZw958XOITkmgt9flz9uZzXjFiqfXyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E85E3sDx7QmmDk1Qya6eXBYlrdWHNfL1kHhjlDR1b/g=;
        b=cikbJHZjzguDJV9Q/oFLu4QoteSAIH96IJCQSyVInW8h11tlGskF6otdF+MexlIrkA
         j8gBoVAvlfF2HS1Kv7r1h38YfKLeS+GKHcGClaMStohjrB0u3q6DRM/IsmXAygfsxbEN
         x1n6sQs2LcK1QuHztHQnaCRfIR2DrgBHdMJ+1vEPUj5Gyllbr2PRfu/hJjel9fTqpIG/
         wx/2zsKHu8JeAQuItGo7ceFy+2irrdMfAT5LX1K1IuCk1Cs3JxNBhhAtgmmNblCT94LX
         XFnginmzXAP3UNFKR0XA+W3Bkk8wZ1AryAlEGxJoUKuT6AJA1Uoe+2EGy4qlM6+UVDW1
         gEfw==
X-Gm-Message-State: APjAAAU1G5HTvtL2HoIRRiPb3cQSKFKFANg/+ql8Zf7HY7ud1ROHXtP8
        D1kIflX55wj0kWFOOcdhp2OmJQ==
X-Google-Smtp-Source: APXvYqxXCKBHc8/5JBlcotEIfAlJsGQkxesUvB8hvVKuLAmWzu2UryLFWJCi0O9Qp+rvx6/yEIiT3A==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr95823296pjb.118.1564072008342;
        Thu, 25 Jul 2019 09:26:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o128sm55953582pfb.42.2019.07.25.09.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:26:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 0/5] Add veyron tiger and fievel boards
Date:   Thu, 25 Jul 2019 09:26:37 -0700
Message-Id: <20190725162642.250709-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree files for the veyron tiger and
fievel boards. It also reorganizes display and backlight
settings for veyron devices, to avoid duplication.

Previous versions of the series didn't have a cover letter,
v2 can be found at
https://patchwork.kernel.org/project/linux-rockchip/list/?series=144987

Matthias Kaehlcke (5):
  ARM: dts: rockchip: move rk3288-veryon display settings into a
    separate file
  ARM: dts: rockchip: consolidate veyron panel and backlight settings
  dt-bindings: ARM: dts: rockchip: Add bindings for
    rk3288-veyron-{fievel,tiger}
  ARM: dts: rockchip: add veyron-fievel board
  ARM: dts: rockchip: add veyron-tiger board

 .../devicetree/bindings/arm/rockchip.yaml     |  30 ++
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 115 +------
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi      | 173 ++++++++++
 arch/arm/boot/dts/rk3288-veyron-fievel.dts    | 299 ++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron-jaq.dts       |  55 ----
 arch/arm/boot/dts/rk3288-veyron-jerry.dts     |  58 ----
 arch/arm/boot/dts/rk3288-veyron-minnie.dts    |  52 ---
 arch/arm/boot/dts/rk3288-veyron-pinky.dts     |  17 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts    |  58 ----
 arch/arm/boot/dts/rk3288-veyron-tiger.dts     | 125 ++++++++
 11 files changed, 647 insertions(+), 337 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-edp.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-fievel.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-tiger.dts

-- 
2.22.0.709.g102302147b-goog

