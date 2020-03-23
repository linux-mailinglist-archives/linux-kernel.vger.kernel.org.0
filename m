Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C235518F4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgCWMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:31:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37616 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgCWMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:31:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id a32so7124946pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=unGw6c2ZufitdrNu+5YBhFURhwCE/NrCJkMv+/OxkYg=;
        b=osKRm7XV+UlLkbrcfQFyBUqpYN+wH6/BfZM+cAof3MaOuskwPGOX4b4p8/mMnko5Mw
         9Td860n3EVINgTQ8AQRjsHuhxMQgicPXJ8OdDmvXPOAv36Ds85nkWUxrvtve3bbuXRIm
         RDbNWmqoLNd+oY2bz9pf+IB9VxV0IMHNxDn2c9CWPJmAbUocPXXQS567ZdaICSISeKtm
         eUBVhauyx6fCxPTu0YY0uwsKtuQYBP6zcQzEMGxI1EHiCd4EZEsGd78wCcGhbSyDN3PL
         6ri90h7cFHN5KVQC1GTKvBUKMwxX1nKo6jNSpYfbgWYmppyIxyzXaZFaM+2Spl5deM5b
         U2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=unGw6c2ZufitdrNu+5YBhFURhwCE/NrCJkMv+/OxkYg=;
        b=Xacsd4JD55ArQoM6GrtOwoUBL5klwVPArlmUtVwdhORQcjlx/vbAJruztSZdJlOoSp
         6sqKrl8lMSwPbE98oZ4vcya6S+BVsQGTSn+kjgiydkYo6TBTO41Mp8ArE/1KoL2WSHn+
         h1Ye+zLLkIRvaFotcUV6rWmE4sT78gkMR7pQj0iIfwfqjCj7rYV8VzGXnYK0uZdBx/1h
         aWHiLo8Kn7BfQ1yZ1QbbiVxoLYDW1PUbyCjrLjC9Cx+CmIYY9scgBXIj3bOqSpfnSIc2
         2yquLcHqlB9GKyL58Kx7LvvXYzK3Gv7/uPzeO/QOYFgi1+nW0vSvbIexbbaUx2hzHOft
         aAgw==
X-Gm-Message-State: ANhLgQ06EgxrS6omo3MxJOMEqxMGsdec4t8RV6EOVV5ursKY0Xf4XGMo
        qoFyMTGZWozL6vGShv9hfszz
X-Google-Smtp-Source: ADFU+vs6ei/hpgxQ7OVG0nfPzPqxm4i+aQZo5jdn0+awOA69IkcLZd0TrJnKsDeFVumYxKaqfBBrvw==
X-Received: by 2002:a63:c451:: with SMTP id m17mr4671091pgg.223.1584966683070;
        Mon, 23 Mar 2020 05:31:23 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 144sm3590131pgd.29.2020.03.23.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:31:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] bus: mhi: core: Initialize bhie field in mhi_cntrl for RDDM capture
Date:   Mon, 23 Mar 2020 18:00:58 +0530
Message-Id: <20200323123102.13992-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bhie field in mhi_cntrl needs to be initialized to proper register
base in order to make mhi_rddm_prepare() to work. Otherwise,
mhi_rddm_prepare() will cause NULL pointer dereference.

Fixes: 6fdfdd27328c ("bus: mhi: core: Add support for downloading RDDM image during panic")
Reported-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index d136f6c6ca78..f6e3c16225a7 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -979,7 +979,8 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 			goto bhie_error;
 		}
 
-		memset_io(mhi_cntrl->regs + bhie_off + BHIE_RXVECADDR_LOW_OFFS,
+		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
+		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
 			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
 			  4);
 
-- 
2.17.1

