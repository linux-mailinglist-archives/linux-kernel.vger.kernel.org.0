Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F015356B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfFZNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:47:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFZNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CbAWFSZ5Sx47r3jjoWE+iXA54ydy8tFF/w7EEoqE7Kk=; b=gZN1bUpnk4MY2wG2gakx09dJq
        Rn1ZtzTSuRicwhRW0Wr1DP2PaTb3VZo1WRc7pNg9cqHZ2i4NpFqzaGB6MSssAoZuCyiNtuN3YvuTg
        t9PpPY9KrLhNPFLLlYdAToQ43b09S5ac7tnHIP/gERhrhE6ayTjrMgFFK6QdmNhS70UuOWi+Ls0me
        YpeemGPnCXfBrkTNVZa0/tJXxWr3eLD3nn7CrBGMTopMKIu+h6+I9KcTsQsMW0Ml+/80lyH3xAXSX
        h+z6747pXIi1lC36D7lYTImT2evS89phjRAlspb9ADO4z0ne/COa74PcQpzyNYqppBRZJMLTN93ip
        E8B73jISQ==;
Received: from 177.205.71.220.dynamic.adsl.gvt.net.br ([177.205.71.220] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8H7-0002oG-SD; Wed, 26 Jun 2019 13:47:49 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hg8H5-0003fm-SX; Wed, 26 Jun 2019 10:47:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Emese Revfy <re.emese@gmail.com>
Subject: [PATCH] docs: move gcc_plugins.txt to core-api and rename to .rst
Date:   Wed, 26 Jun 2019 10:47:46 -0300
Message-Id: <4937ff4f93282ed57c9859de4300b4d835880ebb.1561556794.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



The gcc_plugins.txt file is already a ReST file. Move it
to the core-api book while renaming it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} | 0
 Documentation/core-api/index.rst                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)

diff --git a/Documentation/gcc-plugins.txt b/Documentation/core-api/gcc-plugins.rst
similarity index 100%
rename from Documentation/gcc-plugins.txt
rename to Documentation/core-api/gcc-plugins.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 2466a4c51031..d1e5b95bf86d 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -35,7 +35,7 @@ Core utilities
    boot-time-mm
    memory-hotplug
    protection-keys
-
+   gcc-plugins
 
 Interfaces for kernel debugging
 ===============================
-- 
2.21.0


