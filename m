Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4667FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfGNPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 11:10:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5tM2MS1kf1uhWY8D5GobT8hsim8st9pL5ByAyD55Xv4=; b=NAS0VfA3vMNQZDTysqDbrZA8zE
        G3SEgJbRs/4ZvP3RXBmxgKnWz+5Es8PxOb2Wq/N5X0WmOIwnCSfKTla3avwTW4C2awP4eZZGQ70Gk
        A6WfdGYRkAPbSg3BLctblC+9h656HDs1zkQFmYFn4eKKdQRtAKP/wsUW1asZ9v1TkhTdyqs9q2yci
        P95GBUnbtgG8Js4y+63od+HUIom9jCewiPCyegx0zeKhBZl1imK2qrrt7CAmO4v/HFVaAqRkjj2Cw
        RXbdCafLxaLPQMF4Hyc6gabQjflxXmVJGjb7a+SzAgfhzmUOEsehZOQdOO8wWeF63ABcu3wj0Xxxi
        6wqUSxug==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004fB-EV; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8k-0007T0-V8; Sun, 14 Jul 2019 12:10:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/8] docs: conf.py: only use CJK if the font is available
Date:   Sun, 14 Jul 2019 12:10:06 -0300
Message-Id: <ef89f943429dfdf2399c1d237e55ad56d1f8c60b.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we try to build a book with asian characters with XeLaTeX
and the font is not available, it will produce an error.

So, instead, add a logic at conf.py to detect if the proper
font is installed.

This will avoid an error while building the document, although
the result may not be readable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/conf.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index fa0a42b47e62..a8fe845832bc 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -16,6 +16,8 @@ import sys
 import os
 import sphinx
 
+from subprocess import check_output
+
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
 
@@ -276,13 +278,20 @@ latex_elements = {
         \\setsansfont{DejaVu Sans}
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
+     '''
+}
 
+# At least one book (translations) may have Asian characters
+# with are only displayed if xeCJK is used
+
+cjk_cmd = check_output(['fc-list', '--format="%{family[0]}\n"']).decode('utf-8', 'ignore')
+if cjk_cmd.find("Noto Sans CJK SC") >= 0:
+    print ("enabling CJK for LaTeX builder")
+    latex_elements['preamble']  += '''
 	% This is needed for translations
         \\usepackage{xeCJK}
         \\setCJKmainfont{Noto Sans CJK SC}
-
      '''
-}
 
 # Fix reference escape troubles with Sphinx 1.4.x
 if major == 1 and minor > 3:
-- 
2.21.0

