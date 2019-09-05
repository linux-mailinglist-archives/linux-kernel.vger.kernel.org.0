Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643A6AABF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbfIETaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:30:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:49262 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfIETaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:30:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 12:30:21 -0700
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="177408318"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 12:30:19 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] New Intel CPU model numbers
Date:   Thu,  5 Sep 2019 12:30:16 -0700
Message-Id: <20190905193020.14707-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to be more aggressive about pushing new CPU model
numbers into <asm/intel-family.h>. Basically as soon as Intel
talks publicly about some new model and I have the model
number, then I'll post the update.

Changes to the rest of the kernel will follow at the
pace of the various groups that have model specific
code ready to be made public.

This series has just the model numbers for Tiger Lake and
Elkhart Lake. The new Airmont variant also comes with a
patch of other spots in the kernel that need updates.

Gayatri Kammela (2):
  x86/cpu: Add Tiger Lake to Intel family
  x86/cpu: Add Elkhart Lake to Intel family

Rahul Tanwar (2):
  x86/cpu: Add new Airmont variant to Intel family
  x86/cpu: Update init data for new Airmont CPU model

 arch/x86/include/asm/intel-family.h | 5 +++++
 arch/x86/kernel/cpu/common.c        | 1 +
 arch/x86/kernel/cpu/intel.c         | 1 +
 arch/x86/kernel/tsc_msr.c           | 5 +++++
 4 files changed, 12 insertions(+)

-- 
2.20.1

