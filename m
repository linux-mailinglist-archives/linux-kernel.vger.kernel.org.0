Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DDDB1C06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfIMLQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 07:16:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:29021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfIMLQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:16:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 04:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336865384"
Received: from rbaldyga-mobl2.ger.corp.intel.com (HELO vm.ger.corp.intel.com) ([10.249.130.185])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 04:16:13 -0700
From:   Robert Baldyga <robert.baldyga@intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     michal.rakowski@intel.com,
        Robert Baldyga <robert.baldyga@intel.com>
Subject: [PATCH 0/2] nvme: Add kernel API for admin command
Date:   Fri, 13 Sep 2019 13:16:08 +0200
Message-Id: <20190913111610.9958-1-robert.baldyga@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds two functions providing kernel to kernel API
for submiting NVMe admin commands. This is for use of NVMe-aware
block device drivers stacking on top of NVMe drives. An example of
such driver is Open CAS Linux [1] which uses NVMe extended LBA
formats and thus needs to issue commands like nvme_admin_identify.

[1] https://github.com/Open-CAS/open-cas-linux

Best regards,
Robert Baldyga

Michal Rakowski (1):
  nvme: add API for sending admin commands by bdev

Robert Baldyga (1):
  nvme: add API for getting nsid by bdev

 drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     |  5 +++++
 2 files changed, 42 insertions(+)

-- 
2.17.1

--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

