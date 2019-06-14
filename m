Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8514F451A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfFNCEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 22:04:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfFNCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Adj83HLbKRJj7XLx7jpL+lI7fvcVNLKp9k5DjItzJhU=; b=Q3iqr37tz9MPM8xOPTJ7pljBhd
        /VfeHOfBP7FkSWnbfDNcPLT5BfYY+q3J1os6noOwsLzLsl9QaR3P8WaaHoDJ06qnOv3IFSm3B2YgI
        wa7gSxZPZTAgm/e0HaEBrInh5qSfd5ca0nV9FG0Z6QMl1hYp1QnJny0zJSuM2b7srZaqVNNoIXGAz
        HCyCnls4mk361YHTjJoLJhDyOHPTn3Th/urmtfITyS++NV58LysO0DgGrQk7yvT3nqY8bL0oC8u+r
        AxapBrhMU9jz4n9sgsWNk++QgGD8zB6Ht/n8UfQR3jPyopId4PTQFuVsOXdQm4/fbbgzmUwjpMZ2q
        Wl1SJ1Vg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZv-0000EH-0U; Fri, 14 Jun 2019 02:04:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZo-0002oP-1r; Thu, 13 Jun 2019 23:04:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Date:   Thu, 13 Jun 2019 23:04:20 -0300
Message-Id: <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser breaks with UTF-8 characters with Sphinx 1.4.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 7fa7806532dc..460cee48a245 100644
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
@@ -124,12 +126,12 @@ class KernelCmd(Directive):
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
-- 
2.21.0

