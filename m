Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9712ADF41E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfJURYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 13:24:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726819AbfJURYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571678648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tU7OuvHvFG+jtNsohsW1UDt65sDgAhzQIZb5QOHjnxk=;
        b=InW3dMJpMHohtxFjyCAzghiTCUWFWLk1v9dW0sijDgmuDaMtEsZEZUCatIMf/RlO43kimA
        4mtObUyxMGWXB9i6cmUkk3JBk8wyob0TOOojBAIocfz/4+CqqgcMzpQcSuqVtF0ZRo8PN8
        ewVrKCEBp6Y4gCeOsY3S7Ep3A0q2D38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ZILDmOTuPt2Q4a3Yd9I06Q-1; Mon, 21 Oct 2019 13:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE96800D41;
        Mon, 21 Oct 2019 17:24:01 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-42.ams2.redhat.com [10.36.116.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3F7160856;
        Mon, 21 Oct 2019 17:23:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/2] mm: Memory offlining + page isolation cleanups
Date:   Mon, 21 Oct 2019 19:23:51 +0200
Message-Id: <20191021172353.3056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZILDmOTuPt2Q4a3Yd9I06Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanups that popped up while working on (and discussing) virtio-mem:
 https://lkml.org/lkml/2019/9/19/463

Tested with DIMMs on x86.

As discussed with michal in v1, I'll soon look into removing the use
of PG_reserved during memory onlining completely - most probably
disallowing to offline memory blocks with holes, cleaning up the
onlining+offlining code.

v1 -> v2:
- "mm/page_alloc.c: Don't set pages PageReserved() when offlining"
-- Fixup one comment
- "mm/page_isolation.c: Convert SKIP_HWPOISON to MEMORY_OFFLINE"
-- Use parenthesis around checks
- Added ACKs

David Hildenbrand (2):
  mm/page_alloc.c: Don't set pages PageReserved() when offlining
  mm/page_isolation.c: Convert SKIP_HWPOISON to MEMORY_OFFLINE

 include/linux/page-isolation.h |  4 ++--
 mm/memory_hotplug.c            | 12 ++++++------
 mm/page_alloc.c                |  9 +++------
 mm/page_isolation.c            | 12 ++++++------
 4 files changed, 17 insertions(+), 20 deletions(-)

--=20
2.21.0

