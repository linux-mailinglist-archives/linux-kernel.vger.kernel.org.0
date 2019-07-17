Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31006B8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfGQJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 05:07:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQJHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:07:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 394AAAF47;
        Wed, 17 Jul 2019 09:07:29 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/2] Fixes for sub-section hotplug
Date:   Wed, 17 Jul 2019 11:07:23 +0200
Message-Id: <20190717090725.23618-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v1: Go the easy way and just adapt the check (Dan/Aneesh)

Hi all,

these two patches address a couple of issues I found while working on my
vmemmap-patchset.
The issues are:

        1) section_deactivate mistakenly zeroes ms->section_mem_map and then
           tries to check whether the section is an early section, but since
           section_mem_map might have been zeroed, we will return false
           when it is really an early section.
           In order to fix this, let us check whether the section is early
           at function entry, so we do not neet check it again later.

        2) shrink_{node,zone}_span work on sub-section granularity now.
           The problem is that since deactivation of the section occurs later
           on in sparse_remove_section, so the pfn_valid()->pfn_section_valid()
           check will always return true for every sub-section chunk.
           In order to avoid that, let us adapt the check and skip the whole
           range to be removed.
           The user visible effect of this is that we are always left with,
           at least, PAGES_PER_SECTION spanned, even if we got to remove all
           memory linked to a zone/node

Oscar Salvador (2):
  mm,sparse: Fix deactivate_section for early sections
  mm,memory_hotplug: Fix shrink_{zone,node}_span

 mm/memory_hotplug.c | 8 ++++----
 mm/sparse.c         | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.12.3

