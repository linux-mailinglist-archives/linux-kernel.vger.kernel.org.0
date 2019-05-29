Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982D82E8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfE2XJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:09:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QvOd/fJjXFPdnBle2fe0Q+QGkQ9sPITwaJ/QwVHAAQc=; b=WksbaBwu69Iezy6VPCiymd55jZ
        +TvYlekSzZB4iSkKoITMCtttcQtFW4S9oJQ3wP/H2wfzEeV4FuP7SCy7PPpiX1CQ6tFeNa3xwoIoH
        H5G7sBZcy5hdcbjuyXBYUt9Gf0qLtS1pmayqhnaLFhfqK4/ml3T8/UAAkKez5Tqj9UTIi3pQ9RDiL
        NWTBVMewLnG+AOHh9Os1zqV5pibDKKjZ8xmBCAku/gV9j0oPzGZbP5KOtibLwf+0BKd5FvnKgGtxC
        1f3BY/gkhmEPGRKyq8aN7mxjUIE2ANiPztzlwUU+XL3zbsGxSvgpVMlHuTT6LG5dXmCRW/BEpBwDQ
        PnOOuP/Q==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lE-JD; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007TJ-HK; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/10] docs: cdomain.py: get rid of a warning since version 1.8
Date:   Wed, 29 May 2019 20:09:23 -0300
Message-Id: <034b0371907a003c67b3d974ba0c5df5ed89a663.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
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

