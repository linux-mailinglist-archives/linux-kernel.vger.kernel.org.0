Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD3510FC07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLCKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 05:49:14 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:41522 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCKtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:49:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6BD9B3F54F;
        Tue,  3 Dec 2019 11:49:10 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="YDgmWrLH";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OjqnXakQPOto; Tue,  3 Dec 2019 11:49:09 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D6A713F522;
        Tue,  3 Dec 2019 11:49:05 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 264A1360305;
        Tue,  3 Dec 2019 11:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575370145; bh=gEAWX3bxsQ+0DHZpNEnqkkzzmaYw0NCL+IkRobqSyPI=;
        h=From:To:Cc:Subject:Date:From;
        b=YDgmWrLHazoWCTxOBvFDT6YYiOt3VqND08Ox4WddOwx8Zs1Hm+7/ziYe9GwwG2Kks
         PYN3/eYXPiW2jeRKgEBgtcErKrMUiGw07ZmWnz6q289jJ862I863onkb6m/31nuKi6
         V7eo6l9g14JJKrszmFt4WXw3FbA9NYdJCZRSHldw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 0/2] mm, drm/ttm: Fix pte insertion with customized protection
Date:   Tue,  3 Dec 2019 11:48:51 +0100
Message-Id: <20191203104853.4378-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The drm/ttm module is using a modified on-stack copy of the
struct vm_area_struct to be able to set a page protection with customized
caching. Fix that by adding a vmf_insert_mixed_prot() function similar
to the existing vmf_insert_pfn_prot() for use with drm/ttm.

I'd like to merge this through a drm tree.

Changes since v1:
*) Formatting fixes in patch 1
*) Updated commit message of patch 2.

Thomas Hellstrom (2):
  mm: Add and export vmf_insert_mixed_prot()
  drm/ttm: Fix vm page protection handling

 drivers/gpu/drm/ttm/ttm_bo_vm.c | 14 +++++++-------
 include/linux/mm.h              |  2 ++
 mm/memory.c                     | 15 +++++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>

-- 
2.21.0

