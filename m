Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D79AA82F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfIEQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 12:18:22 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33382 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388496AbfIEQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:18:17 -0400
Received: by mail-pg1-f179.google.com with SMTP id n190so1698537pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ny7YX6BxIHZBg/a0IXvofczDmYcoW0RMjpIj9iNxGYI=;
        b=YlFW1oYkgedY1H7kdvtntMbQozGn3kOxCMqp2NIumUNGka9YZY56mm/5JnjNo8a6sg
         BpG6Faq+3L6/s3liaVWlfJHdXuBMamArc6Tke+yxoc3WFo/JaJ3GGn7dtJ+2eGI/ZSPm
         WmOtxGPCrHlhUdg0lKZxrCxzFFciRcVyZ4C2H/w5nX6/ePlCd5vC7MVmOunp7NW+n+KY
         kwRBcBObjxbXwA0p2AO+21wka8/782dXgpI6hfmtYJ3uAgtu6VJVYXFKQIJ0U+B9Jx+a
         cnY4OkG7/6sBLkpOWgOpybs5Q6WX+6CfltrwCTUB6XO+nb6zY7AjGP6RiFK/d+51XXVM
         jSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ny7YX6BxIHZBg/a0IXvofczDmYcoW0RMjpIj9iNxGYI=;
        b=I+aXhzinmfFjXL69nxxe8alnfPYaE4mr06Y0CDEHEgZprpnWpuKShGMmF9tfyyBINz
         xlGIO1YqUStd3erYVTFIt2776B1gwxG1lbV33d5hwPf72ydUFcJ1pprhwSyQ3hsRMUkU
         v6ZPyhkzlJYN2esjEx2X9l39wrkznbhIwsvIcWpNXHvnM4XDe+A887xiBQTKwqq4GR3J
         tqkmkaUGCIZf7zrgtLohFwU/e5bcFABzW009KvB3uJPhMBgVKAUtEMcXUu3H5rbjPOMw
         sRXmpL/F+CGAzO6R9Ouej6E4eOp/z2NQ48R4oiz7w5ZePDWzKHT8PBuA5MQW2ceeFnN0
         YUEQ==
X-Gm-Message-State: APjAAAU8mPWlbPqRakDnLtexTdIqdiifN92klbKe2g7ZpdMTP/PnHj4f
        6eQ4GBS6DJEy+GwQX+PKMOxBEg==
X-Google-Smtp-Source: APXvYqwKA9IK1vUfcaYpjMN+OcoAuPYIhWjw5YDLjt28SgdQJQGNYVmg1+PKFIED4Sz9PCGNnWl8iw==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr4734304pfo.231.1567700296683;
        Thu, 05 Sep 2019 09:18:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m129sm6324005pga.39.2019.09.05.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:18:16 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [BACKPORT 4.14.y 13/18] ASoC: tlv320dac31xx: mark expected switch fall-through
Date:   Thu,  5 Sep 2019 10:17:54 -0600
Message-Id: <20190905161759.28036-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

commit 09fc38c1af4cb888255e9ecf267bf9757c12885d upstream

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1195220
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d3bd0bf15ddb..cc95c15ceceb 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -941,7 +941,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		dsp_a_val = 0x1;
+		dsp_a_val = 0x1; /* fall through */
 	case SND_SOC_DAIFMT_DSP_B:
 		/*
 		 * NOTE: This CODEC samples on the falling edge of BCLK in
-- 
2.17.1

