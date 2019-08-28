Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93E2A0C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfH1VpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 17:45:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36137 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1VpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:45:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id n1so948405oic.3;
        Wed, 28 Aug 2019 14:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BRznw7W8ExG2xqwSL+qcCCTF7qtixX1kVjq5WpB9B8=;
        b=a9gYfqa3opd0hYXIrVtK4GeF2VlxRtquMFpecTlokOWrTzyaHIEDK1YX+KzYnGy/16
         1HNjWTpD55rAZH51RMToDabmady2jQcpmkW2B3hUqyHl0QOkv+NLA06TVseoVEw+FXDM
         9mGGvT8gmy+FAatddssu1worPd0112E4qFunVDhs+lP0hYanC6XghvwnAu/a6b50AHzA
         jJXPPkekQO037waoYyxrsoryTPFxjHMYNqCev1XZRdtHyGv0onPBNGyJ3pooW6cXXMWI
         w4aOFdOmYe/Hq+1J0Q6ahHF+NI70btinlyCmV4GJw8odutWBd8VFLPbRXFLRTId3j3Mj
         OlbQ==
X-Gm-Message-State: APjAAAXIaaH0wOFPPuYQEBvttrVyLOQG0zPDccNGNi9RfPj55KGyOnhz
        aiQimdzkUg0JVf9WfUzT2w571YM=
X-Google-Smtp-Source: APXvYqwWyUu61tAJJPPkBOygOuXHaR90ro3L9y+vM21Pmm6DC6T7jptFSAdv1NKq/Cc3ecYvIQ9N3A==
X-Received: by 2002:a54:4814:: with SMTP id j20mr4208111oij.33.1567028703777;
        Wed, 28 Aug 2019 14:45:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p11sm102431oto.4.2019.08.28.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:45:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
Date:   Wed, 28 Aug 2019 16:44:59 -0500
Message-Id: <20190828214502.12293-1-robh@kernel.org>
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

v2:
 - Make 'clocks' always required.

Rob

Rob Herring (3):
  dt-bindings: Convert Arm Mali Midgard GPU to DT schema
  dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
  dt-bindings: Convert Arm Mali Utgard GPU to DT schema

 .../bindings/gpu/arm,mali-bifrost.txt         |  92 ----------
 .../bindings/gpu/arm,mali-bifrost.yaml        | 116 ++++++++++++
 .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
 .../bindings/gpu/arm,mali-midgard.yaml        | 165 +++++++++++++++++
 .../bindings/gpu/arm,mali-utgard.txt          | 129 --------------
 .../bindings/gpu/arm,mali-utgard.yaml         | 168 ++++++++++++++++++
 6 files changed, 449 insertions(+), 340 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml

-- 
2.20.1

