Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C702160253
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 08:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgBPH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 02:26:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PhQ0i38oEIy8rxcG5bvlNNl7qCVmgAaM1CT0P3kL5u4=; b=opvl18cxl5iKN056DviJ4XPdq7
        4fAhmFKpTtffSD92oE5bLHVh2HiGIXB7Fy+MhQ7m1uvYdiFqXUZkJxoMPGuzyV+5d31i49WU766hR
        jfdM7NKMW0H4+wtJiqcHiB0UWkx9xfOysy6vWR7DE5YWi+obf66azD3x5S9jVTfGK7Uj/jZcLDdWD
        VeCD8Re3jLK9joEH4GlTZNzSANMBaKq1JtKqMdMNYzc0u3qrWK1MEMKZ/7FNfxjrOt3gp5GAVMrr6
        XtPvS4KOseSDUI9mr9e6dfNy4cRtpfJ3BP1ZHjPPEMfeTq2vAYDBWGfvKBLFne+SeXPHOYgrcN+vp
        5r36nljw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3EJa-0003mL-JK; Sun, 16 Feb 2020 07:26:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: sort _SPHINXDIRS for 'make help'
Message-ID: <f2f47689-6a59-1d5e-6eda-ee24fe2a8fc7@infradead.org>
Date:   Sat, 15 Feb 2020 23:26:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Sort the _SPHINXDIRS so that the 'make help' output is easier to read &
search and in a predictable order instead of some unknown pseudo-random
order.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-56-rc1.orig/Documentation/Makefile
+++ lnx-56-rc1/Documentation/Makefile
@@ -13,7 +13,7 @@ endif
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
 SPHINXDIRS    = .
-_SPHINXDIRS   = $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst))
+_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
 SPHINX_CONF   = conf.py
 PAPER         =
 BUILDDIR      = $(obj)/output

