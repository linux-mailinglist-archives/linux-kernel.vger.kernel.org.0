Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7C827AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfEWKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:43:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QvOd/fJjXFPdnBle2fe0Q+QGkQ9sPITwaJ/QwVHAAQc=; b=WOPe066LjGPPjgHOGdhYNNG1/
        DhfVtOPIlIw34+3TEYQ7jEnqmcPjn9Evi5RiSOj2s5BwgVX0fW3PVoYjtRTEuFY+oNcOYah+g6LmV
        p/BChW8y9p+AVytHNDj59D6zZ5vNMCfo59T690RSAX94yzd5/hTC4EUMRkHXnjDdmH6JicXqIxYiv
        jMdAVDiyly7/t3LVMSPsyoioIAYuDtEAxqMu2D4h+lj5/aazGZnb10IWtrPh0oTg0dXYzfB6XZl1Z
        tf49cBau0kwGcuJi/5oGTSbjkGIBDtILGuZDdzOxS0L9YXfG+bBs3C3PWrWaxvmglhQ1w4IZymZJZ
        gjtcbQkFQ==;
Received: from [179.182.168.126] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTlCO-0007Os-OE; Thu, 23 May 2019 10:43:48 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hTlCL-0006Bw-7s; Thu, 23 May 2019 07:43:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: cdomain.py: get rid of a warning since version 1.8
Date:   Thu, 23 May 2019 07:43:43 -0300
Message-Id: <b38a9fdfdcda49b2c6118072afac564e96406800.1558608217.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a new warning about a deprecation function. Add a
logic at cdomain.py to avoid that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/cdomain.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index cf13ff3a656c..cbac8e608dc4 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -48,7 +48,10 @@ major, minor, patch = sphinx.version_info[:3]
 
 def setup(app):
 
-    app.override_domain(CDomain)
+    if (major == 1 and minor < 8):
+        app.override_domain(CDomain)
+    else:
+        app.add_domain(CDomain, override=True)
 
     return dict(
         version = __version__,
-- 
2.21.0

