Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89CB42F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfFLSil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:38:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfFLSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lS4UliZzmoTMkcnLKM4dNvFw1mukTFSV4no+MKbahvQ=; b=Mpl+BtW1JfZztSx6BEmm7yWdkc
        A2F64DmGTEanJtlPfQ521VN30wC2AMksvMBwHrHvpvD/QxBya0IrrAr+CQY6EpFAcei/f9jRuDjnW
        7xIgHQNE7mcLmmmHpRKdG5P5+kzyEmDQSnD2hazn/5xs4ENQBjTAIOp3i0Tz76VemRywQeiL9WDvU
        fT5AsxNemprHpZVKJkUyVtOX0QV8bCq1gvpSe7OguMWYx4NxNoEPHL5/tm8ogAcSnekuYRdeTzxyX
        Fga0oLgmzkgfNPKx8tKTLE57NiFC62rtaVu4OOVSHlUtXWpGFF4GdRWCrpX3W0vQUZhFXpdQ/r4NI
        So0DvH8Q==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YD-JB; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002BL-7f; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 17/31] docs: DMA-API-HOWTO.txt: fix an unmarked code block
Date:   Wed, 12 Jun 2019 15:38:20 -0300
Message-Id: <2e10d6694856527244a6a62e6662420d4766789c.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Sphinx, it would produce this warning:

    docs/Documentation/DMA-API-HOWTO.rst:222: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/DMA-API-HOWTO.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index cb712a02f59f..358d495456d1 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -212,7 +212,7 @@ The standard 64-bit addressing device would do something like this::
 
 If the device only supports 32-bit addressing for descriptors in the
 coherent allocations, but supports full 64-bits for streaming mappings
-it would look like this:
+it would look like this::
 
 	if (dma_set_mask(dev, DMA_BIT_MASK(64))) {
 		dev_warn(dev, "mydev: No suitable DMA available\n");
-- 
2.21.0

