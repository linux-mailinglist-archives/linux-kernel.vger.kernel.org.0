Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9CC31C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfJAKvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:51:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:13738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbfJAKvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:51:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 03:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205042098"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2019 03:51:39 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/2] extcon: axp288: Move to swnodes
Date:   Tue,  1 Oct 2019 13:51:36 +0300
Message-Id: <20191001105138.73036-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

That AXP288 extcon driver is the last that uses build-in connection
description. I'm replacing it with a code that finds the role mux
software node instead.

I'm proposing also here a little helper
usb_role_switch_find_by_fwnode() that uses
class_find_device_by_fwnode() to find the role switches.

thanks,

Heikki Krogerus (2):
  usb: roles: Add usb_role_switch_find_by_fwnode()
  extcon: axp288: Remove the build-in connection description

 drivers/extcon/extcon-axp288.c | 38 ++++++++++++++++++++--------------
 drivers/usb/roles/class.c      | 21 +++++++++++++++++++
 include/linux/usb/role.h       |  3 +++
 3 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.23.0

