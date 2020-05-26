Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115D319B8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 01:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgDAXKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 19:10:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48304 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:10:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJmUu-0006TV-Ta; Wed, 01 Apr 2020 23:10:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: marvell: fix double free of ptr
Date:   Thu,  2 Apr 2020 00:10:12 +0100
Message-Id: <20200401231012.407946-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently in the case where eq->src != req->ds, the allocation of
ptr is kfree'd at the end of the code block. However later on in
the case where enc is not null any of the error return paths that
return via the error handling return path end up performing an
erroneous second kfree of ptr.

Fix this by adding an error exit label error_free and only jump to
this when ptr needs kfree'ing thus avoiding the double free issue.

Addresses-Coverity: ("Double free")
Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 946fb62949b2..06202bcffb33 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -1161,13 +1161,13 @@ static inline u32 create_aead_null_output_list(struct aead_request *req,
 					   inputlen);
 		if (status != inputlen) {
 			status = -EINVAL;
-			goto error;
+			goto error_free;
 		}
 		status = sg_copy_from_buffer(req->dst, sg_nents(req->dst), ptr,
 					     inputlen);
 		if (status != inputlen) {
 			status = -EINVAL;
-			goto error;
+			goto error_free;
 		}
 		kfree(ptr);
 	}
@@ -1209,8 +1209,10 @@ static inline u32 create_aead_null_output_list(struct aead_request *req,
 
 	req_info->outcnt = argcnt;
 	return 0;
-error:
+
+error_free:
 	kfree(ptr);
+error:
 	return status;
 }
 
-- 
2.25.1

