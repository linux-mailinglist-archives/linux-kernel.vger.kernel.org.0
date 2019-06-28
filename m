Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD359AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfF1MXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:23:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfF1MUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RpqcJp7jxT06N05sMhPXoS32VrL9wunVGQftBjY4F0M=; b=lrCdlOc8WfukKVP/4L2O7TIJGr
        LPe+vZcn1y0tzgsBf4XEdyORzTEj/q2N3dyEDdtt1bv7JSJZwlBCYr4R8CQNn9EoxoKdsTkCt0UmK
        4oeqY/OfWaKHdcoCE4/Cs2D4K5zYAxehcSIDQHocMO6rjoaRgxVf+pC6BaFM7MEWD150r1qixcbFs
        uc8fCzG8OUT20Ptky0OklRMNgxPFpBJoPdRXz3cP6t0DmY5N9IUYoDPoXtjtqu7Axsm6nF7OEjsfq
        lWLILtSIeQEVdigz3buGMnJaZM6+LZlgDGCQ2CWLZ9+9a+VL0apfQCm8WNqAj4nU5AUvAqHI3ZFJj
        cavobI7g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprw-00009v-RV; Fri, 28 Jun 2019 12:20:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpru-0005AG-8g; Fri, 28 Jun 2019 09:20:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 43/43] docs: logo.txt: rename it to COPYING-logo
Date:   Fri, 28 Jun 2019 09:20:39 -0300
Message-Id: <bff3bc73e6e731019612eecf67a10693a44b6caa.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has nothing to do with the Kernel documentation. It
contains the copyright permissions for Tux at Documentation/logo.gif.

So, rename it accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{logo.txt => COPYING-logo} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{logo.txt => COPYING-logo} (100%)

diff --git a/Documentation/logo.txt b/Documentation/COPYING-logo
similarity index 100%
rename from Documentation/logo.txt
rename to Documentation/COPYING-logo
-- 
2.21.0

