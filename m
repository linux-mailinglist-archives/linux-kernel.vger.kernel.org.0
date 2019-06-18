Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D119E4AA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfFRSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:51:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wbE5UrmSnIxQ7ynjsp5tlChHxu7Tyq/gXbjLpmbx1Vc=; b=D7M7GC9AiZdbQ24Tz/iMR/Lu/b
        FXq+8kuNJVqFauTBdsQDiNFi7kIVMvhMrywkLlVK8a0iv93ACgjlxGMVfLmNmBnIdDBeqZBYaZKkS
        3DEcofDMlKZojkHKgVzGnqmiZE+mpviBHGyIdIhIt3qkuS8Txvj9wbCXgKo5sCluWGwsB6EbdDgQ1
        sm8tE2QBSgz8aOHxwTLwFd0uFtjr+9V75EudZZoVTSW117F1TSgOwXHssV3FWttlQrWJHIHMXZ/q7
        xQICX4b9FBWOTIRWCi6CVv9VCKsWIZs3q4tCoUJq3ph7zlck6uiyl6UZ15ShpDkQO3kVvFxy61nmr
        YVZsRn4g==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJCa-0006RL-75; Tue, 18 Jun 2019 18:51:28 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdJCW-0006UF-Bd; Tue, 18 Jun 2019 15:51:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        George Spelvin <lkml@sdf.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/6] lib: list_sort.c: add a blank line to avoid kernel-doc warnings
Date:   Tue, 18 Jun 2019 15:51:19 -0300
Message-Id: <019c38a60bdc87124e58f8acd541b484fc9893bb.1560883872.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for a list to be recognized as such, blank lines
are required.

Solve those Sphinx warnings:

./lib/list_sort.c:162: WARNING: Unexpected indentation.
./lib/list_sort.c:163: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 lib/list_sort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 712ed1f4eb64..52f0c258c895 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -157,9 +157,11 @@ static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
  *
  * The number of pending lists of size 2^k is determined by the
  * state of bit k of "count" plus two extra pieces of information:
+ *
  * - The state of bit k-1 (when k == 0, consider bit -1 always set), and
  * - Whether the higher-order bits are zero or non-zero (i.e.
  *   is count >= 2^(k+1)).
+ *
  * There are six states we distinguish.  "x" represents some arbitrary
  * bits, and "y" represents some arbitrary non-zero bits:
  * 0:  00x: 0 pending of size 2^k;           x pending of sizes < 2^k
-- 
2.21.0

