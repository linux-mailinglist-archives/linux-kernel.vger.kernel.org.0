Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394F7190209
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCWXm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 19:42:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:45186 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:42:56 -0400
IronPort-SDR: W0YoUQqM0qWE9SHkS+xUER6xcZrAsrfhZAnC4+s6EZTXZrhOe7un/iMBf9ptHfPuUQsgVh1KiJ
 JoYabFzGlIPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:42:55 -0700
IronPort-SDR: A+bjJ0xPn/lggNJEvPaG/IUW0dlN8IAollxPCBOr80SR+pZeTKsaMplaXQnzcKpiOqLT7/6kzR
 oywEttsEjKqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="238044429"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2020 16:42:54 -0700
Subject: [PATCH 0/2] mm/madvise: teach MADV_PAGEOUT about swap cache
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, mhocko@suse.com,
        jannh@google.com, vbabka@suse.cz, minchan@kernel.org,
        dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 23 Mar 2020 16:41:47 -0700
Message-Id: <20200323234147.558EBA81@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_PAGEOUT ignores swap cache pages which are not mapped
into the calling process.  That's nasty because it means that
some of the most easily reclaimable pages are inaccessible to
a mechanism designed to reclaim pages.

This all turned out to be a bit nastier and more complicated
than I would have liked.  This has been lightly tested, but I
did pass a normal barrage of compile tests.

I rigged up a little test program to try to create these
situations.  Basically, if the parent "reader" RSS changes
in response to MADV_PAGEOUT actions in the child, there is
a problem.

	https://www.sr71.net/~dave/intel/madv-pageout.c

I'd add this to selftests, but it *requires* swap to work
and its parsing of /proc/self/maps is quite icky.

P.S. mincore() really doesn't work at all in this situation,
probably something we need to look at too.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
