Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B315D5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGBR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 13:57:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGBR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+ahNi2HxAhGkWgnbOtQn1Bz7SyXdYLczH+wsKwNvLNw=; b=Hz9BIU2AICwcJllrZaeL/YFGd
        LMeLTLdbianYtjq/4Vn43w2iMMliWpV5remUoYvE5ndDrkVvYI3ShZMtHTzbySy4Xc5lcn4Gea3+/
        uQydZlZAJBE8cu0eKQ6a04TNBJY+GLk5uytNLE7BE+6V4E/ER62JdXeVt7eJ381Sxphp0y8zUAZQx
        pmNi393HmWOH+Ldx2M3HT2LXxMTn+B18gMLticPzXtuxLvWh/fsgt9HkFeA5ti+4ridfcTSysfEXX
        jpViWgbv6C0xhPTnp1uzrNGEoLQQVVZqwrJ0cz8ZP2OFWrS/xHN3nZYkDunjNvF/brjBOzVOU3iXB
        9/lBK8k+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hiN21-0006vi-Or; Tue, 02 Jul 2019 17:57:29 +0000
Date:   Tue, 2 Jul 2019 10:57:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Message-ID: <20190702175729.GF1729@bombadil.infradead.org>
References: <20190111134100.24095-1-christian@brauner.io>
 <20190114172401.018afb9c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114172401.018afb9c@lwn.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 05:24:01PM -0700, Jonathan Corbet wrote:
> On Fri, 11 Jan 2019 14:40:59 +0100
> Christian Brauner <christian@brauner.io> wrote:
> > This documents the Android binderfs filesystem used to dynamically add and
> > remove binder devices that are private to each instance.
> 
> You didn't add it to index.rst, so it won't actually become part of the
> docs build.

I think you added it in the wrong place.

From 8167b80c950834da09a9204b6236f238197c197b Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 2 Jul 2019 13:54:38 -0400
Subject: [PATCH] docs: Move binderfs to admin-guide

The documentation is more appropriate for the administrator than for
the internal kernel API section it is currently in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../{filesystems => admin-guide}/binderfs.rst          |  0
 Documentation/admin-guide/index.rst                    |  1 +
 Documentation/filesystems/index.rst                    | 10 ----------
 3 files changed, 1 insertion(+), 10 deletions(-)
 rename Documentation/{filesystems => admin-guide}/binderfs.rst (100%)

diff --git a/Documentation/filesystems/binderfs.rst b/Documentation/admin-guide/binderfs.rst
similarity index 100%
rename from Documentation/filesystems/binderfs.rst
rename to Documentation/admin-guide/binderfs.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 8001917ee012..24fbe0568eff 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -70,6 +70,7 @@ configure specific aspects of kernel behavior to your liking.
    ras
    bcache
    ext4
+   binderfs
    pm/index
    thunderbolt
    LSM/index
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1131c34d77f6..970c0a3ec377 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -31,13 +31,3 @@ filesystem implementations.
 
    journalling
    fscrypt
-
-Filesystem-specific documentation
-=================================
-
-Documentation for individual filesystem types can be found here.
-
-.. toctree::
-   :maxdepth: 2
-
-   binderfs.rst
-- 
2.20.1

