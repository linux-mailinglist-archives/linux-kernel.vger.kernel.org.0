Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C99D572B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfJMSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 14:00:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfJMSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:00:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so9031612pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8r79MD/BEEnSIAVQ+CzUkPVwR0O8qcg525+i9tMWUcw=;
        b=tlZ+GjrJmm+pMVXcYwCyYsBU7+nGadcNcqt0EGighjvOdyCryrYHXi5PRANAw+9tiC
         8/33P4psG2DscmaMjaRIAv7woVnKu87oCYZml8Y4R6FTbpPV0Wvrp2LP5KM+I6m9tYoq
         hMb+i8oLB01xKzyw7z+Vpgu26FiBLrvFijKzSQpp3yql8lwrhBP9v03UyNjxCiExyRGt
         RtxhkJVJZ22VSWdtArTRIoqRAhDZJHpI0P4eyc0BPHBKHyWapyK5fUfYxOEdyhwd5yZb
         bU+AfYSujv4QYuN1+SI6p5W2q8PvkZHZROJh9jccYyZaedYBj4OjdYGRllQgm0/QxZPf
         fkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8r79MD/BEEnSIAVQ+CzUkPVwR0O8qcg525+i9tMWUcw=;
        b=JGACO0zc/ygYEq37FEWWJ+OGDOr+frfFIrp/x+kCieGHLD9qb3U7MyEXYvyeiuPs4y
         jWS2fy8xuId1mSMp4oO3ptYcFzzSYxkv5cyNAsuV8xyMVtA3nbDqAAD6/KDOQHBPdHaE
         rqj5IoulNV6/YsRv7KtxVExp2fjMSVUq4T50AH6yIT3nA6uhwXkrsS8p7xJVBX91X1No
         kuxbCeuBxPzfKbrrJmd2hwtjyUXSDjth2ztfe3BxoRLFXXtF80pS7G0WfQHj6zA1oFhE
         DhJ9m/gmnOA1ea+5nFPC+c53i+VMzJ2puoK+z3bmIag1DQoxUfP+PJdh2Q9qxDosX0Xv
         XSsQ==
X-Gm-Message-State: APjAAAVPtD9O8SG1YFfthfvVniUB38XWjUgJCCRxCXQb/qis7A+QWZQK
        cEnLLuN6NeY24zxiyrX17z8=
X-Google-Smtp-Source: APXvYqwrPQBU3KdDEoojv8E/oAWKUha70bKAEeCHvQ2rSJAW9y8cEI1Tr16ZM//9pF3Tc6MEkwLURg==
X-Received: by 2002:a62:3387:: with SMTP id z129mr27658647pfz.253.1570989650114;
        Sun, 13 Oct 2019 11:00:50 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id s10sm29657474pgn.9.2019.10.13.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 11:00:49 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: use DIV_ROUND_UP helper macro
Date:   Sun, 13 Oct 2019 21:00:33 +0300
Message-Id: <20191013180033.31882-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DIV_ROUND_UP macro to replace open-coded divisor calculation
to improve readability.
Issue found using coccinelle:
@@
expression n,d;
@@
(
- ((n + d - 1) / d)
+ DIV_ROUND_UP(n,d)
|
- ((n + (d - 1)) / d)
+ DIV_ROUND_UP(n,d)
)

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 87535a4c2e14..74312e8bb32e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4158,7 +4158,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 
 			/*  The value of ((usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B) */
 			/*  is getting the upper integer. */
-			usNavUpper = (usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B;
+			usNavUpper = DIV_ROUND_UP(usNavUpper,
+						  HAL_NAV_UPPER_UNIT_8723B);
 			rtw_write8(padapter, REG_NAV_UPPER, (u8)usNavUpper);
 		}
 		break;
-- 
2.23.0

