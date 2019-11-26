Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7759910984B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 05:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKZEZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 23:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfKZEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:06 -0500
Subject: Re: [GIT PULL] thread changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742306;
        bh=jK/VUn7MPSgfrC/8QCbv3sdYwL2bm90oAbw6w/L+eGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OoiL6Wo4bdStYQLNJnaVvI83zaQ/1tHh/QvbhXb4j2A+0hQxyUYKtZfINaokeRIka
         brvg6CpD5k2/dMscZ+tC3jA+5VoTovIc4rgGH9h8pRNzvFXKemNbpKQc5jYKBEqgpQ
         cEPcR/8V6lWvGZhcfQXuH5yV4ORGl+cyxxf8SoQg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191124190716.26639-1-christian.brauner@ubuntu.com>
References: <20191124190716.26639-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191124190716.26639-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/threads-v5.5
X-PR-Tracked-Commit-Id: 11fde161ab37f2938504bf896b48afbd18ea71cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0acefef58451a995981e6d641220fecc53bd85a4
Message-Id: <157474230599.2264.98811466337086221.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:05 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Nov 2019 20:07:16 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0acefef58451a995981e6d641220fecc53bd85a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
