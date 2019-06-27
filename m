Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9057BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 08:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0GNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 02:13:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF0GNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:13:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 23:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="313685026"
Received: from pg-eswbuild-angstrom-alpha.altera.com ([10.142.34.148])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 23:13:41 -0700
From:   "Ong, Hean Loong" <hean.loong.ong@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hean.loong.ong@intel.com, chin.liang.see@intel.com,
        Ong@vger.kernel.org
Subject: [PATCHv1] ARM64: defconfig: Adding LEDS_TRIGGERS_TIMER
Date:   Thu, 27 Jun 2019 22:07:08 +0800
Message-Id: <20190627140709.707-1-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to add LEDS_TRIGGERS_TIMER for blinking LED controls 
upon simple boot upon ARM devices

Ong, Hean Loong (1):
  ARM64: defconfig: Add LEDS_TRIGGERS_TIMER for blinking leds

 arch/arm64/configs/defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

