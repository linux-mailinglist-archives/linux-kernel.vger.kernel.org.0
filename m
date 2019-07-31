Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832BD7CDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfGaUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:08:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zg4RblqhI5I6Ef9SjSFUPAqFeF8fbxOaVM6XwE2Auvo=; b=qZeQX8Ro2s/LxiF7ghNud4CCz/
        GWKEy89if4IZkwFtkzE6TI1xNS9AxhFXs/onoD/cxHSKXOlbS31/9w3gx4qR/7GKLrEBNmxURpT1U
        /FaUk/qPOt3Lp+eOa0L82EZv+HE86+sG2Ye5PHwrYC2zCIRz2pnh7uS6VzSL1NiaxtyUZq96l3tOW
        sIoEWBrYgygLDo4xtZDO7361fbdWm5yJK5lIZ6tMKReCePzXTGQk0A05BLHH4thMe7ZLUZCybjPk/
        BuaCfD5j1SU3hofhfUrS2QJCgp2rFscfvB33+MGRO/qdTtMg/xzwjjtBQRnHzEO54v3BoynzNJezs
        2VHerrLg==;
Received: from [191.33.152.89] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsuu8-0007qD-VO; Wed, 31 Jul 2019 20:08:56 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hsuu6-00079x-AR; Wed, 31 Jul 2019 17:08:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/6] docs: fs: convert porting to ReST
Date:   Wed, 31 Jul 2019 17:08:52 -0300
Message-Id: <a2303fe9fa2103e7d1f8589e1f91a7d65497e8b7.1564603513.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564603513.git.mchehab+samsung@kernel.org>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has its own proper style, except that, after a while,
the coding style gets violated and whitespaces are placed on
different ways.

As Sphinx and ReST are very sentitive to whitespace differences,
I had to opt if each entry after required/mandatory/... fields
should start with zero spaces or with a tab. I opted to start them
all from the zero position, in order to avoid needing to break lines
with more than 80 columns, with would make harder for review.

Most of the other changes at porting.rst were made to use an unified
notation with works nice as a text file while also produce a good html
output after being parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/filesystems/porting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 66aa521e6376..f18506083ced 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -158,7 +158,7 @@ Callers of notify_change() need ->i_mutex now.
 New super_block field ``struct export_operations *s_export_op`` for
 explicit support for exporting, e.g. via NFS.  The structure is fully
 documented at its declaration in include/linux/fs.h, and in
-Documentation/filesystems/nfs/Exporting.
+Documentation/filesystems/nfs/exporting.rst.
 
 Briefly it allows for the definition of decode_fh and encode_fh operations
 to encode and decode filehandles, and allows the filesystem to use
-- 
2.21.0

