Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6759F102B65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKSSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 13:04:06 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4355 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbfKSSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:04:05 -0500
X-IronPort-AV: E=Sophos;i="5.69,218,1571695200"; 
   d="scan'208";a="412559092"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 19 Nov 2019 19:04:02 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] coccinelle: platform_get_irq: simplify context case
Date:   Tue, 19 Nov 2019 18:28:17 +0100
Message-Id: <1574184500-29870-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify to just report on the first dev_err, whereever it occurs.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/platform_get_irq.cocci |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index 06b6a95..c6ac755 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -23,16 +23,9 @@ platform_get_irq_byname
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
-(
-if (ret != -EPROBE_DEFER)
-{ ...
-*dev_err(...);
-... }
-|
 ...
 *dev_err(...);
-)
-...
+... when any
 }
 
 @depends on patch@

