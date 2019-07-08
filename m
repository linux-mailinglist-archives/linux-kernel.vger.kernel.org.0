Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD961A74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfGHFxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 01:53:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:41691 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfGHFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:53:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 22:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="363699032"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2019 22:53:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf scripts python: export-to-postgresql/sqlite.py: Fix DROP VIEW power_events_view
Date:   Mon,  8 Jul 2019 08:52:30 +0300
Message-Id: <20190708055232.5032-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a small fix to the export-to-postgresql.py script.
The export-to-sqlite.py script had the same issue but SQLite did not seem
to mind. However I made the fix anyway for good measure.


Adrian Hunter (2):
      perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
      perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view

 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 tools/perf/scripts/python/export-to-sqlite.py     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Regards
Adrian
