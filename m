Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95015149A13
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgAZK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 05:27:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:7005 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgAZK1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:27:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 02:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,365,1574150400"; 
   d="scan'208";a="428720075"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2020 02:27:16 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, yang.shi@linux.alibaba.com, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v3 0/4] cleanup on do_pages_move()
Date:   Sun, 26 Jan 2020 18:26:19 +0800
Message-Id: <20200126102623.9616-1-richardw.yang@linux.intel.com>
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

v3:
  * rebase on top of Yang Shi's fix "mm: move_pages: report the number of
    non-attempted pages"
v2:
  * remove some unnecessary cleanup


Wei Yang (4):
  mm/migrate.c: not necessary to check start and i
  mm/migrate.c: wrap do_move_pages_to_node() and store_status()
  mm/migrate.c: check pagelist in move_pages_and_store_status()
  mm/migrate.c: handle same node and add failure in the same way

 mm/migrate.c | 90 ++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

-- 
2.17.1

