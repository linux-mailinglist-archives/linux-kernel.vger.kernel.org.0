Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8115667FA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfGNPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 11:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2yqbL/GCB4qt/1ZOmXmAZs70DddLHNZ+/ZNEpgEx/U=; b=FsVGN6Oby94ZVdAmwEOW5NJHmX
        wSGT9S/Ngc7Cu26u0qYTBp1ItI9feJztRlK1e3TZV6gcx0XryoQzJXiHqWwuYyoIyIZuGDXoRrtu4
        Er6XuU1NZrP3WO+Q3PX1stuAdPN6MmeIT/lMBGSeKJ+94kaluEdm0bFhOzLTD2BlA07qWxUNNREwP
        YcU4k1w3JvdoqKeAahJCnGSdzg6yd8P4+7275BDLPzu3r5ncDnhAgDbLMiL2tPq1ohnnBKhY5TzYT
        rKz+zcJQ+Dk94CznKtQZZ8gzJjy+5K+6aoVmUUNMWcGFe5SvNqO/g9XMLdcuy/E28wEcodICO5p3a
        j+bIWJPg==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f4-ED; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007TC-1A; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] scripts/sphinx-pre-install: fix latexmk dependencies
Date:   Sun, 14 Jul 2019 12:10:09 -0300
Message-Id: <8cdc11a350ea524574ef472d082b6339410c27ea.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the package with carries latexmk is different
on two distros:

- On OpenSUSE, latexmk is packaged as "texlive-latexmk-bin"
- On Mageia, latexmk is packaged at "texlive-collection-basic"

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 33efadd6c0b6..8dc13fe95ffe 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -454,6 +454,8 @@ sub give_opensuse_hints()
 		"texlive-zapfding",
 	);
 
+	$map{"latexmk"} = "texlive-latexmk-bin";
+
 	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
 	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
@@ -479,6 +481,8 @@ sub give_mageia_hints()
 		"texlive-fontsextra",
 	);
 
+	$map{"latexmk"} = "texlive-collection-basic";
+
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
-- 
2.21.0

