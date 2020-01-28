Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8114B3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 12:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgA1LnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 06:43:16 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:39090 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgA1LnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:43:14 -0500
Received: from dslb-088-068-095-017.088.068.pools.vodafone-ip.de ([88.68.95.17] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iwOcQ-0008Dy-Mq; Tue, 28 Jan 2020 12:01:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] imx-rngc - several small fixes
Date:   Tue, 28 Jan 2020 12:00:56 +0100
Message-Id: <20200128110102.11522-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of small fixes for the imx-rngc driver.

I tried to clarify the approach for masking/unmasking the interrupt from
the rngc.

The rngc should be set to auto-seed mode, where it creates a new seed
when required.

In the probe function, we should check that the rng type is supported by
this driver.

Thanks for reviewing the patches,

   Martin


Martin Kaiser (6):
  hwrng: imx-rngc - fix an error path
  hwrng: imx-rngc - use automatic seeding
  hwrng: imx-rngc - use devres for registration
  hwrng: imx-rngc - (trivial) simplify error prints
  hwrng: imx-rngc - check the rng type
  hwrng: imx-rngc - simplify interrupt mask/unmask

 drivers/char/hw_random/imx-rngc.c | 89 ++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 19 deletions(-)

-- 
2.20.1

