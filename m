Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682B42E8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2XJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 19:09:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8g48329FQhEsiuSKYHuqBZrE6fufei6sAnLid9P5pyM=; b=Qux/vb0gEZbpIoRrdIcpH5BV+w
        xr/TqlKHoectdTf+HgQ3Ke1sXxjUol3EBv6wLJvQ5w8uW0Gk5LWXUhql3aLF7tZnNb7yQHnTvk7pj
        ivx2VAOl4rSaRtbv74/sbk8/tmvAKlydIIs5+o051eALgkG2w+tpx2LCCTKsmtMHjR+NLe5yKLMo7
        AtCi/S/yj4QYClyn824F8MTFhwGUnt+Knl0i09loEWPkN80+Jc0hU4a8nRCmjUJbJbmweGxxs+EWs
        Yn0TnhgOdR3tk+U1Adpm6zsWfllGHQu7YJzIyP/K8X8r7MHGfIT+J4qP6HvO61OnNmP1jy4AAAe+M
        YszfQ9pQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lC-Fh; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007TR-JM; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/10] scripts/sphinx-pre-install: get rid of RHEL7 explicity check
Date:   Wed, 29 May 2019 20:09:25 -0300
Message-Id: <062437323d4f495537dddf50247ebbfc126b026c.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHEL8 was already launched. This test won't get it, and will
do the wrong thing. Ok, we could fix it, but now we check
Sphinx version to ensure that it matches the minimal (1.3),
so there's no need for an explicit check there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 11239eb29695..ded3e2ef3f8d 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -581,19 +581,6 @@ sub check_needs()
 		print "Unknown OS\n";
 	}
 
-	# RHEL 7.x and clones have Sphinx version 1.1.x and incomplete texlive
-	if (($system_release =~ /Red Hat Enterprise Linux/) ||
-	    ($system_release =~ /CentOS/) ||
-	    ($system_release =~ /Scientific Linux/) ||
-	    ($system_release =~ /Oracle Linux Server/)) {
-		$virtualenv = 1;
-		$pdf = 0;
-
-		printf("NOTE: On this distro, Sphinx and TexLive shipped versions are incompatible\n");
-		printf("with doc build. So, use Sphinx via a Python virtual environment.\n\n");
-		printf("This script can't install a TexLive version that would provide PDF.\n");
-	}
-
 	# Check for needed programs/tools
 	check_sphinx();
 	check_perl_module("Pod::Usage", 0);
-- 
2.21.0

