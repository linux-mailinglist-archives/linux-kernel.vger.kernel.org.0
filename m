Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EADA1B48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfH2NVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:21:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:4059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2NVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:21:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:21:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197804500"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 06:21:16 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] software node: fixes for two smatch errors
Date:   Thu, 29 Aug 2019 16:21:14 +0300
Message-Id: <20190829132116.76120-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Both potentially unitialized variable errors.

Heikki Krogerus (2):
  software node: Fix use of potentially uninitialized variable
  software node: Fix use of potentially uninitialized variable

 drivers/base/swnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.23.0.rc1

