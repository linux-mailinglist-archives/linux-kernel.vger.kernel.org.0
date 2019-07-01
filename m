Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25755993E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF1L1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 07:27:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1936 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbfF1L11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:27:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SBQSqA008465;
        Fri, 28 Jun 2019 13:27:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RJqJPwy5FupsECpRr76jUlzOG75dPg4XX7HjL42ex0k=;
 b=EgHHT5K/GSk9XVoJ/wp0aAS6Xf34yhcc2+z0AIY/CmSxGke0kAUgtHmn+fh2J8QK1rNO
 /M+b6oflRD0jc/AiMaMdqUewvZcDzzEvY0tiCs/mDteM2ga/ul4tq3bU+lVWKGRpGfcS
 RUs1VzHcPVH4AzWmeFRyqm+Z7yxPcQxBeCOPl838zckkzU2ktAdduhRTaMX+KYtiOROW
 of5YZw6mO8DwNYWCmhlK3uR0Ny0jFwDhnf4/Ml1qnt8ffGH/RTgCiTyc/tw/G5Syx7t7
 KN/SStbES5BP8Mxktg5Sln0KYBVkj9QPhF2HwGK/DnNtTGifbREnRIhL71+SoobJ5RKW 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t9d2gwgny-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Jun 2019 13:27:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F76731;
        Fri, 28 Jun 2019 11:27:14 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E66127A5;
        Fri, 28 Jun 2019 11:27:14 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 13:27:14 +0200
Received: from localhost (10.201.23.65) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun 2019 13:27:13
 +0200
From:   Lionel Debieve <lionel.debieve@st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] crypto: stm32/hash: Fix hmac issue more than 256 bytes
Date:   Fri, 28 Jun 2019 13:26:54 +0200
Message-ID: <20190628112655.9341-2-lionel.debieve@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628112655.9341-1-lionel.debieve@st.com>
References: <20190628112655.9341-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct condition for the second hmac loop. Key must be only
set in the first loop. Initial condition was wrong,
HMAC_KEY flag was not properly checked.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 drivers/crypto/stm32/stm32-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 29519d1c403f..c37d1a336f98 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -349,7 +349,7 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 		return -ETIMEDOUT;
 
 	if ((hdev->flags & HASH_FLAGS_HMAC) &&
-	    (hdev->flags & ~HASH_FLAGS_HMAC_KEY)) {
+	    (!(hdev->flags & HASH_FLAGS_HMAC_KEY))) {
 		hdev->flags |= HASH_FLAGS_HMAC_KEY;
 		stm32_hash_write_key(hdev);
 		if (stm32_hash_wait_busy(hdev))
-- 
2.17.1

