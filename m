Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340A05A7DA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 02:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfF2AVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 20:21:53 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59532 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2AVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561767711; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=2u+dINe52UObTbJir5DDZT8IHGO7esAqzayL0KxbZvU=;
        b=ABDBLkcbB0ZQBHHl5cgmWHQxiPvABTLUeEOunIoQ0jzXAHC4dVl9UBSZMFDPxLQoLWR3jA
        9xQ7SqrLjNVXnSsE9MMPRfQA4xuFuqgFCsCedxGyMONNJTevJd12UzAv2KWNVI9/bIlW3H
        o8x6jwziEyUXsBZejJd1/R1L3oRDMFY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MAINTAINERS: Relieve Zubair Lutfullah Kakakhel from his duties
Date:   Sat, 29 Jun 2019 02:21:41 +0200
Message-Id: <20190629002141.22018-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

His e-mail address @imgtec.com is no more, and when I contacted him
on his private email about it, he told me to drop him from MAINTAINERS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ee871404aba..755d5e5941e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7791,11 +7791,6 @@ F:	include/trace/events/ib_umad.h
 F:	samples/bpf/ibumad_kern.c
 F:	samples/bpf/ibumad_user.c
 
-INGENIC JZ4780 DMA Driver
-M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
-S:	Maintained
-F:	drivers/dma/dma-jz4780.c
-
 INGENIC JZ47xx SoCs
 M:	Paul Cercueil <paul@crapouillou.net>
 S:	Maintained
-- 
2.21.0.593.g511ec345e18

