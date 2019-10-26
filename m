Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37450E5E90
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfJZSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJZSR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:17:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C9320867;
        Sat, 26 Oct 2019 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113878;
        bh=RQ/cVlWxQP8ljE3dAegnmn4xdUMWOAe2VvYslJOjLkE=;
        h=Date:From:To:Cc:Subject:From;
        b=lHhD1Xk5EKGlx4YwtZWt/TFSrnBRFFI9fV/uiFDAHlL6P+YNQpCzibbNVtouJXprx
         l58Dg3I+QeBrPRggLj8q/83ogDUyJE83y24cmBUGJEqbIAY5mg6TMBXm5UfJDLMtmM
         JCy0+fCMLQhYRd72ukSOGbSoouHKo+mp560x5Zcg=
Date:   Sat, 26 Oct 2019 20:17:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fix for 5.4-rc5
Message-ID: <20191026181756.GA648966@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc5

for you to fetch changes up to 45d02f79b539073b76077836871de6b674e36eb4:

  binder: Don't modify VMA bounds in ->mmap handler (2019-10-17 05:58:44 -0700)

----------------------------------------------------------------
Char/Misc fix for 5.4-rc5

This is a single char/misc driver fix (well, a binder fix to be
specific) to resolve a reported issue by Jann.  It's been in linux-next
for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Jann Horn (1):
      binder: Don't modify VMA bounds in ->mmap handler

 drivers/android/binder.c       | 7 -------
 drivers/android/binder_alloc.c | 6 ++++--
 2 files changed, 4 insertions(+), 9 deletions(-)
