Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B12164930
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBSPvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 10:51:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39920 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBSPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:51:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so1118685wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlNA5caPFDkRRH0y0qsccyBK12IFqz12JUTfxJlSVCM=;
        b=vsPf0AKcpWyPNj6F2JMoW6AtOfj+k/44fPz0eHs3WR9SU8e788OrvazJ4K+MAcaAqN
         INmpJrIB4W7COEiD4pvB+3El/FioM3wJAFyWr64DD6jLRr0/esnS5ywD4R6Uon6cf0yN
         0R4+mXOmfl2a1xQQayyf/1zH8L8S0f3FU1F3zgk6Bx4t4UkR4ebYPNtnDo+qhouPswAU
         gVLHHT5Bzzk3fu2wKB9RRkzxdD9CiRntJXWvGYO2V26GjWgVumFWfmRq9SUIAQacqlm7
         VG1Y3qxLU5VqtyBvVe8/VrgGucpZ1KTA31eE2tnOg6yl+Kuf/WXv5V2A/Yrvpu1ws3+S
         poaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlNA5caPFDkRRH0y0qsccyBK12IFqz12JUTfxJlSVCM=;
        b=T/O5HHVdl/kSLKYNlQjDwOjAcZI6fXZY5k1rFlbsCBbAYE637Yv5i3H2FzTWaFFLzH
         NVjpcY96Y+tAeqymyUYfvvoZssQQsKUWGwIM6RjABYyOx5vRac+KLcvhxwuaXkafW+mF
         MmwoKcdObGoJk63gr9des2vfvwEVUb5pG8eT/FMwnB1EzOj5qUiNhxG5BE8IB+j8d+gU
         72OsKI3WrafuXnz+WuHciveUuydvImknxOKTBimT0UXSiHoZGbW0KgorZZKNDgRnLUbg
         fgoNT3QDPgDKWCRniOpvbFBN2q5dQnBPrzGtmDMQMSlnnqBC4HTauXKp5dHQ+/7o2QkI
         0jFQ==
X-Gm-Message-State: APjAAAWGR9t2CzyD2y4wNUnlj6PjKXEushb9PEmVxjb/IbYztaOXJsfP
        7nqhvOiQ7olO+Hk7cclcALG2uYWFzL0=
X-Google-Smtp-Source: APXvYqyPz9quIQgUnKHU3+UaSMfbxNnk62gkJXMkIlQjMT7rfQaC77nit7zVt3ALZ/CjtPhn7Ddgag==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr35278231wru.181.1582127502904;
        Wed, 19 Feb 2020 07:51:42 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id d4sm251578wra.14.2020.02.19.07.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 07:51:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] crypto: drbg: DRBG_CTR should select CTR
Date:   Wed, 19 Feb 2020 15:51:35 +0000
Message-Id: <1582127495-5871-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582127495-5871-1-git-send-email-clabbe@baylibre.com>
References: <1582127495-5871-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if CRYPTO_DRBG_CTR is builtin and CTR is module, allocating such algo
will fail.
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
DRBG: could not allocate CTR cipher TFM handle: ctr(aes)
alg: drbg: Failed to reset rng
ialg: drbg: Test 0 failed for drbg_nopr_ctr_aes256

Since setting DRBG_CTR=CTR lead to a recursive dependency, let's depends
on CTR=y

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 6d27fc6a7bf5..eddeb43fc01c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1822,7 +1822,7 @@ config CRYPTO_DRBG_HASH
 config CRYPTO_DRBG_CTR
 	bool "Enable CTR DRBG"
 	select CRYPTO_AES
-	depends on CRYPTO_CTR
+	depends on CRYPTO_CTR=y
 	help
 	  Enable the CTR DRBG variant as defined in NIST SP800-90A.
 
-- 
2.24.1

