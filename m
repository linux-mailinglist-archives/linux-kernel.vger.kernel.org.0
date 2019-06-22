Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518E14F745
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFVQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 12:59:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfFVQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B257ogQrfbYD6oqdOxu8mCF8PiL7+6m1J+MeyLKXYco=; b=kZQTDO160E+NqxhvGBx5fJ6ZXA
        hgD9eIHqpQ0bZ9Y+vkdtXqSFgRwAYDMFYrLzQQYXEED4lbX7uJiyplUFW4+iTsZHVD8KQYIjB7M+t
        7bDPMVrPoLN3RWKk2QlY9QVS0dSFeCwdiACWSPq7PPJ7Y2rpZd67yqefvwagBk+0ESCeefIBK26pe
        H/87HmIMITMATr0J1u0pDhtR1HoG1u1nORhTjmCiEDhXSB7pIMeKOBYtYkHQ+twwAFjeey5bgZDqm
        05dxbJ0GpVgCs6Ii5f/KleVQKihgsflu7eSj1JW0LGsYYSN4TnyYgCHeoZowyjpIvKdoRcp5Gi+l0
        e0sLvDTg==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLz-00054u-1M; Sat, 22 Jun 2019 16:59:03 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLs-0000vg-10; Sat, 22 Jun 2019 13:58:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] docs: kernel_abi.py: add a SPDX header file
Date:   Sat, 22 Jun 2019 13:58:50 -0300
Message-Id: <aa4a21b1b8578c35e771f737d72ce805daf0da31.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file is released under GPL v2.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.21.0

