Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F868508
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfGOIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 04:15:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729351AbfGOIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72429AFE0;
        Mon, 15 Jul 2019 08:15:57 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] Fixes for sub-section hotplug
Date:   Mon, 15 Jul 2019 10:15:47 +0200
Message-Id: <20190715081549.32577-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
	   The problem is that deactivation of the section occurs later on
	   in sparse_remove_section, so the pfn_valid()->pfn_section_valid()
	   check will always return true.
	   The user visible effect of this is that we are always left with,
	   at least, PAGES_PER_SECTION spanned, even if we got to remove all
	   memory linked to a zone.
	   In order to fix this, decouple section_deactivate() from
	   sparse_remove_section, and let __remove_section first call
	   section_deactivate(), so then __remove_zone()->shrink_{zone,node}
	   will find the right information.

Actually, both patches could be merged in one, but I went this way to make it
more smooth.

Once this have been merged (unless there is a major controvery), I plan to send
out a patch refactoring shrink_{node,zone}_span, since right now it is a bit
messy.

Oscar Salvador (2):
  mm,sparse: Fix deactivate_section for early sections
  mm,memory_hotplug: Fix shrink_{zone,node}_span

 include/linux/memory_hotplug.h |  7 ++--
 mm/memory_hotplug.c            |  6 +++-
 mm/sparse.c                    | 76 +++++++++++++++++++++++++++++-------------
 3 files changed, 62 insertions(+), 27 deletions(-)

-- 
2.12.3

