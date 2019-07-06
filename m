Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A886122F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGFQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 12:28:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGFQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 12:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ghL77CchQXZL/1OYqkjXukfJ+VErUY5D2o/FDaCKbfY=; b=UjLH+DhWCO9f+D1rCXCq6GLrd
        jWUsUOA68M8jrRdMuVNaqbcH2PnpNFmOYC53qO3XFxJK5C0h7knV3Cm2ZK9mwuIE4bidJZ4zvvttv
        KShBF7wfmr/o+5CV/knJki0YDBX9ahYnld3Ze/HUGjDEbjsU/uKWnk4KiIM0VjaYA+h+GvITywWCk
        vzzb+wM0oHO9WaK6NhKsYYPLOEZtCHvSJpGZrNZbZ5Xf7WeKV8HS4PrEQpQHhD3kysLhPjHN65Se6
        HsQSQMxgTHiqva+mtckU6vKqEiE2NhyQ4H5DFxylUSI6d2Z1Ys3L4cebegC16l1w33U3yZ9N0/LRQ
        TTKRdHRSg==;
Received: from [179.95.10.178] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjnYM-00077F-P3; Sat, 06 Jul 2019 16:28:46 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hjnYJ-0005Ue-J0; Sat, 06 Jul 2019 13:28:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: automarkup.py: ignore exceptions when seeking for xrefs
Date:   Sat,  6 Jul 2019 13:28:42 -0300
Message-Id: <d9b1c85769ba659dba6c7c8b459e385be28ca478.1562430514.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the automarkup extension with:
	make pdfdocs

without passing an specific book, the code will raise an exception:

	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 86, in auto_markup
	    node.parent.replace(node, markup_funcs(name, app, node))
	  File "/devel/v4l/docs/Documentation/sphinx/automarkup.py", line 59, in markup_funcs
	    'function', target, pxref, lit_text)
	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/domains/c.py", line 308, in resolve_xref
	    contnode, target)
	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/util/nodes.py", line 450, in make_refnode
	    '#' + targetid)
	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 159, in get_relative_uri
	    return self.get_target_uri(to, typ)
	  File "/devel/v4l/docs/sphinx_2.0/lib/python3.7/site-packages/sphinx/builders/latex/__init__.py", line 152, in get_target_uri
	    raise NoUri
	sphinx.environment.NoUri

This happens because not all references will belong to a single
PDF/LaTeX document.

Better to just ignore those than breaking Sphinx build.

Fixes: d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/automarkup.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index b300cf129869..dba14374f269 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -55,8 +55,13 @@ def markup_funcs(docname, app, node):
                                           reftype = 'function',
                                           reftarget = target, modname = None,
                                           classname = None)
-            xref = cdom.resolve_xref(app.env, docname, app.builder,
-                                     'function', target, pxref, lit_text)
+
+            # When building pdf documents, this may raise a NoUri exception
+            try:
+                xref = cdom.resolve_xref(app.env, docname, app.builder,
+                                         'function', target, pxref, lit_text)
+            except:
+                xref = None
         #
         # Toss the xref into the list if we got it; otherwise just put
         # the function text.
-- 
2.21.0

