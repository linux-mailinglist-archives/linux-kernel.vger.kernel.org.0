Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88BFC38B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 11:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 05:04:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:04:26 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVBzB-0006wD-Om; Thu, 14 Nov 2019 11:04:21 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVBzA-0006SE-L8; Thu, 14 Nov 2019 11:04:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] checkpatch: don't warn about new vsprintf pointer extension '%pe'
Date:   Thu, 14 Nov 2019 11:04:16 +0100
Message-Id: <20191114100416.23928-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extension was introduced in commit 57f5677e535b ("printf: add
support for printing symbolic error names").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6fcc66afb088..31cd9b767c1e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6022,7 +6022,7 @@ sub process {
 				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
 					$specifier = $1;
 					$extension = $2;
-					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
+					if ($extension !~ /[SsBKRraeEhMmIiUDdgVCbGNOxt]/) {
 						$bad_specifier = $specifier;
 						last;
 					}
-- 
2.24.0

