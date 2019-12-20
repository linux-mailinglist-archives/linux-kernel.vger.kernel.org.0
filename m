Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD16C127579
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 07:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLTGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 01:03:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41294 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLTGDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:03:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so4386086pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 22:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Piggj3igE+oTFBOKGrWnYsbfHlwF09Ix52svgNc4Z6E=;
        b=pLeNJvZiYSUMVKQTjOw2ruIUe0kg7oUO9yboFRxiF3AMsFUZkdRFmVXFG2NUkD1o5j
         xW+G1e/7PAmrgAJ0afn2aU95LUubYdZ1JDkrrm0Iv3k5jqbQOIZ+W88GCxCSrbQAoWVI
         kn1bFQ2ASmw7KXEKtyF6vBkHtNYcwER5+hEOyIcvudubYBKi0nmpV9d4jDspwpvvDkuq
         wtGJQe413l8UdQJAVBur1OoVTpooogA8MefwlKeENEe0uAPwe0wb6AtdNI4d+2XDQBi9
         nkqkEQqmDc+DSYbuFSbseaOpiaBO6KjMg3G4zQ1oYSYI9vKsGsdpnVtJj/88kW1at/e1
         xJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Piggj3igE+oTFBOKGrWnYsbfHlwF09Ix52svgNc4Z6E=;
        b=Tw3ru3csxFpSQ/MX5NTXARDJgXWYgr6Ah9G9Rf8szmgRkZyXNJ17Sek1pojXAp4mSF
         CQLf5bO/92nkIrZP4PfZMG2gCZK0ZzWbJPWWyRoeaxWzJMeetFTmt+A0O2KcOhojw/hj
         qg/bg2Qs+4J/t0yBR3AkFEqQTbDQVh2dFVgDCuQmpjVv4+fPjE6AgfcWeYzEHys+V2pY
         syr/FWx7siuB6nG4rX03SYvg7SoXaLVnfmSYi0gEI+gxuB2HNHbLeGju751pOX2/soXf
         6LHPFD7oT3o0KdEb6og5uoYk+q4qREZtmqMjTTzB0F1uSAmDhNJFnVOo9xexWw3awTCa
         96ZQ==
X-Gm-Message-State: APjAAAUy5GasbT5eMcFf4s9El404TOpTW2CyTi/EuzihqO8feas+Xryx
        DA0CHI7xjr3+BZMmubuDAYLEEw==
X-Google-Smtp-Source: APXvYqwbzg95n0mg6BVy/iFiaEaWJVWRYFTtj2/p96TdsBX9NSamr/8qO1idzprzYhgDy5ZWnuCnvQ==
X-Received: by 2002:a62:64d6:: with SMTP id y205mr14245081pfb.41.1576821815076;
        Thu, 19 Dec 2019 22:03:35 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l15sm8835710pjl.24.2019.12.19.22.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 22:03:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] phy: qcom-qmp: Add MSM8996 UFS QMP support
Date:   Thu, 19 Dec 2019 22:03:02 -0800
Message-Id: <20191220060304.1867795-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the 14nm UFS PHY found in MSM8996 to the common QMP PHY
driver and migrates the msm8996 dts to the new binding, which will allow us to
remove the old driver (and the broken 20nm driver).

Bjorn Andersson (2):
  phy: qcom-qmp: Add MSM8996 UFS QMP support
  arm64: dts: qcom: msm8996: Use generic QMP driver for UFS

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  33 +++---
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 105 ++++++++++++++++++
 3 files changed, 128 insertions(+), 15 deletions(-)

-- 
2.24.0

