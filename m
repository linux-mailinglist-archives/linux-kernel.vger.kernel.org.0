Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFB102E64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKSVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 16:44:11 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37891 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbfKSVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:44:08 -0500
X-IronPort-AV: E=Sophos;i="5.69,219,1571695200"; 
   d="scan'208";a="412575415"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 19 Nov 2019 22:44:04 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4 v2] coccinelle: platform_get_irq: allow multiple dev_errs
Date:   Tue, 19 Nov 2019 22:08:24 +0100
Message-Id: <1574197705-31132-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574197705-31132-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1574197705-31132-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow multiple calls to dev_err in the if branch under the
call to the platform_get_irq function.  Remove only the
first one.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: no change

 scripts/coccinelle/api/platform_get_irq.cocci |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index 7ac32ee..e5d04fb 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -70,7 +70,7 @@ if ( \( ret < 0 \| ret <= 0 \) )
 ...
 -dev_err(...);
 )
-...
+... when any
 }
 
 @r depends on org || report@
