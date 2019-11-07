Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B82F3960
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 21:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKGURW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 15:17:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKGURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id i10so4542155wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa6zPAo+YKu4/swyBIVIn4JlZMDMbBdI4/pSMmOsjVY=;
        b=UYGqinQHyqZIppvIcVqUyOQCgWCGngK6A/7+UHZglau2c8Oz6o2jzn0pUp/AczP1Ir
         JdegspDcYdAdzHIIGNKfyq1e0o3xm6PHtc6DyzYMqhCQz9FlSk06ALhiLY0HN9F4pSg5
         fVr9dizjSL1GRn4AvPgL71JHOBSG8NWS+y8bL6j63ZHDLGafFgapbMFEuZR3xE1qgekI
         H5sQGa/mQvD9Yfan4oOqnLq/IonTJazCq19dkJlFFCH6AICdlsy5Jh5vxGqGbhi5zqa6
         WR0MMzImLZmxr6M6nfTGO/tgLKV0Ty536p5nbF+igIw0CkFrVeSAY3zEy0lmjOosuCAu
         D4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa6zPAo+YKu4/swyBIVIn4JlZMDMbBdI4/pSMmOsjVY=;
        b=uMgm6H6+c2ckjfc1j0fahuF9xcMkZoooJ3OQKtRDwO87XBy93SHyBOij49OWe2mX0W
         rcqeLuxbpflkMfcBRv8JrGSAEW/6jhsWODviqWP1kFm20aiQvz/hErRElROZ5bAeTKq0
         CN37ZdACBArBKQD8c5va2wB6G7ZIZQOo7J4+xgg2yiRmz0HQwULPaGnhQvvg7QEfdaHh
         /kEhAHKsm81IbKInnRRetID2bchNLH8gvfSMdXRw4FFnDcS92jJOw8o7yIAsVAyyM9x2
         7jFSeoSxesPaXdJSvxjwqr/dCxrljzXGRVQ9PdBnsrSgVj0zz6j4OKPkAljAr8sL/6ik
         4fiA==
X-Gm-Message-State: APjAAAXQ7H0jcxQ2hvhajkl/ve38c/CQfLypSbNpP6Or4B0F56f0ug/d
        RUoEeL40O5v8LkxI09RVF3wZlA==
X-Google-Smtp-Source: APXvYqyIDYZki3Hcy87XKUSJcJYOnIsQ54TNVpbKrjvGilXExqgL+p8sbIRuF7xsxoxBfxy89BNs+g==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr4595221wrs.191.1573157833238;
        Thu, 07 Nov 2019 12:17:13 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/10] bnx2x: Check if transceiver implements DDM before access
Date:   Thu,  7 Nov 2019 20:17:00 +0000
Message-Id: <20191107201702.27023-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>

[ Upstream commit cf18cecca911c0db96b868072665347efe6df46f ]

Some transceivers may comply with SFF-8472 even though they do not
implement the Digital Diagnostic Monitoring (DDM) interface described in
the spec. The existence of such area is specified by the 6th bit of byte
92, set to 1 if implemented.

Currently, without checking this bit, bnx2x fails trying to read sfp
module's EEPROM with the follow message:

ethtool -m enP5p1s0f1
Cannot get Module EEPROM data: Input/output error

Because it fails to read the additional 256 bytes in which it is assumed
to exist the DDM data.

This issue was noticed using a Mellanox Passive DAC PN 01FT738. The EEPROM
data was confirmed by Mellanox as correct and similar to other Passive
DACs from other manufacturers.

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Acked-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I4cae3b2ae3a298d6c0a7dd3fbf6fe97c1acba239
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c | 3 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 2a518c998ecc..57014e89a3c6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -1531,7 +1531,8 @@ static int bnx2x_get_module_info(struct net_device *dev,
 	}
 
 	if (!sff8472_comp ||
-	    (diag_type & SFP_EEPROM_DIAG_ADDR_CHANGE_REQ)) {
+	    (diag_type & SFP_EEPROM_DIAG_ADDR_CHANGE_REQ) ||
+	    !(diag_type & SFP_EEPROM_DDM_IMPLEMENTED)) {
 		modinfo->type = ETH_MODULE_SFF_8079;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
 	} else {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
index d9cce4c3899b..e909275ff2af 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.h
@@ -60,6 +60,7 @@
 #define SFP_EEPROM_DIAG_TYPE_ADDR		0x5c
 #define SFP_EEPROM_DIAG_TYPE_SIZE		1
 #define SFP_EEPROM_DIAG_ADDR_CHANGE_REQ		(1<<2)
+#define SFP_EEPROM_DDM_IMPLEMENTED		(1<<6)
 #define SFP_EEPROM_SFF_8472_COMP_ADDR		0x5e
 #define SFP_EEPROM_SFF_8472_COMP_SIZE		1
 
-- 
2.24.0

