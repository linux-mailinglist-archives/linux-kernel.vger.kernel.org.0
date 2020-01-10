Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C6137182
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgAJPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 10:39:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgAJPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:39:53 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ipwO4-0007H0-FW; Fri, 10 Jan 2020 16:39:48 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dick Hollenbeck <dick@softplc.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH RT 0/2] serial: 8250: atomic console fixups
Date:   Fri, 10 Jan 2020 16:45:30 +0106
Message-Id: <20200110153932.14970-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dick Hollenbeck pointed out[0] that serial usage for non-consoles
was dramatically affected due to the atomic console
implementation. Indeed, the implementation was taking the global
console_atomic_lock for _all_ 8250 ports, regardless if they were
consoles or not.

This series fixes that by only using the cpu-lock if the port is
a console. While making those changes, I realized that the clear
counter/ier-cache is not needed, so that is also removed.

Dick also pointed out that the IER accessor functions were using
non-typical names. These are updated and moved to inline macros.

Finally, I noticed that the fsl, ingenic, and mtk variants were
directly accessing IER. These are now also appropriately wrapped.

In his suggestion, Dick did optimizations regarding IER caching.
However, these are _not_ included because they may have some
unwanted side-effects. For example, I noticed a few places in
8250 code where the value of uart_8250_port->ier is expected to
be different than the hardware register.

John Ogness

[0] https://www.spinics.net/lists/linux-rt-users/msg21480.html

John Ogness (2):
  serial: 8250: only atomic lock for console
  serial: 8250: fsl/ingenic/mtk: fix atomic console

 drivers/tty/serial/8250/8250.h         | 65 ++++++++++++++-------
 drivers/tty/serial/8250/8250_core.c    |  6 +-
 drivers/tty/serial/8250/8250_dma.c     |  4 +-
 drivers/tty/serial/8250/8250_fsl.c     |  9 +++
 drivers/tty/serial/8250/8250_ingenic.c |  7 +++
 drivers/tty/serial/8250/8250_mtk.c     | 29 ++++++++-
 drivers/tty/serial/8250/8250_port.c    | 81 ++++++--------------------
 7 files changed, 109 insertions(+), 92 deletions(-)

-- 
2.20.1

