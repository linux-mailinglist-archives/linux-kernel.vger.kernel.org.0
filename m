Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1414759B57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfF1McX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:32:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfF1Mam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7J8GFXOXC+IsahgFkckgvyti7445SF8VB9Sumqq9uUc=; b=GbQemoOEwXARLFQleu5EcWNIIE
        fdEAhyNTqyo3grcWlAVt3arziGjsdHks7HiHdSlngDlaEbP1Eqeq9MVo8OUBceYTeL/6zLVg1/dcU
        UfJ5+nMnEOoT6YWgNEgj6MjE9fZfXdITbjy3OEH1MPHQgMuUQQPs3/ZVOQqzColEEJ1thEzTnjvbH
        YY9joIENwEWfY8gFfL0PM9peiI6oRztYlLhWKHHhPIFWiwNICk2+5Pkw8eJn4VGAGbf8bFZvxPkCY
        w97+3RLdZXK8NdGiZp1oQO4cEWjDzyItlyqGG9NLnFMG/i2HUAc1MdvDLtSH3Xi/Ma/B0+pXfLUgl
        +GPfPteQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1W-000552-3x; Fri, 28 Jun 2019 12:30:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Ty-UM; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 38/39] docs: locking: add it to the main index
Date:   Fri, 28 Jun 2019 09:30:31 -0300
Message-Id: <9cb659cc11d881b812a494475616e0f46ade51cb.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The locking directory is part of the Kernel API bookset. Add
it to the index file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst         | 1 +
 Documentation/locking/index.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 075c732501a2..13c3188f6a68 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -96,6 +96,7 @@ needed).
 
    driver-api/index
    core-api/index
+   locking/index
    accounting/index
    block/index
    cdrom/index
diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index ef5da7fe9aac..626a463f7e42 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 =======
 locking
-- 
2.21.0

