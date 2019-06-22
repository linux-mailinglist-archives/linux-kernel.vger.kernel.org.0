Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382224F771
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFVRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 13:32:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfFVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A82d4usvLaJ17giiHdX9udnYC+qQNWV0youy1hYZKFY=; b=tSsCLrHMLJ86tiEuUGTX+cmGus
        D2Ru7LN7sFYwbBWRVSTF4RnJBn0bldyapfQkfqtUk+fqU9qFRHn2FOxfXG9/Bu5aI+zgLxjy9qMX5
        69R3q6G7EXQtIHfGJAyJwmvsgmkcFB8upRQncYM0MpZzH6dm4L16OZxa+2bJIxGumqHKSqgP2+IcR
        VeIZvhiVtPlyAbL0ereCnkCvfQK6XXR3G0VpX/87Ch6s4+zrPPCu0L8S2gHH3kg6l0al6ltfRw8R/
        Qph7JlNtZg/u0q2nts1gHrxZtrhZ8U64TCWISg7sp/QYzhpdipSVpF4TmY28dKCFN3elm3VTeHrZW
        JY6hi05Q==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejrs-00076k-81; Sat, 22 Jun 2019 17:32:00 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejrq-0001HX-Ag; Sat, 22 Jun 2019 14:31:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC v2 6/8] docs: ABI: don't escape ReST-incompatible chars from obsolete and removed
Date:   Sat, 22 Jun 2019 14:31:54 -0300
Message-Id: <3ec8c1265a850ca71d0f5e82c88a3a7684fbb590.1561224093.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561224093.git.mchehab+samsung@kernel.org>
References: <cover.1561224093.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With just a single fix, the contents there can be parsed properly
without the need to escape any ReST incompatible stuff.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/obsolete/sysfs-gpio      | 2 ++
 Documentation/admin-guide/abi-obsolete.rst | 1 +
 Documentation/admin-guide/abi-removed.rst  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/obsolete/sysfs-gpio b/Documentation/ABI/obsolete/sysfs-gpio
index 40d41ea1a3f5..18ba539e365c 100644
--- a/Documentation/ABI/obsolete/sysfs-gpio
+++ b/Documentation/ABI/obsolete/sysfs-gpio
@@ -13,6 +13,8 @@ Description:
   GPIOs are identified as they are inside the kernel, using integers in
   the range 0..INT_MAX.  See Documentation/gpio for more information.
 
+  ::
+
     /sys/class/gpio
 	/export ... asks the kernel to export a GPIO to userspace
 	/unexport ... to return a GPIO to the kernel
diff --git a/Documentation/admin-guide/abi-obsolete.rst b/Documentation/admin-guide/abi-obsolete.rst
index cda9168445a5..d095867899c5 100644
--- a/Documentation/admin-guide/abi-obsolete.rst
+++ b/Documentation/admin-guide/abi-obsolete.rst
@@ -8,3 +8,4 @@ The description of the interface will document the reason why it is
 obsolete and when it can be expected to be removed.
 
 .. kernel-abi:: $srctree/Documentation/ABI/obsolete
+   :rst:
diff --git a/Documentation/admin-guide/abi-removed.rst b/Documentation/admin-guide/abi-removed.rst
index 497978fc9632..f7e9e43023c1 100644
--- a/Documentation/admin-guide/abi-removed.rst
+++ b/Documentation/admin-guide/abi-removed.rst
@@ -2,3 +2,4 @@ ABI removed symbols
 ===================
 
 .. kernel-abi:: $srctree/Documentation/ABI/removed
+   :rst:
-- 
2.21.0

