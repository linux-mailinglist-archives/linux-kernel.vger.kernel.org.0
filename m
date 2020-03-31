Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59541199AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgCaQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:09:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:23356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbgCaQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:09:19 -0400
IronPort-SDR: Oqt7jqI4OYv0nI0hb0piT23/oUyZqITWnvwSMoblVP7/fV8y7cZdwReYvL4UMrUc/VxhlPgfb+
 Z+VQE8VE6sRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:08:58 -0700
IronPort-SDR: QSuPW6bkwG/dYUfgWTD/KCA25/nrY67YBweQXGuqLF58LNrzZlKCG2vttELzB6YwrT4VgAQRr9
 PGXXQjI3aaiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="395549170"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 09:08:57 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] firmware: fpga: replace the error codes with the standard ones 
Date:   Tue, 31 Mar 2020 11:25:21 -0500
Message-Id: <1585671922-9754-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The Intel service layer driver has defined error codes for the
specific services, which started from FPGA configuration then RSU
(Remote Status Update).

Intel service layer driver should define the standard error codes
rather than keep adding more error codes for the new services.

The standard error codes will be used by all the clients of Intel service
layer driver.

Replace FPGA and RSU specific error codes with Intel service layer’s
Common error codes.

All changes need to be in one patch, otherwise it will break bisection.

Richard Gong (1):
  firmware: fpga: replace the error codes with the standard ones

 drivers/firmware/stratix10-rsu.c                   | 10 +--
 drivers/firmware/stratix10-svc.c                   | 62 ++++++-------------
 drivers/fpga/stratix10-soc.c                       | 25 +++-----
 include/linux/firmware/intel/stratix10-smc.h       | 49 +++++++--------
 .../linux/firmware/intel/stratix10-svc-client.h    | 71 +++++++++-------------
 5 files changed, 84 insertions(+), 133 deletions(-)

-- 
2.7.4

