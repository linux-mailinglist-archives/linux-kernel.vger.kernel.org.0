Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CBB42EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfFLSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:38:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFLSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8Y1nlnSVVHDrFk8myKIM30kznMDor9jOwj/L8T5CzXg=; b=ksgkJeqEDssKkqMqy3+CJnoTHR
        ZgYvdKq6oxobKGac6dNnGoIXsmSp+NVeinxxxWZJMGHj/HKfNE3tEO7V3iaheU9LCuXIaVXsPKypb
        j730Sf4i6rR2h4X2FDHlkC25Dbxnq2p6IsOkXeBkKwfiwuKblkxzJsIpmxtgsgnnjtdSMd7CO0U7l
        XP0+aOOW/Q48ypbOie6WDBuq+K7vbS3MiEirhBmN+qc5/LHr63O0kxcJTH9yjigTZ5VHzY0Ykxzem
        BDJ/UQie7Q6/VMSITSe02YtoogAKvdqchuODHNhl8RobOtXWwIURW059eJASbftOJRPaZ+cTa3/hN
        DnEI0ekQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YI-Jb; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002BH-6u; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 16/31] docs: rbtree.txt: fix Sphinx build warnings
Date:   Wed, 12 Jun 2019 15:38:19 -0300
Message-Id: <c4774c673745b441f37a29d6734a49f0772cf2d5.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ths file is already at ReST format. Yet, some recent changes
made it to produce a few warnings when building it with
Sphinx.

Those are trivially fixed by marking some literal blocks.

Fix them before adding it to the docs building system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/rbtree.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index c42a21b99046..523d54b60087 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -204,21 +204,21 @@ potentially expensive tree iterations. This is done at negligible runtime
 overhead for maintanence; albeit larger memory footprint.
 
 Similar to the rb_root structure, cached rbtrees are initialized to be
-empty via:
+empty via::
 
   struct rb_root_cached mytree = RB_ROOT_CACHED;
 
 Cached rbtree is simply a regular rb_root with an extra pointer to cache the
 leftmost node. This allows rb_root_cached to exist wherever rb_root does,
 which permits augmented trees to be supported as well as only a few extra
-interfaces:
+interfaces::
 
   struct rb_node *rb_first_cached(struct rb_root_cached *tree);
   void rb_insert_color_cached(struct rb_node *, struct rb_root_cached *, bool);
   void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
 
 Both insert and erase calls have their respective counterpart of augmented
-trees:
+trees::
 
   void rb_insert_augmented_cached(struct rb_node *node, struct rb_root_cached *,
 				  bool, struct rb_augment_callbacks *);
-- 
2.21.0

