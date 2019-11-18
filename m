Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96371009D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKRQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:56:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:36456 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfKRQ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:56:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 08:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="231229499"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2019 08:56:32 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iWkKG-0002v9-C7; Tue, 19 Nov 2019 00:56:32 +0800
Date:   Tue, 19 Nov 2019 00:56:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] vsock/vmci: vmci_vsock_cb_host_called can be
 static
Message-ID: <20191118165615.y3kx2zkulexkoqwy@4978f4969bb8>
References: <201911190014.3ixYVAbj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911190014.3ixYVAbj%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI guest/host are active")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 vmci_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index 95fed4664a2d2..cbb706dabede9 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -30,7 +30,7 @@ static bool vmci_host_personality_initialized;
 
 static DEFINE_MUTEX(vmci_vsock_mutex); /* protects vmci_vsock_transport_cb */
 static vmci_vsock_cb vmci_vsock_transport_cb;
-bool vmci_vsock_cb_host_called;
+static bool vmci_vsock_cb_host_called;
 
 /*
  * vmci_get_context_id() - Gets the current context ID.
