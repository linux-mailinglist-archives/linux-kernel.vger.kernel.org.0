Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA2BFA14
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfIZTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 15:31:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37140 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfIZTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:31:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so77343lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpnXCf/HybG5XSeKNp7kzvBJ50vY8go7MkgfgdvaShI=;
        b=XZ0S5O0uQTQMwhxLL41DSMfikWoJ+Zs42XaIt4vcp39qAmylrjIhHttHHZGt62Lqgq
         j6lJpsyWPyjhTDRoHvsqWOSxG1WlC1O4wRAdo3NpVTCkaVdKfPNaWLZX2RPryUn8qFgX
         +8FwsF/AoziJtSfORlEBtiaIC2juWAbFjpBnMMmHYQB9e3y40sHrJOCXetMx9ZaJAiFF
         H2W8BaTwHMBeq9ss2Fy1pwrGIlWyY0GoudPK30zMzvUDy/YDDq2+v+ga/B2PTAwvK+RN
         Tz84vTK2MoC+Eky1RsdeBl3pf3EBoWWAln12R2Mui8mf7UyUw74OmamRhqz/I6W91imL
         axHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpnXCf/HybG5XSeKNp7kzvBJ50vY8go7MkgfgdvaShI=;
        b=CO9vJfJ9WGUSZH5LjE+UBcP2xTS9DFfWPepC7nPbAaSAJtmP72lnpMF/Mp5td3drpQ
         uVew8+VRr2JFWT/20CjQ1qleaVXMI3W0juNXr7eq3MLTWbW9WCRCWR2Dbi+EJduVw7M/
         V97t8oHxu5IxXP5X812BtN96RTPKuypg6wLqfP1Shopd+5V8R+2ud6ir2vS9IesJ60y+
         dOkHD5xlzFw0tKI58Gh/dXD11vC6r49A/s/PIVtIKsjeivU2dQDWmqXJuOGCZ1E+v2me
         tnwCZM5KMZqXxgpfBMRFNgMhC00jIRsT7ILHexPSTSTk/GvIbIt+8QZALc0OVYXpYEwd
         Bd4w==
X-Gm-Message-State: APjAAAVhvYTqzL5Z/9wx8ngFQ3paBKFLyFEvg/o3Fmc+WEgA/yZcRkzP
        WGSxTEh9Mq6gIyWG9pu2rdqszA==
X-Google-Smtp-Source: APXvYqxy2JdP/F9JgNbwliZiSpfLsMTo3iNTUmowmblH/PR+XD9B+IA1+fyEmeXbFWB1sf1pT34eUg==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr112924lff.103.1569526258319;
        Thu, 26 Sep 2019 12:30:58 -0700 (PDT)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id t16sm31584lfp.38.2019.09.26.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:30:57 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: configs: defconfig: remove unneeded fragments
Date:   Thu, 26 Sep 2019 21:30:28 +0200
Message-Id: <20190926193030.5843-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926193030.5843-1-anders.roxell@linaro.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 833c97254724 ("arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP
modules") ment to enable the camera framework and drivers but enabled a
bit more.

Since we don't have any drivers for MEDIA_ANALOG_TV_SUPPORT or
MEDIA_DIGITAL_TV_SUPPORT theres no meaning to enable the framework to
the defconfig.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e05c39eab08..56dc7488ff36 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -501,11 +501,8 @@ CONFIG_IR_MESON=m
 CONFIG_IR_SUNXI=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
-CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
-# CONFIG_DVB_NET is not set
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
2.20.1

