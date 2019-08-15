Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDD8E266
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 03:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfHOBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 21:34:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:19739 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfHOBeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:34:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:30 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="352096850"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:30 -0700
Subject: [PATCH 0/3] libnvdimm/security: Enumerate the frozen state and
 other cleanups
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Aug 2019 18:20:13 -0700
Message-ID: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff reported a scenario where ndctl was failing to unlock DIMMs [1].
Through the course of debug it was discovered that the security
interface on the DIMMs was in the 'frozen' state disallowing unlock, or
any security operation.  Unfortunately the kernel only showed that the
DIMMs were 'locked', not 'locked' and 'frozen'.

Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
"security-operations-allowed" state independently of the lock status.
Then, followup with cleanups related to replacing a security-state-enum
with a set of flags.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html
---

Dan Williams (3):
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations


 drivers/acpi/nfit/intel.c        |   65 +++++++-----
 drivers/nvdimm/bus.c             |    2 
 drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
 drivers/nvdimm/nd-core.h         |   51 ++++------
 drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |    9 +-
 tools/testing/nvdimm/dimm_devs.c |   19 +---
 7 files changed, 231 insertions(+), 248 deletions(-)
