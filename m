Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32BEB343D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfIPEyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 00:54:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:24862 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfIPEyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:54:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 21:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="190964364"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2019 21:54:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i9j1g-0003jq-5a; Mon, 16 Sep 2019 12:54:12 +0800
Date:   Mon, 16 Sep 2019 12:53:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [RFC PATCH] mm, slab_common: all_kmalloc_info[] can be static
Message-ID: <20190916045350.2buptf4exdnbxttf@48261080c7f1>
References: <20190915170809.10702-6-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915170809.10702-6-lpf.vector@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 95f3b3d20e9b ("mm, slab_common: Make kmalloc_caches[] start at size KMALLOC_MIN_SIZE")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 slab_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2aed30deb0714..bf1cf4ba35f86 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1118,7 +1118,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
  * time. kmalloc_index() supports up to 2^26=64MB, so the final entry of the
  * table is kmalloc-67108864.
  */
-const struct kmalloc_info_struct all_kmalloc_info[] __initconst = {
+static const struct kmalloc_info_struct all_kmalloc_info[] __initconst = {
 	SET_KMALLOC_SIZE(       8,    8),    SET_KMALLOC_SIZE(      16,   16),
 	SET_KMALLOC_SIZE(      32,   32),    SET_KMALLOC_SIZE(      64,   64),
 #if KMALLOC_SIZE_96_EXIST == 1
