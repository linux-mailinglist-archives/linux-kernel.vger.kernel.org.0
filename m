Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD7156CB5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 22:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBIV21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 16:28:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:2476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgBIV20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 16:28:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 13:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,422,1574150400"; 
   d="scan'208";a="405398973"
Received: from jradtke-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.22.75])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2020 13:28:21 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v26 21/22] x86/sgx: Update MAINTAINERS
Date:   Sun,  9 Feb 2020 23:26:08 +0200
Message-Id: <20200209212609.7928-22-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200209212609.7928-1-jarkko.sakkinen@linux.intel.com>
References: <20200209212609.7928-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the maintainer information for the SGX subsystem.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f74871a22c42..3bf62bf6be65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8721,6 +8721,17 @@ F:	Documentation/x86/intel_txt.rst
 F:	include/linux/tboot.h
 F:	arch/x86/kernel/tboot.c
 
+INTEL SGX
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Sean Christopherson <sean.j.christopherson@intel.com>
+L:	linux-sgx@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/intel-sgx/list/
+T:	git https://github.com/jsakkine-intel/linux-sgx.git
+F:	arch/x86/include/uapi/asm/sgx.h
+F:	arch/x86/kernel/cpu/sgx/*
+K:	\bSGX_
+
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
 L:	linux-pm@vger.kernel.org
-- 
2.20.1

