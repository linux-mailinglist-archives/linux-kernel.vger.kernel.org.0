Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47042B2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE0LHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 07:07:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uQCGkdMpLup5seR2eOGZrEj83EK7R6BAf5CrYNPT128=; b=kkDbAtbig016mmWPk8Q0ECOcNj
        6i2x6TRRxm4pHg7q3zywdNvrVs9WWeNsxq3w9Gd7v2tarbn1H3xpSsDlPWX4gLPezG0bpho94/h+v
        62+mv5ya/1QC+iZREHYViN0Dlla+oOJoWs5/EbGNRiG+nBYqEKi8yHgq3TSh9VFXiOuJM5qzE2Ngx
        mTu3xOeYoV8vPuLOibnNBdUf52Og/A36QXmcSz4gTKNEr/una58qXtqftt7QUkCtXXyVvKBnsAB59
        rJMf9IlCyYwUrmOv9mqhkbESd+Pr/FAL+pRLbR62WC5iOd/HXgjQqJdz+ysoCimzGWsxfZPSvD9XZ
        3W7lZGWw==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061v-O8; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002cq-Qa; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/5] docs: by default, build docs a lot faster with Sphinx >= 1.7
Date:   Mon, 27 May 2019 08:07:40 -0300
Message-Id: <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
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

