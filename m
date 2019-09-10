Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39DEAF070
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437118AbfIJR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 13:26:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:26785 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394139AbfIJR0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:26:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="185574912"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2019 10:26:46 -0700
Subject: [PATCH 1/4] Documentation/process: Volunteer as the ambassador for Intel
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, sashal@kernel.org, ben@decadent.org.uk,
        tglx@linutronix.de, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 10 Sep 2019 10:26:46 -0700
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
In-Reply-To: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
Message-Id: <20190910172646.25BFCE7B@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tony Luck <tony.luck@intel.com>

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Trilok Soni <tsoni@codeaurora.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/Documentation/process/embargoed-hardware-issues.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN Documentation/process/embargoed-hardware-issues.rst~Documentation-process-Volunteer-as-the-ambassador-for-Intel Documentation/process/embargoed-hardware-issues.rst
--- a/Documentation/process/embargoed-hardware-issues.rst~Documentation-process-Volunteer-as-the-ambassador-for-Intel	2019-09-10 08:39:05.971488123 -0700
+++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 08:39:05.974488123 -0700
@@ -222,7 +222,7 @@ an involved disclosed party. The current
   ARM
   AMD
   IBM
-  Intel
+  Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
   Microsoft	Sasha Levin <sashal@kernel.org>
_
