Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994D159B83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfF1Md0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:33:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IqWEXjmAHEFCos1bD4o5Gfyjo268jeIGTqrPbZTv3dg=; b=dxhhGwaCM8G3iEpTeQPU2cP54E
        ZgGGsVfxnK8wE9OXMCXc+12tzZH5gLogHYE+LIgGNnOzwjALDWMFJdW4+3wYto0Iy+M4Gq2f9iA6U
        TiaeeBp7y9fi+LwOFNSiXGgscfLu5Z++91H8faXijkh5xA+ma093ramly87MDcryKlTUdPvKZxRNU
        cxD0G3hke5LFIZm21sYACTvo/A49KZ3J1t5qreccMLihOuOi+mEBVZ/ciL+OFllV182dy/wcHGEHU
        ZgpvdkqpeIEc8E/Ims46+xEM2xw3qWXaJ3N3sQZspUiG/KQOYABKRHXDVsRV5ykNL5+GyLkMxIFbo
        Zbw7mNNw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00054w-0H; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005RJ-2Z; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/39] docs: namespace: move it to the admin-guide
Date:   Fri, 28 Jun 2019 09:29:58 -0300
Message-Id: <9ad8354dd29c631cb39b8a19ec9d735e27bacabc.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated at the documentation, this is meant to be for
users to better understand namespaces.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/index.rst                             | 1 +
 .../{ => admin-guide}/namespaces/compatibility-list.rst         | 0
 Documentation/{ => admin-guide}/namespaces/index.rst            | 2 --
 Documentation/{ => admin-guide}/namespaces/resource-control.rst | 0
 4 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{ => admin-guide}/namespaces/compatibility-list.rst (100%)
 rename Documentation/{ => admin-guide}/namespaces/index.rst (91%)
 rename Documentation/{ => admin-guide}/namespaces/resource-control.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index b7e6d18f80ca..42819addebc6 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
    thunderbolt
    LSM/index
    mm/index
+   namespaces/index
    perf-security
    acpi/index
 
diff --git a/Documentation/namespaces/compatibility-list.rst b/Documentation/admin-guide/namespaces/compatibility-list.rst
similarity index 100%
rename from Documentation/namespaces/compatibility-list.rst
rename to Documentation/admin-guide/namespaces/compatibility-list.rst
diff --git a/Documentation/namespaces/index.rst b/Documentation/admin-guide/namespaces/index.rst
similarity index 91%
rename from Documentation/namespaces/index.rst
rename to Documentation/admin-guide/namespaces/index.rst
index bf40625dd11a..713ec4949fa7 100644
--- a/Documentation/namespaces/index.rst
+++ b/Documentation/admin-guide/namespaces/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==========
 Namespaces
 ==========
diff --git a/Documentation/namespaces/resource-control.rst b/Documentation/admin-guide/namespaces/resource-control.rst
similarity index 100%
rename from Documentation/namespaces/resource-control.rst
rename to Documentation/admin-guide/namespaces/resource-control.rst
-- 
2.21.0

