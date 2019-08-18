Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168E5915F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHRJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 05:39:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:39:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so5624193wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rg3pEHV16wLjiiBOFWW/dTYF5vTRUDPNa6t2gdjPdGA=;
        b=NLu0z+7HcZtQ5E/s2TTT31YxW33bhq1OM6Jbn8gx3N6vVZwa6dV4GKgtJWpYE0Y8iX
         Af7LE5YSYR3HLIhEPcNhrrbx/ZeYeA+Ky2BsRfIA0B7kftnROmGUKYJjw0LY2dtNPdPD
         o7yubU76uZV1dOK1xkST5Uw6FzxbOOJ/ABOBdtzeRudaiyU5gx1AzhQwgeQSgNdAXqi/
         lFikJQUjoy+meao7yFKMUH5UNphdINmKUEDo1Lli3jNj1ziUx3ZDkyzQibzEVZX6rXvZ
         PQYgfFPH7rSRfSy/YqB4f6seeNtwV9mameJ0yZg/mxdwCteA0mq/UctNlO0I43G16zk5
         EBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg3pEHV16wLjiiBOFWW/dTYF5vTRUDPNa6t2gdjPdGA=;
        b=GM2rFUaicdBeiC5mXjPEL4SAHiycvd0mPKagZydKIeqLTVHLjt3Mj7QytqDB2Zyhjj
         L1A6xTt8qLgK8mxitR12G5e43+Ukh20+r4PdbM1WJYd0MskZCzSNzVx7ir0PKUOer+aI
         V4dybACFZuR5R8rj0DXgNCfO02vvD1xQnMEZO+XG/Twk+pYTeIV3y9Hc2sNSNslKFHX6
         RJ+M4xU1GqAQGGr+qKbCXpO0F+lJauy0Y1cCGt/PKkxbmPuUHQ5ah/MeeHugi/cyZ1/Q
         vHkMRSnK4gg0h7PeMwDUxP/wLi1+9OIqVeprs9uNBc0ZtDOlpZjf6/8HnXV5GfPxF/Tl
         E1Nw==
X-Gm-Message-State: APjAAAUwjuWpq4vlA2BpfzBg1vduTBiLBZq5tMypnQXt3DOhd97m46j8
        sP2SLIpAu4lyZpGPhEPAjqVH1A==
X-Google-Smtp-Source: APXvYqxbAX4xqU+IYYCyp+eCsvInn+6oKPmthiGKS8f00EGajHRYhtaA/kTjXA6ZmjdJTR9O+KMqqw==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr20366778wrv.293.1566121173997;
        Sun, 18 Aug 2019 02:39:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q3sm11520190wma.48.2019.08.18.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:39:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH 2/2] slimbus: fix slim_tid_txn()
Date:   Sun, 18 Aug 2019 10:39:02 +0100
Message-Id: <20190818093902.29993-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093902.29993-1-srinivas.kandagatla@linaro.org>
References: <20190818093902.29993-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck
./drivers/slimbus/slimbus.h:440:3-46: duplicated argument to && or ||

Looks like this was a typo, SLIM_MSG_MC_REQUEST_CHANGE_VALUE is command
which requires transaction ID, so fix it, this also fix the warning.

Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 9be41089edde..b2f013bfe42e 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -439,7 +439,7 @@ static inline bool slim_tid_txn(u8 mt, u8 mc)
 		(mc == SLIM_MSG_MC_REQUEST_INFORMATION ||
 		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION ||
 		 mc == SLIM_MSG_MC_REQUEST_VALUE ||
-		 mc == SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION));
+		 mc == SLIM_MSG_MC_REQUEST_CHANGE_VALUE));
 }
 
 static inline bool slim_ec_txn(u8 mt, u8 mc)
-- 
2.21.0

