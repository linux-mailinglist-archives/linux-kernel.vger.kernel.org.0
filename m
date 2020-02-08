Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96CB15659E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHRA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 12:00:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:14586 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBHRA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 12:00:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 09:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="232687537"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2020 09:00:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] x86/platform: intel-uncore-frequnecy bug fixes
Date:   Sat,  8 Feb 2020 09:00:50 -0800
Message-Id: <20200208170052.57712-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix issue reported by static checker and potential
race condition.

Srinivas Pandruvada (2):
  platform/x86/intel-uncore-freq: Fix static checker issue and potential
    race condition
  platform/x86/intel-uncore-freq: Add release callback

 drivers/platform/x86/intel-uncore-frequency.c | 51 ++++++++++++-------
 1 file changed, 33 insertions(+), 18 deletions(-)

-- 
2.20.1

