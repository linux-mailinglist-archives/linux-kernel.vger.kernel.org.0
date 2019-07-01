Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5ED4D50C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfFTRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:25:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WNiRsq7voQTs7B1oPyVixDdCGhlnrWKg3Vv2Nss1FD8=; b=c/8GwCoHkp5Mc0imGwx4y5gPSJ
        tAKMXG4qkiBq26AcjcaKmyrXQTSiBUwKINkQvfATYWPM2eKvKjCg35cKnkidVm4hJwLNMfByqPFYg
        Kxuta07COpQTpMevnq0feSyfKqDrAZr6BjU7MI+tadIhsZ2d1OY/2RA1I24/BJhBOkaq23RtAJQI7
        bn+4xpSZdGNIkYnX7OhFBtgOZY9r/EwAdOmSJ3sNcxJi2fNagf2qzvfPqF41mS89vAggYrauYgZPY
        h829M6ZAon8EGuEa02wFVjnBnrV27pJ5SSZGC+vTLvr/qBQrwmswZQCLhhs4dVgFaodtA/R9InxyG
        nVXIKzjA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rw-9h; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000DX-Sj; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 14/22] docs: sphinx/kernel_abi.py: fix UTF-8 support
Date:   Thu, 20 Jun 2019 14:23:06 -0300
Message-Id: <8797b79370b399ffa6c614be966a7b80289153be.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser breaks with UTF-8 characters with Sphinx 1.4.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 32ce90775d96..0f3e51e67e8d 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -1,4 +1,5 @@
-# -*- coding: utf-8; mode: python -*-
+# coding=utf-8
+#
 u"""
     kernel-abi
     ~~~~~~~~~~
@@ -28,6 +29,7 @@ u"""
 
 """
 
+import codecs
 import sys
 import os
 from os import path
@@ -43,14 +45,6 @@ from docutils.utils.error_reporting import ErrorString
 
 __version__  = '1.0'
 
-# We can't assume that six is installed
-PY3 = sys.version_info[0] == 3
-PY2 = sys.version_info[0] == 2
-if PY3:
-    # pylint: disable=C0103, W0622
-    unicode     = str
-    basestring  = str
-
 def setup(app):
 
     app.add_directive("kernel-abi", KernelCmd)
@@ -115,12 +109,12 @@ class KernelCmd(Directive):
                 cmd
                 , stdout = subprocess.PIPE
                 , stderr = subprocess.PIPE
-                , universal_newlines = True
                 , **kwargs
             )
             out, err = proc.communicate()
-            if err:
-                self.warn(err)
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
             if proc.returncode != 0:
                 raise self.severe(
                     u"command '%s' failed with return code %d"
@@ -129,7 +123,7 @@ class KernelCmd(Directive):
         except OSError as exc:
             raise self.severe(u"problems with '%s' directive: %s."
                               % (self.name, ErrorString(exc)))
-        return unicode(out)
+        return out
 
     def nestedParse(self, lines, fname):
         content = ViewList()
-- 
2.21.0

