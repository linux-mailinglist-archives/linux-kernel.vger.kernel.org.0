Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A535EF741
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 09:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfKEI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 03:27:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:44760 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbfKEI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:27:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 00:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="212493679"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2019 00:27:08 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf/x86/intel/pt: Optimizations
Date:   Tue,  5 Nov 2019 10:26:59 +0200
Message-Id: <20191105082701.78442-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

The first one was earlier part of the AUX sampling patchset, but wasn't
strictly sampling related. The second one is based on an observation that
between high-order AUX allocations and the Single Range output, we don't
have to reprogram buffer-related MSRs all of the time.

Alexander Shishkin (2):
  perf/x86/intel/pt: Opportunistically use single range output mode
  perf/x86/intel/pt: Prevent redundant WRMSRs

 arch/x86/events/intel/pt.c | 129 ++++++++++++++++++++++++++++---------
 arch/x86/events/intel/pt.h |  14 ++--
 2 files changed, 109 insertions(+), 34 deletions(-)

-- 
2.24.0.rc1

