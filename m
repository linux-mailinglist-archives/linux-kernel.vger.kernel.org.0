Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C769127637
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTHHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLTHHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:07:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC0924679;
        Fri, 20 Dec 2019 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576825670;
        bh=aFS+0PHvMZNXAX3LB7Kp3RPtki0Ke/sDgUiUCMTGwZI=;
        h=Date:From:To:Cc:Subject:From;
        b=Q3Y2keQ49oszEdE4a0IZ/6aCYd8yrN7KFE5Mp2DmIi7GMcrBy+08qveB6Tak9EIhl
         Srj32iHOgWL2psLvCA8lJSt0dOG8W7KAq53p+n9jiQUCH56MW3v4hayBc4I5H/djwv
         +wqfswrzQ40eoKesa0aun78ZA9sQi6Tx/rogkrfo=
Date:   Fri, 20 Dec 2019 08:07:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
Message-ID: <20191220070747.GA2190169@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.5-rc3

for you to fetch changes up to cb47b9f8630ae3fa3f5fbd0c7003faba7abdf711:

  tty/serial: atmel: fix out of range clock divider handling (2019-12-17 14:17:32 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.5-rc3

Here are some small tty and serial driver fixes for 5.5-rc3.

Only 4 small patches here:
  - atmel serial driver fix
  - msm_serial driver fix
  - sprd serial driver fix
  - tty core port fix

The last tty core fix should resolve a long-standing bug with a race
at port creation time that some people would see, and Sudip finally
tracked down.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
David Engraf (1):
      tty/serial: atmel: fix out of range clock divider handling

Leo Yan (1):
      tty: serial: msm_serial: Fix lockup for sysrq and oops

Sudip Mukherjee (1):
      tty: link tty and port before configuring it as console

Yonghan Ye (1):
      serial: sprd: Add clearing break interrupt operation

 drivers/tty/serial/atmel_serial.c | 43 ++++++++++++++++++++-------------------
 drivers/tty/serial/msm_serial.c   | 13 ++++++++++--
 drivers/tty/serial/serial_core.c  |  1 +
 drivers/tty/serial/sprd_serial.c  |  3 +++
 drivers/tty/tty_port.c            |  3 ++-
 5 files changed, 39 insertions(+), 24 deletions(-)
