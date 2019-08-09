Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87E3871B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 07:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405595AbfHIFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 01:47:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29280 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfHIFrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:47:01 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x795jYLc028981
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 22:47:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=EWzMm9ghigeuJB9dYDzNbe1DZeEzNq0DNBK3EVrXLlk=;
 b=af2/gxvALxsYCOcdUkoLYqz1b5k9YdoIvP5iYVaqpjCWP8h7VbnkGuvCUfvM5Z8poxQP
 M5bJHR8UvpvC9P7/r6AOeyi255EKQwAz6lv1ULy/u0AgvSj7Fyj94rqBDSXn0S+XExr/
 oNWPUYhgl/U0UUnKZoA+CsArUgLNe22j2PY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8x54rsw2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 22:47:00 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 8 Aug 2019 22:46:52 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id 7427F18DC8820; Thu,  8 Aug 2019 22:43:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH net-next v6 1/3] net: phy: modify assignment to OR for dev_flags in phy_attach_direct
Date:   Thu, 8 Aug 2019 22:43:55 -0700
Message-ID: <20190809054355.1015129-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090063
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the assignment to OR when dealing with phydev->dev_flags in
phy_attach_direct function, and this is to make sure dev_flags set in
driver's probe callback won't be lost.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>
CC: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Tao Ren <taoren@fb.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Changes:
  - nothing is changed in v1-v5: it's given v6 to align with the version
    of patch series.

 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7ddd91df99e3..252a712d1b2b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1270,7 +1270,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			phydev_err(phydev, "error creating 'phy_standalone' sysfs entry\n");
 	}
 
-	phydev->dev_flags = flags;
+	phydev->dev_flags |= flags;
 
 	phydev->interface = interface;
 
-- 
2.17.1

