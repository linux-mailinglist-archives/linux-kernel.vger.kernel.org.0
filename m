Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40F2E8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE2XJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:09:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQCGkdMpLup5seR2eOGZrEj83EK7R6BAf5CrYNPT128=; b=ORQRZbh30e09Ci7Cw02tPJuxD9
        9HCxjjdooDE1c73SruFsxM2n9djvXkdRZ3NKbVornEe8sq7BUafWrMZqhNarcezJojpmhTDbCJl3L
        Hb2m7iPvCQ/tjBRQKDkjRVaaENEir0ZZKj/bDHNQYBY7gJEIZRIbUNItmDI587HCHTlO5LyGGREXY
        qfUU/QqHyG6O9CbVCiza5CrnpAIZdgduts9ZocvtmPoSjWpW2RdqqPOb/RZhPNY1q/JIQIOjoJzt7
        9eiMTGOuuCXxl9Bnz1FP34fmbUpQ/qW6v+00jR78spWl/I9+YeMZqnxucpSQfH5aBtK8d3VJWXyUg
        CjetgcsQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lK-Ia; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007Tp-OC; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/10] docs: by default, build docs a lot faster with Sphinx >= 1.7
Date:   Wed, 29 May 2019 20:09:31 -0300
Message-Id: <46c958ec4e460f138c0d087bdff40ec60d060b83.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Sphinx version 1.7, it is possible to use "-jauto" in
order to speedup documentation builds. On older versions,
while -j was already supported, one would need to set the
number of threads manually.

So, if SPHINXOPTS is not provided, add -jauto, in order to
speed up the build. That makes it *a lot* times faster than
without -j.

If one really wants to slow things down, it can just use:

	make SPHINXOPTS=-j1 htmldocs

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 380e24053d6f..794233d05789 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -28,6 +28,8 @@ ifeq ($(HAVE_SPHINX),0)
 
 else # HAVE_SPHINX
 
+SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
+
 # User-friendly check for pdflatex and latexmk
 HAVE_PDFLATEX := $(shell if which $(PDFLATEX) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_LATEXMK := $(shell if which latexmk >/dev/null 2>&1; then echo 1; else echo 0; fi)
-- 
2.21.0

