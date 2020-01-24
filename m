Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2A1490CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 23:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAXWVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 17:21:07 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:56851 "EHLO
        4.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:21:06 -0500
Received: from player778.ha.ovh.net (unknown [10.108.42.75])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7A474158438
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 23:21:05 +0100 (CET)
Received: from sk2.org (unknown [77.240.182.90])
        (Authenticated sender: steve@sk2.org)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id E8C14EA12AF8;
        Fri, 24 Jan 2020 22:20:58 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Atul Gupta <atul.gupta@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] crypto: chelsio - remove extra allocation for chtls_dev
Date:   Fri, 24 Jan 2020 23:20:51 +0100
Message-Id: <20200124222051.1925415-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7913106020267085241
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdejjedrvdegtddrudekvddrledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chtls_uld_add allocates room for info->nports net_device structs
following the chtls_dev struct, presumably because it was originally
intended that the ports array would be stored there. This is suggested
by the assignment which was present in initial versions and removed by
c4e848586cf1 ("crypto: chelsio - remove redundant assignment to
cdev->ports"):

	cdev->ports = (struct net_device **)(cdev + 1);

This assignment was never used, being overwritten by lldi->ports
immediately afterwards, and I couldn't find any uses of the memory
allocated past the end of the struct.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/crypto/chelsio/chtls/chtls_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index 18996935d8ba..1311488be37d 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -230,8 +230,7 @@ static void *chtls_uld_add(const struct cxgb4_lld_info *info)
 	struct chtls_dev *cdev;
 	int i, j;
 
-	cdev = kzalloc(sizeof(*cdev) + info->nports *
-		      (sizeof(struct net_device *)), GFP_KERNEL);
+	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		goto out;
 
-- 
2.24.1

