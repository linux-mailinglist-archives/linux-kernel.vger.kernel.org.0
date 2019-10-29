Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A89E8718
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 12:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfJ2L3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 07:29:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54988 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbfJ2L3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:29:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so2146307wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=a7btE6bNZTalO6uJ2Q3J3SGFmmVteAIhrL2W5H4pHkfPFeWdizziBlnvYU1k1l7H1z
         VdrT98Yc2YK24o81kwrEhi25dlcKpAucXw20r5kJuGqR0fzFvFUw8IyUa3TgkZ2+N/t0
         kalOcSQm4sdNPsAmabcWb0eXbbr+cuZ9EAttgV9ScQoeY44mDD7Z2p8rOaFugm7ina25
         mWzB9+MTesKrQxHw6b6ECD69xcpwkkFvtIJszfhMRF/Ixrj+yHOnxxXqXgGK4gF1kTLt
         3V1IwLIrJdwy4tglpaWjmrMYZFXtJAcIj1zPGzAeDvXzO4ghDIJGPkCuTuwW2LyBmXRv
         xIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC1onaWGjgTiGrUp75mNaoNmZWZWn8ozsG+Lz8zEBxg=;
        b=VkVr9RVul4q6ix/pYT8MYmpNyJkigMRhmvnrp1dVhCHuq2awm6L+Z/c5qE9cnfcdmV
         cyps72LJEjuTpLU6b6ZqAN/xvUbAhlc6XNjKPCMwKRRY+GV6f9ubc/gyqsd4Zn8cgvND
         yC0HuC53T2hFYLzHa2uQGeX8Jm0rA/tz6/vC6BjX9KUP5JBE2zww1jrBzfArkdxvCDTc
         CJhQQep+MOx2NV7omNSXUJRbRsOb5KIHNyEw9DmnEkYzZ9hiDiKT0FlEVydsm1vxtPQa
         SkY8tUnA0hf2o3exEFIfQAXfCvaAuJ6vlQc8X+SjG2y5s8JczAOVojYuewDbSbXZL7S5
         xklA==
X-Gm-Message-State: APjAAAVnFUS+WEpfkF5ESBnoKbOI2An/cQePUD7tFspSClUvShcR0cFy
        Uss6g69rZJ+qYcNZjyJoVBT/+A==
X-Google-Smtp-Source: APXvYqy1tl4LyuCywYWNRuqXZdWjtRzeYlP86wtCjCStz54zWcC6oJciXhUYQAJM9je4iY3Kq745ww==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr3548367wma.65.1572348547207;
        Tue, 29 Oct 2019 04:29:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f20sm2373247wmb.6.2019.10.29.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:29:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 10/11] ASoC: qcom: dt-bindings: Add compatible for DB845c and Lenovo Yoga
Date:   Tue, 29 Oct 2019 11:26:59 +0000
Message-Id: <20191029112700.14548-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible strings for DB845c and Lenovo Yoga C630
soundcard. Based on this compatible strings common machine driver
will be in better position to setup board specific configuration.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,sdm845.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
index 408c4837e6d5..ca8c89e88bfa 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
@@ -5,7 +5,10 @@ This binding describes the SDM845 sound card, which uses qdsp for audio.
 - compatible:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "qcom,sdm845-sndcard"
+	Definition: must be one of this
+			"qcom,sdm845-sndcard"
+			"qcom,db845c-sndcard"
+			"lenovo,yoga-c630-sndcard"
 
 - audio-routing:
 	Usage: Optional
-- 
2.21.0

