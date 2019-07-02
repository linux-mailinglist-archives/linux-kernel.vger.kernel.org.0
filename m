Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62625C629
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGBAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 20:02:27 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39160 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGBAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:02:27 -0400
Received: by mail-qk1-f202.google.com with SMTP id j17so7488779qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=14MOM6ICngoLLgb1hrf/bM8O+6Uy5LcBnEPwLhZGisA=;
        b=ab0ZyOF0ZZkkQMOBm16TGGEeQFK/jjtvGf3wEx27RMnXQxrDBNdaJYXoBBeGr5LnO2
         yCn6V8eE+fGZvJcjh8XYGMVFt8fgkv2h31llQxIwD0pszH2nCXpm4pmE/yAxWGiqducr
         Um/F4GZ5f+4xXzJnSDUyhYRr75CeDapfZf+W+E6QIIIEcvN/2bmVLsbnDVtTg92I11bF
         Xvi2CyLVmX4o/fXUISIVyJFG0yhus80Kd98bDgXNFc08pLguDIzHn40en5csghrqJdP/
         CoVBUT6A1KZCzgFSRU9yuIebcKq6qj/wydhx0jBqZEIurcaCWB5wcib9YZTFizzNAgmw
         Kt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=14MOM6ICngoLLgb1hrf/bM8O+6Uy5LcBnEPwLhZGisA=;
        b=i30ENDSF7Tj7eMIS1cJHvmfywor7tR7BqwWr7WgwMNczYNh0KkW/O0KwypkBiJApxi
         Kl/8lpI3il0yLbTrFUsvgjHyy+U81kzWhv/JkK3H3FIPJbGG0uOTBEi5RGVtUlVEhIoi
         4nl7oRT8W4TrkscoqxSNClIStSKn/JAVe6Lnry49Uip+6FCmsVaoGdmiajOF5b/ab4FS
         0XDCMYA0DNMcaYSreHWcUJdHA7+hQES74ypnsgGRtkkULdoPoMSJSAgkCJV+bjeCjsUS
         JHr1DsuefWii3oHq5Y0+n6e4gDDzQTbBi/eztAW/7yFJk3ZgtDgMkCExchDOraqkDz2g
         o0Cg==
X-Gm-Message-State: APjAAAUG6GsN3eCPndBjAdt2NtlfvojWoS7W3fhl2IDIBlKOj/WZht3B
        +6Th4jPqvPlzhCTQdFguDNuaX0pk
X-Google-Smtp-Source: APXvYqxrjtJzzGyzen9dN3F04N0Z8Svgc4wGjY+W5ZyOubaozgAQD8lN8zC3uAhG2jkMQE/hKlKPNVyS
X-Received: by 2002:aed:38c2:: with SMTP id k60mr21843273qte.83.1562025746390;
 Mon, 01 Jul 2019 17:02:26 -0700 (PDT)
Date:   Mon,  1 Jul 2019 17:01:32 -0700
Message-Id: <20190702000132.88836-1-cfir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] crypto: ccp/gcm - use const time tag comparison.
From:   Cfir Cohen <cfir@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Cfir Cohen <cfir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid leaking GCM tag through timing side channel.

Signed-off-by: Cfir Cohen <cfir@google.com>
---
 drivers/crypto/ccp/ccp-ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index db8de89d990f..633670220f6c 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -840,7 +840,8 @@ static int ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q,
 		if (ret)
 			goto e_tag;
 
-		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
+		ret = crypto_memneq(tag.address, final_wa.address,
+				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
 		ccp_dm_free(&tag);
 	}
 
-- 
2.22.0.410.gd8fdbe21b5-goog

