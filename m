Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A544B76C12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfGZOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:52:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33834 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfGZOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5hwDR4tPEL7vTgTgaQSKrhug2Vgpq2uEOobdVVVTPIo=; b=JZv16xyW1hc6t5gsX/fUqj2Jz
        LyKwgUpPzesrfNl5p93wcBs+vkR5ursAN14i3s+3p02C4rWGOy4w3DZGDFcBovWcWdgQrHZbFskXp
        GrbrlNzGbb+dLf0FyFxX4Dr9wv5CHC60FAvKy9i5e/2LbVeVbckrN3YvuVP+pyR5Dri+BGUzqTkGl
        J1C5IGiC9tpJXC0pVXyKqQRViIu+3XpdjCmbHft1H8MS4knlOuD8rGnfMypQeqg/B6irXqKi2FyN7
        61aolci5+9V85XKDKw9OD2DaPhGrSfer8NOPmSMdYkfqr9ezFjXan6sibUUXcLLgqNwjpT969G0ob
        J9wrZqeIg==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr1aL-0008Og-5t; Fri, 26 Jul 2019 14:52:41 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr1aI-0004OR-HA; Fri, 26 Jul 2019 11:52:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] MAINTAINERS: add entries for some documentation scripts
Date:   Fri, 26 Jul 2019 11:52:34 -0300
Message-Id: <b21677443a602c5dc263537fa48f0e78da75187a.1564152752.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some documentation scripts I wrote with doesn't
have any maintainer at maintainer's file.

Add them to the DOCUMENTATION entry, in order to have
Jon and linux-doc ML c/c on those patches, plus a new
entry to ensure that I'll be c/c when people send patches
to those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4de2f288d1ec..a09355672212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4947,7 +4947,9 @@ M:	Jonathan Corbet <corbet@lwn.net>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/
+F:	scripts/documentation-file-ref-check
 F:	scripts/kernel-doc
+F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/firmware-guide/acpi/
 X:	Documentation/devicetree/
@@ -4963,6 +4965,14 @@ L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/translations/it_IT
 
+DOCUMENTATION SCRIPTS
+M:	Mauro Carvalho Chehab <mchehab@kernel.org>
+L:	linux-doc@vger.kernel.org
+S:	Maintained
+F:	scripts/documentation-file-ref-check
+F:	scripts/sphinx-pre-install
+F:	Documentation/sphinx/parse-headers.pl
+
 DONGWOON DW9714 LENS VOICE COIL DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.21.0

