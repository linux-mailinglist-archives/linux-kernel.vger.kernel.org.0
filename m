Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492D79750E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfHUIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 04:33:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:34007 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfHUIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:33:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 01:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="195953460"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 01:33:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
Date:   Wed, 21 Aug 2019 11:32:10 +0300
Message-Id: <20190821083216.1340-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

These patches to exported-sql-viewer.py, add a time chart based on context
switch information.  Context switch information was added to the database
export fairly recently, so the chart menu option will only appear if
context switch information is in the database.  Refer to the Exported SQL
Viewer Help option for more information about the chart.


Adrian Hunter (6):
      perf scripts python: exported-sql-viewer.py: Add LookupModel()
      perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
      perf scripts python: exported-sql-viewer.py: Add global time range calculations
      perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
      perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
      perf scripts python: exported-sql-viewer.py: Add Time chart by CPU

 tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
 1 file changed, 1531 insertions(+), 24 deletions(-)


Regards
Adrian
