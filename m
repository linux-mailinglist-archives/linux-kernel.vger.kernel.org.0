Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4870F14D2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 23:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgA2WQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 17:16:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:57539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:16:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 14:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; 
   d="scan'208";a="222600055"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 14:16:26 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v4 0/4]  cleanup on do_pages_move()
Date:   Thu, 30 Jan 2020 06:16:12 +0800
Message-Id: <20200129221616.25432-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in do_pages_move() is a little mess for audience to read and has
some potential error on handling the return value. Especially there are
three calls on do_move_pages_to_node() and store_status() with almost the
same form.

This patch set tries to make the code a little friendly for audience by
consolidate the calls.

v4:
  * rephrase changelog based on suggestion from David Hildenbrand
  * trivial change on code style and comment
v3:
  * rebase on top of Yang Shi's fix "mm: move_pages: report the number of
    non-attempted pages"
v2:
  * remove some unnecessary cleanup

Wei Yang (4):
  mm/migrate.c: no need to check for i > start in do_pages_move()
  mm/migrate.c: wrap do_move_pages_to_node() and store_status()
  mm/migrate.c: check pagelist in move_pages_and_store_status()
  mm/migrate.c: unify "not queued for migration" handling in
    do_pages_move()

 mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

-- 
2.17.1

