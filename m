Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7F136860
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 08:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgAJHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 02:37:39 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:55633 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgAJHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:37:38 -0500
Received: by mail-pj1-f48.google.com with SMTP id d5so605138pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvaOTqe9vv2vgBX/0s0tlxD/m/5uJBFVxQC6/f12J1w=;
        b=KjSa4cmcgVBqcSfdfv8n61/028FjDGN6C1grjJKBT0FgzX9Z2+DacVwxR8bjn4zRx+
         aAZodAJZNLZv0D4Ysy5Buay9JdlGluTI/2xRKLasjw3WCBfwmpV8ZBAI6HNqiV5jpGBn
         RsThcEfoNkOlPgLLcQrb3HyeiULZUdvQCNKO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvaOTqe9vv2vgBX/0s0tlxD/m/5uJBFVxQC6/f12J1w=;
        b=Fd7MTocARxwkz1w55rpiQVqTgETJuVo6NlTurZJjkkgUaCf7FgC8PShms9nen2vkcP
         OHRGhjrjODw7d+cdyawsWcCZ+Al3JFW0RPllmG3Qbi+pSrGleE5vkXCeUUA2fhKazhXe
         hG3QfGfL1JTig6xjvYzmaStfl8fyJs3th/kPNmo5T+9676v5Sau9JbVnbzKRs6wd4WcC
         omgo1HTK9y0VqZjlM4DIeqJkjROf+72/S0jfvZ9tK0NMMhBC2S3lomtpAypv8i1A3Yz6
         /Nzh8wfLIkqI4HjwsnbNknvKTGCDHGHwdxsGQYz2lLdPnJ4Lt5ryT/g9ufjGdkB1LPAD
         y/4w==
X-Gm-Message-State: APjAAAVyCrC1DlFqe5FiSs7iCdgHWt4FpFZpBtpvelzV4wL2f8okgWyt
        dTZCx5aa7Yw+hOniMJAhsnahHg==
X-Google-Smtp-Source: APXvYqxytG7Z9y6Z61d5GQU9Hnb21hBVtECYCvXx3qYivuDVxrF71+ICMHxhkVi4/n0R+pxRlfjnuw==
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr2644975pld.140.1578641857781;
        Thu, 09 Jan 2020 23:37:37 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id p28sm1373919pgb.93.2020.01.09.23.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 23:37:37 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 0/2] Add mt8173 elm and hana board
Date:   Fri, 10 Jan 2020 15:37:28 +0800
Message-Id: <20200110073730.213789-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree and binding document for Acer Chromebook R13 (elm)
and Lenovo Chromebook (hana), which are using mt8173 as SoC.

Changes in v2:
- fix mediatek.yaml
- fixup some nodes and remove unused nodes in dts

Hsin-Yi Wang (2):
  dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
  arm64: dts: mediatek: add mt8173 elm and hana board

 .../devicetree/bindings/arm/mediatek.yaml     |   27 +
 arch/arm64/boot/dts/mediatek/Makefile         |    3 +
 .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 .../boot/dts/mediatek/mt8173-elm-hana.dts     |   16 +
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   60 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   15 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1040 +++++++++++++++++
 7 files changed, 1188 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi

-- 
2.25.0.rc1.283.g88dfdc4193-goog

