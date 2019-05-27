Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF52B2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfE0LHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 07:07:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8g48329FQhEsiuSKYHuqBZrE6fufei6sAnLid9P5pyM=; b=acc1/u1a6AefoquRE3b/srYkDW
        XFNwIsPb2hVl+wyGlUv0yE8gtd+3c5dY3pYC48jKQLZlg696R5KeUbkVK7N1BCwPktTpph73Qda7M
        gebfcPXNW8NRZ1MkJDVzzvYiqaqHXeoGwy18OVVPwE4C6lP3Zx3BROsaSOYIBEDacbg0Xizp0x34n
        +Mmt89ZcuII1EDTTdI71QmqRWgGawoZlxnLP5GXZ0LEIRZa3+lkBNhD5yaGqXO3pMLce7yDuZLYD1
        fdEpw4fNOAPSlf1QjSGsrFWbH9Ob5Pjr8Tm+d/fUryoDiLwU1SfJ1Ls7AptEb24qdh82HUOi7udMY
        WfwjDecw==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061s-Ma; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002ci-P4; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/5] scripts/sphinx-pre-install: get rid of RHEL7 explicity check
Date:   Mon, 27 May 2019 08:07:38 -0300
Message-Id: <d01851ff7721606d2033fef2d6a09321f8e9702d.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
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

