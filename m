Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D344AC52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfFRUzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 16:55:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbfFRUx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lS4UliZzmoTMkcnLKM4dNvFw1mukTFSV4no+MKbahvQ=; b=Cv7B9ClMNS+1bWV9iwTIUUNykY
        i5mQmHtJbkf4x5eEEkCChnCoiZx2AR0XvwejGX+wKFBbUH/eYjVqWbRO/YztYzrUhH4g2vrbtQd5Q
        mPCatGIcsbwydENRbPbJ5A/0hbaF/fDBiXdtnPBo2aRzpoguqmuV8GpZnFcePdkgflcOy5Ri8k0Id
        ZF1JTSoTMVpLiBjw0MJOXmk3lPsvdzTN64QuGP/OHSSfFbcoMBnGkZQoCjPLhJVnqLiHhWMVq/2zb
        iX/OXDeSJEXpr2JJBMpdk3JvEiDnpP25Bbis0XfMDrNtjHc/RlGE4vPOQ9EnyxyXGciQbqZG+jMed
        Ihyw420Q==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL77-0008RV-2i; Tue, 18 Jun 2019 20:53:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL70-0001zx-3e; Tue, 18 Jun 2019 17:53:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 17/29] docs: DMA-API-HOWTO.txt: fix an unmarked code block
Date:   Tue, 18 Jun 2019 17:53:35 -0300
Message-Id: <9b83a9b1e815daf0266d49fcacfe713540276ff3.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
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

