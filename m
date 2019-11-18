Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45909100BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKRSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 13:45:46 -0500
Received: from mxa1.seznam.cz ([77.75.78.90]:63694 "EHLO mxa1.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfKRSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:45:46 -0500
X-Greylist: delayed 706 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Nov 2019 13:45:45 EST
Received: from email.seznam.cz
        by email-smtpc10b.ko.seznam.cz (email-smtpc10b.ko.seznam.cz [10.53.14.45])
        id 7e43507a554ae8787a1a4ccd;
        Mon, 18 Nov 2019 19:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1574102740; bh=TzTZvRPTC8arfHf9xInFoxSaBfyeJQCa4kNpPyUwaUc=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
        b=IzopMcl2Cy2LzattbBHt/V7GuqMoJpI5uOeXr88rM4jgpF4wzIjxZ/8TWcjKAhtkO
         m6dgTATKxwUMkd3zNeNn+UIBp7Num4LuvyveUol4J8SbgJbdaaa2FznXSvKlKNw4Qs
         ridKx+q/x4liWqOYQsgaOpblAz6GNzPZKdhZNIAI=
Received: from linux-h043.suse.cz (cst-prg-22-65.cust.vodafone.cz [46.135.22.65])
        by email-relay13.ko.seznam.cz (Seznam SMTPD 1.3.108) with ESMTP;
        Mon, 18 Nov 2019 19:33:35 +0100 (CET)  
From:   Giovanni Gherdovich <bobdc9664@seznam.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <bobdc9664@seznam.cz>
Subject: [PATCH] staging: octeon: indent with tabs instead of spaces
Date:   Mon, 18 Nov 2019 19:38:52 +0100
Message-Id: <20191118183852.3699-1-bobdc9664@seznam.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a coding style error from the Octeon driver's tree and keep
checkpatch.pl a little quieter.

Being a white-spaces patch the chances of breakage are minimal; we don't
have the hardware to run this driver so we built it with COMPILE_TEST
enabled on an x86 machine.

Signed-off-by: Giovanni Gherdovich <bobdc9664@seznam.cz>
---
 drivers/staging/octeon/octeon-stubs.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index ed9d44ff148b..79213c045504 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1140,22 +1140,22 @@ union cvmx_npi_rsl_int_blocks {
 union cvmx_pko_command_word0 {
 	uint64_t u64;
 	struct {
-	        uint64_t total_bytes:16;
-	        uint64_t segs:6;
-	        uint64_t dontfree:1;
-	        uint64_t ignore_i:1;
-	        uint64_t ipoffp1:7;
-	        uint64_t gather:1;
-	        uint64_t rsp:1;
-	        uint64_t wqp:1;
-	        uint64_t n2:1;
-	        uint64_t le:1;
-	        uint64_t reg0:11;
-	        uint64_t subone0:1;
-	        uint64_t reg1:11;
-	        uint64_t subone1:1;
-	        uint64_t size0:2;
-	        uint64_t size1:2;
+		uint64_t total_bytes:16;
+		uint64_t segs:6;
+		uint64_t dontfree:1;
+		uint64_t ignore_i:1;
+		uint64_t ipoffp1:7;
+		uint64_t gather:1;
+		uint64_t rsp:1;
+		uint64_t wqp:1;
+		uint64_t n2:1;
+		uint64_t le:1;
+		uint64_t reg0:11;
+		uint64_t subone0:1;
+		uint64_t reg1:11;
+		uint64_t subone1:1;
+		uint64_t size0:2;
+		uint64_t size1:2;
 	} s;
 };
 
-- 
2.16.4

