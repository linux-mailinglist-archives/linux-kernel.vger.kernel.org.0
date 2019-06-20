Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CA4D4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfFTRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:23:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yW1Zc5GIK+BKL+26rWvmFTg6ula/a95p/eU3y8+MmS0=; b=Vn2f15RH6NIY15vw70ZjKc/JxP
        XjO+1sVYYo9lkEEl/1GqOcd/5ccNJPSy/VWtTiUw+BvcOzi1Smk4yDlC0OR4v5vHv/8ly2e2+zIsO
        9tPgKFh3Xv+xiegpWY/1BwosyXWWn3RlyqyeFdMGbnIB8dXzqZT+tAsrFlxAWj7OPGamJIebQm2nH
        Ff95UbQXx8naA2vDB4qX7Zpiti81SrH/skIri6HIuaddxyU/Kw3vhlMQZvPK0s3pQWzVM/roLUGSJ
        YFW2BB2TqYDHIrFpM3V5ZNw7tgwTc5tn25sl5wvD0l0Q1z77+wbIv/stq2TN+MzV/1syc7Z78RF5p
        6Jj3fNNw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mL-0008Ro-W2; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Dp-Vv; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 18/22] doc: ABI scripts: add a SPDX header file
Date:   Thu, 20 Jun 2019 14:23:10 -0300
Message-Id: <c1aee9d8832ed687378c27adb9779f3c1b67bd97.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both are released under GPL v2.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 1 +
 scripts/get_abi.pl                 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index ef91b1e1ff4b..5d43cac73d0a 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -1,4 +1,5 @@
 # coding=utf-8
+# SPDX-License-Identifier: GPL-2.0
 #
 u"""
     kernel-abi
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 25248c012eb3..7bc619b6890c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -1,4 +1,5 @@
 #!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
 
 use strict;
 use Pod::Usage;
-- 
2.21.0

