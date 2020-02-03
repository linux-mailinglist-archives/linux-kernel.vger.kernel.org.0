Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251C4151268
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 23:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBCWfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 17:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBCWfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:35:21 -0500
Subject: Re: [GIT PULL] (ibft) changes for 5.6 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580769320;
        bh=fg68AxkWyc1cl2syyyu7n1m65UmET8YZrZfqVmNDBwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jNOFZMT6GdN6l3sqfRdcbodVKi7h3oEY0jVDHqKsl8eCn8xQbLtZeUHa9wd/MNWsy
         StIk31NKe8SUiVIKpjSeouScnMaLL11dbBuy469G/RLl+FCEXWOO5ZSO31x+NdNtRT
         EYEXQtn75ZD75M/hE8VB4K7gPbRmh+UvXhQU3FBU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203221027.GA10946@char.us.oracle.com>
References: <20200203221027.GA10946@char.us.oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203221027.GA10946@char.us.oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git
 stable/for-linus-5.6
X-PR-Tracked-Commit-Id: c08406033fe83a4cb307f2a2e949c59bb86b4f49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1716f536425f72cca4b0ff42c4be9466ed38dbd9
Message-Id: <158076932059.15745.15059152979763695404.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 22:35:20 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 17:10:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1716f536425f72cca4b0ff42c4be9466ed38dbd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
