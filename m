Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC44317B025
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 21:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCEU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 15:59:26 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:43258 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgCEU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:59:26 -0500
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1j9xaN-0000e9-3L; Thu, 05 Mar 2020 21:59:15 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/5] imx-rngc - several small fixes
Date:   Thu,  5 Mar 2020 21:58:19 +0100
Message-Id: <20200305205824.4371-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200128110102.11522-1-martin@kaiser.cx>
References: <20200128110102.11522-1-martin@kaiser.cx>
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

changes in v2:
- remove the contentious devres patch
- add PrasannaKumar's tags

Martin Kaiser (5):
  hwrng: imx-rngc - fix an error path
  hwrng: imx-rngc - use automatic seeding
  hwrng: imx-rngc - (trivial) simplify error prints
  hwrng: imx-rngc - check the rng type
  hwrng: imx-rngc - simplify interrupt mask/unmask

 drivers/char/hw_random/imx-rngc.c | 85 +++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 16 deletions(-)

-- 
2.20.1

