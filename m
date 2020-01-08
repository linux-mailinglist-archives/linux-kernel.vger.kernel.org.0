Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885C41346F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgAHP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:59:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:64327 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgAHP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 07:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="395782691"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2020 07:59:19 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 0/4] Fix use-after-free and deadlock issues
Date:   Thu,  9 Jan 2020 00:28:02 +0800
Message-Id: <1578500886-21771-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several use-after-free and deadlock issues:
(1) Fix use-after-free when deleting resource groups.
(2) Fix use-after-free due to inaccurate refcount of rdtgroup.
(3) Fix a deadlock due to inaccurate active reference of kernfs node.
(4) Follow-up cleanup for the change in previous patch.

Xiaochen Shen (4):
  x86/resctrl: Fix use-after-free when deleting resource groups
  x86/resctrl: Fix use-after-free due to inaccurate refcount of rdtgroup
  x86/resctrl: Fix a deadlock due to inaccurate active reference of
    kernfs node
  x86/resctrl: Clean up unused function parameter in mkdir path

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
1.8.3.1

