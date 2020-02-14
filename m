Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972BE15CF04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 01:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBNAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 19:30:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:24000 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBNAaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:30:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 16:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="313906917"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2020 16:30:11 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v5 0/4] cleanup on do_pages_move()
Date:   Fri, 14 Feb 2020 08:30:13 +0800
Message-Id: <20200214003017.25558-1-richardw.yang@linux.intel.com>
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

v5:
  : rebase on top of latest upstream, "linux/pipe_fs_i.h: fix kernel-doc
    warnings after @wait was split"
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

 mm/migrate.c | 88 +++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 49 deletions(-)

-- 
2.17.1

