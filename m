Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9087137853
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgAJVJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJVJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:09:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A14205F4;
        Fri, 10 Jan 2020 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578690548;
        bh=6MlYhVCe2B71x5cTLF0G3ClY5eYYkjb58bFq1uU3I4o=;
        h=Date:From:To:Cc:Subject:From;
        b=qjRLazROD6GAyu5InMb4CNEIqmYvKY+h14yuU6ZTw7zZTEdaWQ0b5Z/clTIsS0t4t
         7D2MciXN3SZwCvnXsV4336dHO5yaRzu2hC8XnXt9849XKBf/2ibFrGk8JcLBpI08F4
         FBKeGsRNH/v5tOhLyEDGdNE+mTxHq+hY4l+1dZ6Q=
Date:   Fri, 10 Jan 2020 22:09:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.5-rc6
Message-ID: <20200110210906.GA1871197@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.5-rc6

for you to fetch changes up to 68faa679b8be1a74e6663c21c3a9d25d32f1c079:

  chardev: Avoid potential use-after-free in 'chrdev_open()' (2020-01-06 20:10:26 +0100)

----------------------------------------------------------------
Char/Misc patch for 5.5-rc6

Here is a single fix, for the chrdev core, for 5.5-rc6

There's been a long-standing race condition triggered by syzbot, and
occasionally real people, in the chrdev open() path.  Will finally took
the time to track it down and fix it for real before the holidays.

Here's that one patch, it's been in linux-next for a while with no
reported issues and it does fix the reported problem.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Will Deacon (1):
      chardev: Avoid potential use-after-free in 'chrdev_open()'

 fs/char_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
