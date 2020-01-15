Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E579613C133
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgAOMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 07:41:25 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:56434 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAOMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:41:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 80C953F580;
        Wed, 15 Jan 2020 13:41:22 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=KXnyIQFV;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FkalIzvwkN6R; Wed, 15 Jan 2020 13:41:19 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id EE0D23F57C;
        Wed, 15 Jan 2020 13:41:17 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 26BC8360315;
        Wed, 15 Jan 2020 13:41:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1579092077; bh=GiTFW6X2twKG29NhsaA6D/1fvW6BZJTV6SkcljMbP24=;
        h=From:To:Cc:Subject:Date:From;
        b=KXnyIQFV7pe+g2TkxE9Lz4eksNtJkSUKeRGH4zMQ9ALfzGJCbUS24TlxP0e4aHh2G
         RVOsfCJjpDSh0+OBthv2E+hGrt5UuJGXvifbtpxH6QGr/9Up3cJ+4w9S7Vi+SbK+oy
         /yT1Fl77gDFqahmWtnfwCxwaYVphQEvc9b40bLlU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v5 0/2] mm, drm/ttm: Fix pte insertion with customized protection
Date:   Wed, 15 Jan 2020 13:41:05 +0100
Message-Id: <20200115124107.3845-1-thomas_os@shipmail.org>
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

Patches are acked to be merged through a drm tree.

Changes since v1:
*) Formatting fixes in patch 1
*) Updated commit message of patch 2.
Changes since v2:
*) Moved vmf_insert_mixed_prot() export to patch 2 (Michal Hocko)
*) Documented under which conditions it's safe to use a page protection
   different from struct vm_area_struct::vm_page_prot. (Michal Hocko)
Changes since v3:
*) More documentation regarding under which conditions it's safe to use a
   page protection different from struct vm_area_struct::vm_page_prot. This
   time also in core vm. (Michal Hocko)
Changes since v4:
*) Fixed a typo
*) Added acks.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>

-- 
2.21.0

