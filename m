Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A974FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbfGYNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:47:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47866 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390316AbfGYNrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:47:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8283200716;
        Thu, 25 Jul 2019 15:47:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9AB60200710;
        Thu, 25 Jul 2019 15:47:29 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 502B8205E8;
        Thu, 25 Jul 2019 15:47:29 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH 0/2] crypto: validate inputs for gcm and aes
Date:   Thu, 25 Jul 2019 16:47:09 +0300
Message-Id: <1564062431-8873-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added inline helper functions to check authsize and assoclen for
gcm and rfc4106.  
Added, also, inline helper function to check key length for AES algorithms.
These are used in the generic implementation of gcm/rfc4106 and aes/aes_ti.

Iuliana Prodan (2):
  crypto: gcm - helper functions for assoclen/authsize check
  crypto: aes - helper function to validate key length for AES
    algorithms

 crypto/aes_generic.c |  7 ++++---
 crypto/aes_ti.c      |  8 ++++----
 crypto/gcm.c         | 41 +++++++++++++++-------------------------
 include/crypto/aes.h | 17 +++++++++++++++++
 include/crypto/gcm.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 33 deletions(-)

-- 
2.1.0

