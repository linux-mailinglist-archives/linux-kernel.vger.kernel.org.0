Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007471785EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgCCWuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:50:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:13236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbgCCWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:50:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 14:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="319622085"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.184.249])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2020 14:50:48 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] tools/power/x86/intel-speed-select: Bug fixes for
Date:   Tue,  3 Mar 2020 14:50:42 -0800
Message-Id: <20200303225044.362525-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest code at 5.6-* cycle has two bugs related to CPU count and
sending of CLOS_PM_QOS_CONFIG.

Srinivas Pandruvada (2):
  tools/power/x86/intel-speed-select: Fix mailbox usage for
    CLOS_PM_QOS_CONFIG
  tools/power/x86/intel-speed-select: Fix last cpu number

 tools/power/x86/intel-speed-select/isst-config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.24.1

