Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D014E808
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfFUMcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 08:32:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfFUMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ytrZB/xH6uvs1QD5R0Wo2WZCYudeyoYfTl6ItjHBAwk=; b=NX3rBV1cqMdQPmVcUe6zSbkA0Z
        qxxha2BaaXdu347+Ryoa8GgyKCKsxC/LxJQl0OShSuxVAA/pPnOxUP0a7QdsPxCL6ZKpZ7vhBAXOX
        eSchOSQGAFRCTkwCVD9pzT9fErNxn4IG4cMlKyI9yNdPiNbgyG/eWk6Xs3ySkGtuqwjgzetCM6WVZ
        Q0pdUHw5bvQJoZyil7mr+dqNUWF/1RVqf7WFGJOPyAmruzNlGykpFv+10EQgSYOY3SUdtcXpD+BSk
        3dutI4/2KVpWsRc4JepSzcULY4hrJiXqvW/NqMjF9QJdat/ZkcoNr9TBXAQ4VMW7vEqkJ2AYb4pf0
        RidnWYKw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIiA-0003xM-Ek; Fri, 21 Jun 2019 12:32:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heIi7-0001FB-U5; Fri, 21 Jun 2019 09:32:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 5/6] docs: ABI: make it parse ABI/stable as ReST-compatible files
Date:   Fri, 21 Jun 2019 09:32:05 -0300
Message-Id: <35c8520fa03f90d8a401faefae35417ac3fa69ec.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561118631.git.mchehab+samsung@kernel.org>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the stable ABI files are compatible with ReST,
parse them without converting complex descriptions as literal
blocks nor escaping special characters.

Please notice that escaping special characters will probably
be needed at descriptions, at least for the asterisk character.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/abi-stable.rst | 1 +
 Documentation/sphinx/kernel_abi.py       | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/admin-guide/abi-stable.rst
index 7495d7a35048..70490736e0d3 100644
--- a/Documentation/admin-guide/abi-stable.rst
+++ b/Documentation/admin-guide/abi-stable.rst
@@ -11,3 +11,4 @@ Most interfaces (like syscalls) are expected to never change and always
 be available.
 
 .. kernel-abi:: $srctree/Documentation/ABI/stable
+   :rst:
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 5d43cac73d0a..88dddb8f4152 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -70,12 +70,13 @@ class KernelCmd(Directive):
     u"""KernelABI (``kernel-abi``) directive"""
 
     required_arguments = 1
-    optional_arguments = 0
+    optional_arguments = 2
     has_content = False
     final_argument_whitespace = True
 
     option_spec = {
-        "debug"     : directives.flag
+        "debug"     : directives.flag,
+        "rst"       : directives.unchanged
     }
 
     def warn(self, message, **replace):
@@ -93,8 +94,12 @@ class KernelCmd(Directive):
         env = doc.settings.env
         cwd = path.dirname(doc.current_source)
         cmd = "get_abi.pl rest --dir "
+
         cmd += self.arguments[0]
 
+        if 'rst' in self.options:
+            cmd += " --rst-source"
+
         srctree = path.abspath(os.environ["srctree"])
 
         fname = cmd
-- 
2.21.0

