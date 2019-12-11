Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5F11B8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfLKQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:32:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730072AbfLKQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576081934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LKFqnBlvG1fW2JXIJg+dQL5IlchdA2nn0WN6YjbROus=;
        b=XrJ2CeNNB2sK5jipaTMCiPCv/Eky1QNufATCNHd+aspwWEqFf+BTsTA8LXojd+H6xETeXu
        op2b34FbPG4T0qgD31AjIiInKLetWFGvUvFFurTsU47kIiY8PbvfSMf1MZrzNENq/na0cd
        /5yUFN3LszHNDN+CWVROU9NkLaqzI6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-pAFiM52NPEutsb_TVfBPDg-1; Wed, 11 Dec 2019 11:32:11 -0500
X-MC-Unique: pAFiM52NPEutsb_TVfBPDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A74AB0923;
        Wed, 11 Dec 2019 16:32:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62A37605FF;
        Wed, 11 Dec 2019 16:32:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bob Picco <bob.picco@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Sistare <steven.sistare@oracle.com>
Subject: [PATCH v2 0/3] mm: fix max_pfn not falling on section boundary
Date:   Wed, 11 Dec 2019 17:31:58 +0100
Message-Id: <20191211163201.17179-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing with different memory sizes for a x86-64 guest, I discovered that
some memmaps (highest section if max_mem does not fall on the section
boundary) are marked as being valid and online, but contain garbage. We
have to properly initialize these memmaps.

Looking at /proc/kpageflags and friends, I found some more issues,
partially related to this.

v1 -> v2:
- "mm: fix uninitialized memmaps on a partially populated last section"
-- Refine patch description (esp. how to reproduce), add tested-by
- "fs/proc/page.c: allow inspection of last section and fix end detection=
"
-- Make it compile for !CONFIG_SPARSE and add a comment to the new
   helper function

David Hildenbrand (3):
  mm: fix uninitialized memmaps on a partially populated last section
  fs/proc/page.c: allow inspection of last section and fix end detection
  mm: initialize memmap of unavailable memory directly

 fs/proc/page.c     | 30 +++++++++++++++++++++++++++---
 include/linux/mm.h |  6 ------
 mm/page_alloc.c    | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 59 insertions(+), 20 deletions(-)

--=20
2.23.0

