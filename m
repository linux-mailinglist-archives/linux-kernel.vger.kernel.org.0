Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744D4D3D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfJKKSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 06:18:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:3120 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:18:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 03:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,283,1566889200"; 
   d="scan'208";a="207400617"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 11 Oct 2019 03:18:31 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 11 Oct 2019 13:18:31 +0300
Date:   Fri, 11 Oct 2019 13:18:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [GIT PULL] Thunderbolt fixes for v5.4
Message-ID: <20191011101831.GC2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.4-1

for you to fetch changes up to 747125db6dcd8bcc21f13d013f6e6a2acade21ee:

  thunderbolt: Drop unnecessary read when writing LC command in Ice Lake (2019-10-08 12:08:21 +0300)

----------------------------------------------------------------
thunderbolt: Fixes for v5.4

This includes three fixes for various issues people have reported:

  - Fix DP tunneling on some Light Ridge controllers
  - Fix for lockdep circular locking dependency warning
  - Drop unnecessary read on ICL

----------------------------------------------------------------
Mika Westerberg (3):
      thunderbolt: Read DP IN adapter first two dwords in one go
      thunderbolt: Fix lockdep circular locking depedency warning
      thunderbolt: Drop unnecessary read when writing LC command in Ice Lake

 drivers/thunderbolt/nhi_ops.c |  1 -
 drivers/thunderbolt/switch.c  | 28 +++++++++++-----------------
 2 files changed, 11 insertions(+), 18 deletions(-)
