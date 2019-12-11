Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED011BC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfLKS77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfLKS77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:59:59 -0500
Received: from ziggy.de (unknown [37.223.145.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B1E021556;
        Wed, 11 Dec 2019 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576090798;
        bh=hqq+Okvmhd0TylWeXh60gyJ3vSjlTdLelZ7PE8Ug21k=;
        h=From:To:Cc:Subject:Date:From;
        b=b1YmR+VDIE7YYArcIxAzAR0HGn13WHEBHaF490Eb7/vrsXP6IW/G/PqEYwnUc+Nwm
         J5bKaUosGKX6uhBNPo7PAYKaMmvQ1xSTfliaLcS2uIshpig3f45gqEimnSWr4gj1ax
         OPXAhGspktCmVPbgjEKxDa/P5qp3jZl+z4TBRTIA=
From:   matthias.bgg@kernel.org
To:     bibby.hsieh@mediatek.com, matthias.bgg@kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: mediatek: cmdq: delete not used define
Date:   Wed, 11 Dec 2019 19:59:50 +0100
Message-Id: <20191211185950.31358-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Define CMDQ_EOC_CMD was actually never used. Delete it.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 drivers/soc/mediatek/mtk-cmdq-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3c82de5f9417..1127c19c4e91 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -12,8 +12,6 @@
 #define CMDQ_ARG_A_WRITE_MASK	0xffff
 #define CMDQ_WRITE_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
-#define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
-				<< 32 | CMDQ_EOC_IRQ_EN)
 
 static void cmdq_client_timeout(struct timer_list *t)
 {
-- 
2.24.0

