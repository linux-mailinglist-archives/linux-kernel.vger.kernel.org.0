Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D982C10DB9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 00:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfK2XNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 18:13:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:42747 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2XNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 18:13:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 15:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,259,1571727600"; 
   d="scan'208";a="384193665"
Received: from gamanzi-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.3.126])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2019 15:13:42 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v24 01/24] x86/sgx: Update MAINTAINERS
Date:   Sat, 30 Nov 2019 01:13:03 +0200
Message-Id: <20191129231326.18076-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
References: <20191129231326.18076-1-jarkko.sakkinen@linux.intel.com>
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
index 0154674cbad3..08a67272ed14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8512,6 +8512,17 @@ F:	Documentation/x86/intel_txt.rst
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

