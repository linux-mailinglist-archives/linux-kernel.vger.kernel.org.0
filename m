Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6875E4D4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfFTRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:23:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kU4lZoZk1BRhrx8HkLHCBdk7MNLvQ8R2y7TKkaZGQ4g=; b=ujY5TkevS1etk0JCSCpeRyDZKP
        N3DknK1I4iP59orW1Cw2sgpGF2IovGn+GOHkjQSpGbsCRgWpU8WHmWtdIn9YIJC42JnXfVEQnbnd2
        Sk+2WIrn3Bz+RotazySfMNUuD8KKMpBtUfov7g5a0XKoDkhq+wo49Qwkwgxzk65L1UjkLXosfm/IQ
        HfITDegy0YI1TkkOfHlcTtLR1oaMxnrdbIRwwA+DrkkH0iO/OYxS69R7lbIqjxZKtVwEX+eX0tIWZ
        K14bBWHJmBIcewjmFiGLqi3j8Gtw5Tf7RWtUp44iAyvKO0Hjt68oE5t6FGBDMtmYnT6O/0DEjPh3B
        MSSM1MUQ==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mL-0008Rn-T0; Thu, 20 Jun 2019 17:23:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Dl-V9; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 17/22] docs: kernel_abi.py: Update copyrights
Date:   Thu, 20 Jun 2019 14:23:09 -0300
Message-Id: <6315c1089fc88a123a786e633b574aa0887ef20e.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Markus doesn't want to maintain ths file, update it to
put me as its maintainer.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 2d5d582207f7..ef91b1e1ff4b 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -7,7 +7,8 @@ u"""
     Implementation of the ``kernel-abi`` reST-directive.
 
     :copyright:  Copyright (C) 2016  Markus Heiser
-    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
+    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
+    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
-- 
2.21.0

