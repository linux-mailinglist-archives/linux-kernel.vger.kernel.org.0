Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4A3059C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 20:01:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42279 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbfEaABK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:01:10 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 May 2019 20:01:09 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 08B342CBB;
        Thu, 30 May 2019 19:53:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 May 2019 19:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=fg8Q3S/7A0Lvcu0KZhM1U56P+Ty9w
        LituQugZp3Wx28=; b=1wZ7DofR81+AVVRncg64Dh2dnG2VFEGEXP2wP2N3QVQ+n
        5FNGX/d4LmjZ3NnYvG2bW0Zoh+cjytajtnBqbGsAly/11IWIvucawy4qG5MqCSuq
        XN8M2jzgcMFByCFHivht7daM5BGL5NRnDsbTjonejUF2G+WBtwixQkv50+nKIyFc
        cMbkP+ni0zaYL5Uv0VnhUN73vKjLyrwbr+Nrbobn2VklHui5u69cCTSZGwy34o62
        rYY6k7vZWDTXWqkBc35Crdb29uRXxJy2UftV96DC2tOknsENc2zvJkbI53NmN+Hw
        jMHvFu+oyk3ndFvYlOKrhne+GSiHV1yErC6AjVY2g==
X-ME-Sender: <xms:Fm3wXNv1E-ENAWSDhnXBlM_XdMntB_mGFzxb2_n-I6gycX9wunqHTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeftddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfggtggusehttdertddttddvnecuhfhrohhmpeeuvghnjhgrmhhi
    nhcuufhhvghrmhgrnhcuoegsvghnjhgrmhhinhessggvnhhshhgvrhhmrghnrdhioheqne
    cukfhppeduvdekrdduudefrddujedruddvvdenucfrrghrrghmpehmrghilhhfrhhomhep
    sggvnhhjrghmihhnsegsvghnshhhvghrmhgrnhdrihhonecuvehluhhsthgvrhfuihiivg
    eptd
X-ME-Proxy: <xmx:Fm3wXBGgxtXFLXR35JUbGB6VDROkFFb-rmTg1pHybHnDSBGqRmWJCg>
    <xmx:Fm3wXGwjr9hOzbcQGxTf9wGKxtgrM9zMAdl4JuDDEHBkq-1gI64f8w>
    <xmx:Fm3wXD0Z_LT3TUjzb7Qp5WK15PzViFs9wcUfBPvR77XuRnQLRgehmA>
    <xmx:Fm3wXGRLT314edzJsOG7mgDX1lK3OGnh_NO1aRkGFHEK3GY5-6AGCL2mLVk>
Received: from valkyrie-prime.rpi (el-tovar-33.dynamic2.rpi.edu [128.113.17.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E3A9380084;
        Thu, 30 May 2019 19:53:58 -0400 (EDT)
Date:   Thu, 30 May 2019 23:53:48 +0000
From:   Benjamin Sherman <benjamin@bensherman.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-dma: sizeof via pointer dereference
Message-ID: <20190530235348.j3orly64wadtjydx@valkyrie-prime.rpi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the size of a struct into kzalloc by pointer dereference.  This
complies with the Linux kernel coding style and removes the possibility
for a bug if the pointer's type is changed.

Signed-off-by: Benjamin Sherman <benjamin@bensherman.io>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index a58725dd2611..60db06768c8a 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -468,7 +468,7 @@ static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
 	if (len <= 0)
 		return NULL;
 
-	desc = kzalloc(sizeof(struct mtk_hsdma_desc), GFP_ATOMIC);
+	desc = kzalloc(sizeof(*desc), GFP_ATOMIC);
 	if (!desc) {
 		dev_err(c->device->dev, "alloc memcpy decs error\n");
 		return NULL;
-- 
2.21.0

