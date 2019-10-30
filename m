Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99036E9C99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJ3Nrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:47:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:28792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfJ3Nrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="190281913"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 06:47:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf: Small fixes for the kernel counters
Date:   Wed, 30 Oct 2019 15:47:29 +0200
Message-Id: <20191030134731.5437-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a result of [1] it seems a reasonable thing to do to refuse to create
kernel events with attr.aux_output (2/2). The other one is a comment fix.

[1] https://marc.info/?l=linux-kernel&m=157242901628761&w=2

Alexander Shishkin (2):
  perf: Reattach a misplaced comment
  perf: Disallow aux_output for kernel events

 kernel/events/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.23.0

