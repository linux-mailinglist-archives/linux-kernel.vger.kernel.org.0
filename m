Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547A442EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfFLSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:38:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kIG3TqTXNYXrXjWMuxoIyxE0UnlHCYqdcFqGb4s7JWQ=; b=QIYRui6MDQkkIfx69CJjpI+lM5
        DTCwO8H54IWMynuCLh/wlg9g9qsNkv78sB3v5rbp86Hq2sIk1/Q49ZUu+0qVKa4D6gDjcFogcQGWS
        YUamn6ZKAy949NRYhl0FCjpygJClcNmrOTzL6c3iKY/3+Px1N75c/0/o+1dP4a60kpFY+rmmafSyC
        ukKFTqE2HpKSPU24hZahgHsKCRwulkOZyJxMMCreEOYMNptnHuzmbMmNo5Nq32q0LVXBph5GLtETX
        jnYACkxUeNRnXBBkHbYRr6U4+SuDuNRHaKvx8bUtXCqaAuvFaG8zE73enuufNnREb5y5cL8UlfXX6
        EV/Z1RlQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YM-Np; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88p-0002AZ-TS; Wed, 12 Jun 2019 15:38:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 05/31] docs: cma/debugfs.txt: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 15:38:08 -0300
Message-Id: <6604fe1bbc206c11e6b2d8e6b379bbb0c163c556.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs interface for CMA should be there together with other
mm-related documents.

Convert this small file to ReST and move it to its rightful place.

The conversion is actually quite simple: just add a title for the
document. In order to make it to look better for the audience,
also mark the "echo" command as a literal block.

While this is not part of any book, mark it as :orphan:,
in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/cma/{debugfs.txt => debugfs.rst} | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 rename Documentation/cma/{debugfs.txt => debugfs.rst} (91%)

diff --git a/Documentation/cma/debugfs.txt b/Documentation/cma/debugfs.rst
similarity index 91%
rename from Documentation/cma/debugfs.txt
rename to Documentation/cma/debugfs.rst
index 6cef20a8cedc..518fe401b5ee 100644
--- a/Documentation/cma/debugfs.txt
+++ b/Documentation/cma/debugfs.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+=====================
+CMA Debugfs Interface
+=====================
+
 The CMA debugfs interface is useful to retrieve basic information out of the
 different CMA areas and to test allocation/release in each of the areas.
 
@@ -12,7 +18,7 @@ The structure of the files created under that directory is as follows:
  - [RO] count: Amount of memory in the CMA area.
  - [RO] order_per_bit: Order of pages represented by one bit.
  - [RO] bitmap: The bitmap of page states in the zone.
- - [WO] alloc: Allocate N pages from that CMA area. For example:
+ - [WO] alloc: Allocate N pages from that CMA area. For example::
 
 	echo 5 > <debugfs>/cma/cma-2/alloc
 
-- 
2.21.0

