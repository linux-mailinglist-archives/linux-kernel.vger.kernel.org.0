Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB60A917F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfHRQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 12:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHRQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:07 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147306;
        bh=osxYO8NiukhmULofOULw5jWDiDTdXqeNo4E73zTzoWs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K/cXQ2IQgb6bwclkeKanOaPSNF3sgbyj9e5iAfh7ImGVe+i4Bj5AYdHWy1zNT/1xy
         MBOXuGKFQZQxrCyT6T8Z1DVmlzuAHJpfWg0dLQmDhaYf3bUt+yBUsnCZI0LOrJNa6H
         N1TFzhFm8Ff9ajpC9qx0LEFtB8kfajXrQwA+IzoQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190818085712.GA28706@kroah.com>
References: <20190818085712.GA28706@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190818085712.GA28706@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.3-rc5
X-PR-Tracked-Commit-Id: 48b30e10bfc20ec6195642cc09ea6f08a8015df7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae1a616af36e5ad0726407b76feed5060a424744
Message-Id: <156614730662.21549.9794520161342956124.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 10:57:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae1a616af36e5ad0726407b76feed5060a424744

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
