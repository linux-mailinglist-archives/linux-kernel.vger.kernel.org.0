Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD512A03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfECIp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 04:45:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:5527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfECIpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811527"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:22 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [GIT PULL 02/22] intel_th: SPDX-ify the documentation
Date:   Fri,  3 May 2019 11:44:35 +0300
Message-Id: <20190503084455.23436-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDX header to the Intel TH documentation.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/intel_th.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/intel_th.rst b/Documentation/trace/intel_th.rst
index 19e2d633f3c7..baa12eb09ef4 100644
--- a/Documentation/trace/intel_th.rst
+++ b/Documentation/trace/intel_th.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =======================
 Intel(R) Trace Hub (TH)
 =======================
-- 
2.20.1

