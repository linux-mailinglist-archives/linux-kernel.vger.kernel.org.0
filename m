Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BC7969DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfHTUAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:00:02 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:47048 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:00:01 -0400
Received: by mail-oi1-f177.google.com with SMTP id t24so5077358oij.13;
        Tue, 20 Aug 2019 13:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDc44D7UBCU6lZkBAhG6OsPyET2iKNUIgty+ONWJ5wc=;
        b=J/ccD5MzEcQN0PR1vuM18SbRMYlsRZ3XXGbowLZBFA945XE5DwdSLi3+LuyELou/x/
         BcGgKq9NgjqbJn7sN3FWpwvOPgBSXgxatR9ucgO2PLtp6zL/ZD8Aciri0UphDQac3p8i
         UTIUHFQy0l00OSDZXiA7tnYXWWS2Tgdad8jbS1VM2dShe0PJQHgujxLPeXNkvKw9IlGf
         iA8fKxxDRsi6yXrvlDOH0QYZ4EtZWPOhC+qN+rtDL2y11QbDjDs6f9Tb5jEryGb/gao0
         kALAzUfDLKKyUrlw7beD0artjchvD4gE207nC6BT5QUqpANKI34MW2LcZWNzdQv9fNMP
         6P4g==
X-Gm-Message-State: APjAAAXjuVrUl5cmRuN3qm7vunCTRyQyDSNjOGQx/tEah/Lac99jHKL/
        VaQfUuOsinlbi3du/QWUJEDMzTM=
X-Google-Smtp-Source: APXvYqy7ABj6PAM1ans8JlyuFy8KcvBasov7Q2HA1O8HNtR+sbTOpMGz0GyFMVhMTYjrsA0J2eSweQ==
X-Received: by 2002:aca:540b:: with SMTP id i11mr1232727oib.50.1566331200453;
        Tue, 20 Aug 2019 13:00:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e22sm5082159oii.7.2019.08.20.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 12:59:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
Date:   Tue, 20 Aug 2019 14:59:56 -0500
Message-Id: <20190820195959.6126-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the various Arm Mali GPU bindings to use the DT
schema format.

The Midgard and Bifrost bindings generate warnings on 'interrupt-names'
because there's all different ordering. The Utgard binding generates 
warnings on Rockchip platforms because 'clock-names' order is reversed.

Rob

Rob Herring (3):
  dt-bindings: Convert Arm Mali Midgard GPU to DT schema
  dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
  dt-bindings: Convert Arm Mali Utgard GPU to DT schema

 .../bindings/gpu/arm,mali-bifrost.txt         |  92 ----------
 .../bindings/gpu/arm,mali-bifrost.yaml        | 115 ++++++++++++
 .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
 .../bindings/gpu/arm,mali-midgard.yaml        | 165 +++++++++++++++++
 .../bindings/gpu/arm,mali-utgard.txt          | 129 --------------
 .../bindings/gpu/arm,mali-utgard.yaml         | 166 ++++++++++++++++++
 6 files changed, 446 insertions(+), 340 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml

-- 
2.20.1

