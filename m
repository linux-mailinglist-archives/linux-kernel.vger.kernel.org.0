Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D411DF80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 09:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLMIcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 03:32:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57507 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfLMIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:32:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191213083209euoutp02e1760d1acf0ccc20e163f9c291c3dbfa~f4SG-EFup2392323923euoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:32:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191213083209euoutp02e1760d1acf0ccc20e163f9c291c3dbfa~f4SG-EFup2392323923euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576225929;
        bh=Spljwi04NPz7tPwQDU3ylhpMAcBmPOyA+LcLqOe48yU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=CFh7cVkn8C7UgZgkd8Mhj8lJeObDUOgbuwvO13Mc4Dq6KwMpTgONXh0iz5fwwCw/N
         lpnA1vN0169VrQDnEWgVB/E/T+UdST7BfA+QpdOWqCxtRxEQy3MKdaClbr4wq1G2de
         F7nrrZ9kQA4SNLeIX4GSh/2zwisAN/wZdJopGlVg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191213083209eucas1p1754396da771e6006222b489b7f663df6~f4SGzosdc2297822978eucas1p1M;
        Fri, 13 Dec 2019 08:32:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.9F.60698.98C43FD5; Fri, 13
        Dec 2019 08:32:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191213083209eucas1p1459831639297fc7c37089c8fef4e0248~f4SGfdDBv2219322193eucas1p12;
        Fri, 13 Dec 2019 08:32:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191213083209eusmtrp2a21176fad3e597e08b9d3a284aa1ea80~f4SGetkis0540405404eusmtrp2e;
        Fri, 13 Dec 2019 08:32:09 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-cb-5df34c89d862
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.4C.08375.98C43FD5; Fri, 13
        Dec 2019 08:32:09 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191213083208eusmtip145e8ae9917b0302b6157455e10ed1be2~f4SGEA3wv1805818058eusmtip1S;
        Fri, 13 Dec 2019 08:32:08 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND] phy: exynos5-usbdrd: Calibrating makes sense only
 for USB2.0 PHY
Date:   Fri, 13 Dec 2019 09:31:57 +0100
Message-Id: <20191213083157.9220-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87qdPp9jDb7vkbLYOGM9q8WFpz1s
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67A7vHplWdbB59W1Yxehy/sZ3J4/MmuQCWKC6b
        lNSczLLUIn27BK6MS+d/Mxbs5Kh4dvM7WwPjCvYuRk4OCQETifWf57J1MXJxCAmsYJS49GgK
        lPOFUWL9y6fMEM5nRonmgwuZuhg5wFpuLfeHiC9nlJix+TQTyCiwjg0r00BsNgFDia63XWwg
        toiAg8SSpXfApjILXGOUeN74CqxBWCBKYvmP5WBFLAKqEisvfAFbwCtgI7HsRQXEefISqzcc
        ADtCQuAym8T6noMsEAkXiTM3P7FB2MISr45vgfpHRuL/zvlMEA3NjBIPz61lh3B6GCUuN81g
        hKiyljh8/CIryDZmAU2J9bv0IT5zlNj9xQXC5JO48VYQpJgZyJy0bTozRJhXoqNNCGKGmsSs
        4+vgth68cIkZwvaQ2HSnnw0SJLESd28+ZJ/AKDcLYdUCRsZVjOKppcW56anFxnmp5XrFibnF
        pXnpesn5uZsYgfF/+t/xrzsY9/1JOsQowMGoxMPLkPIpVog1say4MvcQowQHs5IIb6r251gh
        3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGA+uE13fwRK2
        XqRZsXyai8l6u5l2F+bu5v3GcPbUz2pJjuSUW1ZeSvKRknGLZbyP2tnHGKh4TpM587n6/uM4
        A9kDZqmM5pFNO613XT/17NjybbIbwjkjluz8F7BnC1eJz8ydZ7xmzFuWHrpDo2/rB3ab2kem
        Ky/NeR5m9UfEtuMGT/3CTTkPjyuxFGckGmoxFxUnAgCw5Zn4+wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t/xu7qdPp9jDRYvYrbYOGM9q8WFpz1s
        FufPb2C3uLxrDpvFjPP7mCwWLWtltlh75C67A7vHplWdbB59W1Yxehy/sZ3J4/MmuQCWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MS+d/Mxbs
        5Kh4dvM7WwPjCvYuRg4OCQETiVvL/bsYuTiEBJYySrQvncfWxcgJFJeRODmtgRXCFpb4c62L
        DaLoE6PErmNfwBJsAoYSXW+7wBpEBJwkOteeBitiFrjFKPF5/jlmkISwQITEp03LwRpYBFQl
        Vl74wgSymVfARmLZiwqIBfISqzccYJ7AyLOAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZG
        YOBtO/Zz8w7GSxuDDzEKcDAq8fAypHyKFWJNLCuuzD3EKMHBrCTCm6r9OVaINyWxsiq1KD++
        qDQntfgQoynQ7onMUqLJ+cCoyCuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE
        08fEwSnVwMh5Tmqt3quWFe9vcU9MlbsR4uc+TYBlheHXhVoNgoyri1Tb8q6eOrw+rPGlx+vf
        7X+l5Ursti/9d//FtTtvo+ualqxM/Se71+N9Vs3m4nW9izZWVO1/bh/y99ZNA6lPNccLay9k
        pH2unb9ubtvk08031Hdwa7XtZ73TfTA3wdDsZ//L5rDF7POVWIozEg21mIuKEwHIYGwwUgIA
        AA==
X-CMS-MailID: 20191213083209eucas1p1459831639297fc7c37089c8fef4e0248
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191213083209eucas1p1459831639297fc7c37089c8fef4e0248
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191213083209eucas1p1459831639297fc7c37089c8fef4e0248
References: <CGME20191213083209eucas1p1459831639297fc7c37089c8fef4e0248@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 646259bee909..f07edd80d2f3 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -714,7 +714,9 @@ static int exynos5_usbdrd_phy_calibrate(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
+		return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	return 0;
 }
 
 static const struct phy_ops exynos5_usbdrd_phy_ops = {
-- 
2.17.1

