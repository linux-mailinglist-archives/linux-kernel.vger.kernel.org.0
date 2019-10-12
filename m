Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA3D4CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 06:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfJLETB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 00:19:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43632 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfJLETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 00:19:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id i32so6888860pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Biq3dW4bW0477lomZDFZTi490SFYFw1BtO4yj510/vM=;
        b=r4RIe8BNwJ0mRu0383jbVNv+Pew63+jHslfI95XxABq09NjQfA2VbtjGuA/gXOLAQl
         HZetYhW/n8CUHfMwH+Y/FRz0K1JSfvFnABT3Ywkd2sDXc97PjH/UNuAVYbf7TQ7Vw/+C
         nDzAyJqC2ovtyVsY9x9bWkGB57LysASSXRfqls9P+Xs+CwKeCOCvAIkMhtdwb8dc2csx
         RaQ/2BfeD5ZLEhTvJyyVcMc62wuRuAHNtxzSWPhLn3emvnNagm/59SAH8BfJGCsgei6h
         KPjHK6QiSX2LhCf7rkvGvgxYHV6TDPoeFBIDb39q6g3YEv+9ZdsqQ474ZBj0zpWCjXo0
         vI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Biq3dW4bW0477lomZDFZTi490SFYFw1BtO4yj510/vM=;
        b=mootJTwH9uscjKGKgeFznkGzFUC3kg0gOtDxokly7camIq+F0h4OoXzgqlH9eDrMK4
         ooNnrUxcqeywTh9azeSQozidHrzErpYIX36dHJm3L5UiYb3GY8ufxuTfs96r6Uh7ouOc
         S63yjEPmBCKdVV2d4n6JnuWDN8grd0Tjlmyuza4oudvnjyuw23Sz3jvkWMzNOkidH8Nr
         IuIXBrjx26yPjfeBv6kufsEuTa+ITyLhFNfNtDqzwM3XRnjlYtt+ofzEcZaOgSnwbkxP
         ADtxeuhH8tNnVHe4uFD2K1bgek8W7rWWR3Qpckg30ctUbdKBOYu0CsNg3B0Z1NpQz37Q
         aY/A==
X-Gm-Message-State: APjAAAW+LZrHPFDmU3ePqVwcyfiKVpYSuukiMMonLkTFSH9GiMIQNBw7
        nktYSkyoArGQVBNbQrZMySNKjg==
X-Google-Smtp-Source: APXvYqyVEDPBqKwv5CKlG8eF2KQdfnZBkXGmGTJfcvzir7jHGT9V5OIUDE2xY5S2OQRADy06KWyO9Q==
X-Received: by 2002:a62:8305:: with SMTP id h5mr19838213pfe.190.1570853939670;
        Fri, 11 Oct 2019 21:18:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u9sm11142953pfl.138.2019.10.11.21.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 21:18:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SPI and QSPI controller
Date:   Fri, 11 Oct 2019 21:18:55 -0700
Message-Id: <20191012041855.511313-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the drivers for GENI SPI and QSPI controllers found on the
Qualcomm SDM845 platform, among others.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 688c8f200034..dcada299ff4d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -391,7 +391,9 @@ CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
+CONFIG_SPI_QCOM_QSPI=m
 CONFIG_SPI_QUP=y
+CONFIG_SPI_QCOM_GENI=m
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPI_SUN6I=y
-- 
2.23.0

