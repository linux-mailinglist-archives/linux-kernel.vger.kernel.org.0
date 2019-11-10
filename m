Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE0F6BA5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKJVfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfKJVfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:35:08 -0500
Subject: Re: [GIT PULL] IIO fixes / Staging driver for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573421708;
        bh=xZqUAhBa1XJbuk1g9QivLxHkD4LDzfnm732PnGqJ76I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G8tkBXql3Zze2mTheCxmgaVokjdRIhG20I2GFRvhtYP5xPct/zMZucKZBbfGmxqtP
         O5PL51caVKgd4TOcRzHPN1KYQDCtVGoPfIjPSDD0c7oWaB7FDKqadz9Mzm95W4Kyqs
         W2ne4SVjl41V5f08V8csV9zpVXeN7on7Fmdm3Npo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191110154303.GA2867499@kroah.com>
References: <20191110154303.GA2867499@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191110154303.GA2867499@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.4-rc7
X-PR-Tracked-Commit-Id: e39fcaef7ed993950af74a584f8246022b551971
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd892625d0e252d967387d0a2af6dd6a864b3fdf
Message-Id: <157342170813.28901.805337468261635748.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:35:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 16:43:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd892625d0e252d967387d0a2af6dd6a864b3fdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
