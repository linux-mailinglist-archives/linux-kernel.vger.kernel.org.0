Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62372102B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKSSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 13:04:09 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4369 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbfKSSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:04:07 -0500
X-IronPort-AV: E=Sophos;i="5.69,218,1571695200"; 
   d="scan'208";a="412559099"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 19 Nov 2019 19:04:02 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] coccinelle: platform_get_irq: drop unneeded metavariable
Date:   Tue, 19 Nov 2019 18:28:20 +0100
Message-Id: <1574184500-29870-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1574184500-29870-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

Having E as a metavariable adds the requirement to verify its type.
This seems like an unnecessary constraint, so drop it.
There is currently no impact on the set of results.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/platform_get_irq.cocci |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
index e5d04fb..17e5895 100644
--- a/scripts/coccinelle/api/platform_get_irq.cocci
+++ b/scripts/coccinelle/api/platform_get_irq.cocci
@@ -11,7 +11,6 @@ virtual report
 
 @depends on context@
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -19,7 +18,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
@@ -30,7 +29,6 @@ if ( \( ret < 0 \| ret <= 0 \) )
 
 @depends on patch@
 expression ret;
-struct platform_device *E;
 statement S;
 @@
 
@@ -39,7 +37,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 -{
@@ -49,7 +47,6 @@ S
 
 @depends on patch@
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -57,7 +54,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
@@ -76,7 +73,6 @@ if ( \( ret < 0 \| ret <= 0 \) )
 @r depends on org || report@
 position p1;
 expression ret;
-struct platform_device *E;
 @@
 
 ret =
@@ -84,7 +80,7 @@ ret =
 platform_get_irq
 |
 platform_get_irq_byname
-)(E, ...);
+)(...);
 
 if ( \( ret < 0 \| ret <= 0 \) )
 {
