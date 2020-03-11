Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC5180F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgCKFHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 01:07:02 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:42626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgCKFGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B7691181D3025;
        Wed, 11 Mar 2020 05:06:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2901:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6261:9025:10004:10848:11026:11473:11657:11658:11914:12043:12296:12297:12438:12555:12679:12895:12986:13069:13311:13357:13894:13972:14181:14384:14394:14721:21080:21433:21627:21811:21939:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: jewel27_1e8115a6f7d16
X-Filterd-Recvd-Size: 2301
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:49 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:19 -0700
Message-Id: <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index e0b73a5..a2978ab 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -75,7 +75,7 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 		break;
 	case UART_LCR:
 		valshift = 8;
-		/* fall through */
+		fallthrough;
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
 		break;
@@ -101,7 +101,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 	case UART_SCR:
 		/* No SCR for this hardware.  Use CHAR as a scratch register */
 		valshift = 8;
-		/* fall through */
+		fallthrough;
 	case UART_FCR:
 		offset = UNIPHIER_UART_CHAR_FCR;
 		break;
@@ -109,7 +109,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		valshift = 8;
 		/* Divisor latch access bit does not exist. */
 		value &= ~UART_LCR_DLAB;
-		/* fall through */
+		fallthrough;
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
 		break;
-- 
2.24.0

