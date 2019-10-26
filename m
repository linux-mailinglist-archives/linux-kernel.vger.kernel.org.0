Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6138E5E93
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJZSSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 14:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJZSSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:18:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C213B20867;
        Sat, 26 Oct 2019 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572113922;
        bh=CZmIjRk7Ctzyq66+gkb1djgjSF1cIpcPpkufPg0Y7Bg=;
        h=Date:From:To:Cc:Subject:From;
        b=V4VPPl+lqtY5Fo81EDPAt+tbJrbMmHZcasRcgLnSlkLsj1XnLG0BAh+ET46f7u0tW
         UuzcbRdrKJMm+ZjVZvPxmdxzm78BWdAR3Ly0tYMzETQ9AqWOayWWANDDQJfpljenrB
         pc4JIcyVIEhRAQjvwySvHGFDW7OM55hYwFBcvZgk=
Date:   Sat, 26 Oct 2019 20:18:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fix for 5.4-rc5
Message-ID: <20191026181839.GA649095@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc5

for you to fetch changes up to 153c5d8191c26165dbbd2646448ca7207f7796d0:

  staging: wlan-ng: fix exit return when sme->key_idx >= NUM_WEPKEYS (2019-10-14 15:40:08 +0200)

----------------------------------------------------------------
Staging driver fix for 5.4-rc5

Here is a single staging driver fix, for the wlan-ng driver, that
resolves a reported issue.

It is been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      staging: wlan-ng: fix exit return when sme->key_idx >= NUM_WEPKEYS

 drivers/staging/wlan-ng/cfg80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
