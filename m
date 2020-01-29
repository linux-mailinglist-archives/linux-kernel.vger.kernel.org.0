Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3706914CC95
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA2OiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:38:15 -0500
Received: from foss.arm.com ([217.140.110.172]:41980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgA2OiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C045A1045;
        Wed, 29 Jan 2020 06:38:12 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BB163F52E;
        Wed, 29 Jan 2020 06:38:11 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: ccree - fix some reported cipher block sizes
Date:   Wed, 29 Jan 2020 16:37:56 +0200
Message-Id: <20200129143757.680-4-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129143757.680-1-gilad@benyossef.com>
References: <20200129143757.680-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OFB and CTR modes block sizes were wrongfully reported as
the underlying block sizes. Fix it to 1 bytes as they
turn the block ciphers into stream ciphers.

Also document why our XTS differes from the generic
implementation.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index c08dee04941b..73457548ee92 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -1236,6 +1236,10 @@ static const struct cc_alg_template skcipher_algs[] = {
 		.sec_func = true,
 	},
 	{
+		/* See https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg40576.html
+		 * for the reason why this differs from the generic
+		 * implementation.
+		 */
 		.name = "xts(aes)",
 		.driver_name = "xts-aes-ccree",
 		.blocksize = 1,
@@ -1431,7 +1435,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 	{
 		.name = "ofb(aes)",
 		.driver_name = "ofb-aes-ccree",
-		.blocksize = AES_BLOCK_SIZE,
+		.blocksize = 1,
 		.template_skcipher = {
 			.setkey = cc_cipher_setkey,
 			.encrypt = cc_cipher_encrypt,
@@ -1584,7 +1588,7 @@ static const struct cc_alg_template skcipher_algs[] = {
 	{
 		.name = "ctr(sm4)",
 		.driver_name = "ctr-sm4-ccree",
-		.blocksize = SM4_BLOCK_SIZE,
+		.blocksize = 1,
 		.template_skcipher = {
 			.setkey = cc_cipher_setkey,
 			.encrypt = cc_cipher_encrypt,
-- 
2.25.0

