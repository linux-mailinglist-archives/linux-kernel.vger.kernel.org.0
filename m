Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803A2F2342
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfKGAWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 19:22:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37952 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfKGAWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:22:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so105535plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZnFlSjJBCyiX49UFfAVbAl+DIF6Hve745f/WW6Cm4g=;
        b=a0binG9WBoQeShSdGBIOTdl2ZhGePguqdcSSONhXERHHbJswLsjmft7QCWfxe51BH7
         mBK/jLODO8sZ9IoMX4t2jgxqiPUmzljNTsgto+2hRuUKrxBwSDmuzLPqm190UwfOEw5V
         mRmvmIwrR8s/8dfsETU5+TPTbjk+8QgnlLQAoPJIgqv5q+SQCqaQ9EnPT0fFvjxoMSrD
         EclrA5KB8gJifXSpvH2GiDQGCfwK0Ua9m3pTg9DmPli9zLcrXBI2ZzYw1B5Y7MPor4dU
         IQoqhrATXb0aCYKO/IweUmsMNvB6slNDyxZ+TUV6fuW1GTnqe55hUsxuoZHNJX14JMSz
         Xa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZnFlSjJBCyiX49UFfAVbAl+DIF6Hve745f/WW6Cm4g=;
        b=NNk+9iY8rU4y0urdFZS2jWXzMYKBH2YJnBqby2zkIp4q7VLX3a/KYeoIh4kzuuYSAO
         U00fFMsbZBHPonclv6aVmhsUfFFEGTLCESsS6vg8gqautnkZwFj9ykAsWoa4Nr+rc4ZK
         4now8bN4jCGI2Eb6cjfhJ6iCqWZx7odz5I6VdbyZQvF57tckIjawrMBkjy9y6FWrb/IW
         VcBppAcBUHjlDHiP7DAqVC2tDRDYHBAkUVd/BmoqR0VBAZZuDU2FV2jSLq80Tk/3gY8t
         wZ62pDC0SaI7UiSB+Vca4PHsOYWh9MDtiES6qnk0Reh++K/Aw4m1IHveThkZ0YX0te94
         hjtQ==
X-Gm-Message-State: APjAAAU0L/UVKt1/S0Hkx+8eaG2phIlkUL6oGfGbGYDeAzC/qV9etXGa
        BiWN0A+PoD9biYCbzJ1GLbwjFQ==
X-Google-Smtp-Source: APXvYqwM0Eig5OBi4Fcw9u8Gnke2toq3nb+cBE8X1S+CvkdYpJ+6BS3jD1/GTKP9ChHZ9NmYI4swSw==
X-Received: by 2002:a17:902:bf4b:: with SMTP id u11mr525906pls.40.1573086171056;
        Wed, 06 Nov 2019 16:22:51 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i13sm155272pfo.39.2019.11.06.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:22:50 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: qcom: sdm845: Add PCIe nodes
Date:   Wed,  6 Nov 2019 16:22:44 -0800
Message-Id: <20191107002247.1127689-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe controller and PHY nodes for SDM845 and enable them for the
Dragonboard 845c.

Depends on PHY and controller supported added here:
https://lore.kernel.org/linux-arm-msm/20191107000917.1092409-1-bjorn.andersson@linaro.org/T/#t
https://lore.kernel.org/linux-arm-msm/20191107001642.1127561-1-bjorn.andersson@linaro.org/T/#t

Bjorn Andersson (3):
  arm64: dts: qcom: sdm845: Add first PCIe controller and PHY
  arm64: dts: qcom: sdm845: Add second PCIe PHY and controller
  arm64: dts: qcom: db845c: Enable PCIe controllers

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts |  91 +++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 212 +++++++++++++++++++++
 2 files changed, 303 insertions(+)

-- 
2.23.0

