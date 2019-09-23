Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33623BBC38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440459AbfIWTZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfIWTZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:25:24 -0400
Subject: Re: [GIT PULL] HID for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569266724;
        bh=8kVqj0yV/bUrdIKQVgvHg5HTG4vwQQp5wuYrXq2mLlg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NNqNyXTV5mf7e6iIr4eqvJiqZHpKBueWj60hvxuM6PAIF8OrBDk4jx5bIMV6f2YU4
         zj/RE5jRSygLMbnMP+/zfD2G/OS2XZxm4KkVLtcjXNwbj00ccjJxjBTPxFMuEdaquM
         geUndVzqQwUyoYG4Zjs3AL0JuoYdOHQiOR5e4M4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1909222244300.1459@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1909222244300.1459@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1909222244300.1459@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 8ca06d6f2d7ba0c7f2a988bb8f686eca45471420
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ad0bc78948652edc3067b6b49ba31b1598faa4a
Message-Id: <156926672436.9893.391806922270253802.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Sep 2019 19:25:24 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 22:49:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ad0bc78948652edc3067b6b49ba31b1598faa4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
