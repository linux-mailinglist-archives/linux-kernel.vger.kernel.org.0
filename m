Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD96FD190
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKNX17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:27:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:56626 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKNX17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:27:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 15:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; 
   d="scan'208";a="406494946"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2019 15:27:56 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iVOWq-000HuG-93; Fri, 15 Nov 2019 07:27:56 +0800
Date:   Fri, 15 Nov 2019 07:26:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH] soc: fsl: qe: qe_uart_set_mctrl() can be static
Message-ID: <20191114232655.vhu7d4putwbbyyee@4978f4969bb8>
References: <20191101124210.14510-37-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101124210.14510-37-linux@rasmusvillemoes.dk>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 116af8542b17 ("soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ucc_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a5330582b6103..58891be29e1cf 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -283,7 +283,7 @@ static unsigned int qe_uart_tx_empty(struct uart_port *port)
  * don't need that support. This function must exist, however, otherwise
  * the kernel will panic.
  */
-void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+static void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 }
 
