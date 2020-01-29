Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE7214CC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgA2OiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:38:06 -0500
Received: from foss.arm.com ([217.140.110.172]:41950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgA2OiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52E5D31B;
        Wed, 29 Jan 2020 06:38:05 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE25D3F52E;
        Wed, 29 Jan 2020 06:38:03 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: ccree - fixes
Date:   Wed, 29 Jan 2020 16:37:53 +0200
Message-Id: <20200129143757.680-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes in AEAD DMA mapping code and blocksize reporting

Gilad Ben-Yossef (4):
  crypto: ccree - protect against empty or NULL scatterlists
  crypto: ccree - only try to map auth tag if needed
  crypto: ccree - fix some reported cipher block sizes
  crypto: ccree - fix AEAD blocksize registration

 drivers/crypto/ccree/cc_aead.c       |  1 +
 drivers/crypto/ccree/cc_buffer_mgr.c | 68 +++++++++++++---------------
 drivers/crypto/ccree/cc_buffer_mgr.h |  1 +
 drivers/crypto/ccree/cc_cipher.c     |  8 +++-
 4 files changed, 39 insertions(+), 39 deletions(-)

-- 
2.25.0

