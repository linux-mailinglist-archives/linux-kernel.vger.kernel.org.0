Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7B4F4BA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 11:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFVJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 05:34:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:26120 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFVJeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 02:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="312233133"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2019 02:34:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] perf intel-pt: CBR improvements
Date:   Sat, 22 Jun 2019 12:32:41 +0300
Message-Id: <20190622093248.581-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some improvements for the handling of core-to-bus ratio (CBR),
including exporting it.


Adrian Hunter (7):
      perf intel-pt: Decoder to output CBR changes immediately
      perf intel-pt: Cater for CBR change in PSB+
      perf intel-pt: Add CBR value to decoder state
      perf intel-pt: Synthesize CBR events when last seen value changes
      perf db-export: Export synth events
      perf scripts python: export-to-sqlite.py: Export Intel PT power and ptwrite events
      perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events

 tools/perf/scripts/python/export-to-postgresql.py  | 251 +++++++++++++++++++++
 tools/perf/scripts/python/export-to-sqlite.py      | 239 ++++++++++++++++++++
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  24 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |  65 ++++--
 .../util/scripting-engines/trace-event-python.c    |  46 +++-
 6 files changed, 590 insertions(+), 36 deletions(-)a


Regards
Adrian

