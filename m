Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52217ECB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCIXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 19:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgCIXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:40:07 -0400
Subject: Re: [GIT PULL] ktest: Updates and fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583797207;
        bh=DaPeSR+evs/0yveH1K6pt04ScdqLgbL9vAH8gGbvhkU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TYKkNbEwXX0YFOFewRzvQUNV2AahDou+xhjNlnrBq1Rc8+BMoXR83i8i2aNpc7ICV
         D8loTdLSAXbYWYub3d/8fb8WWjU8ruwZoAKJfs3VtZx+VG6MjAyrr8plTiDYGvGf0m
         rXv1MFb2BgI+aZ1f6o4A2mfH1LQ8Uzs0uIQqvC6c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200309162726.71fe6060@gandalf.local.home>
References: <20200309162726.71fe6060@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200309162726.71fe6060@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.6
X-PR-Tracked-Commit-Id: 1091c8fce8aa9c5abe1a73acab4bcaf58a729005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30bb5572ce7a8710fa9ea720b6ecb382791c9800
Message-Id: <158379720745.7202.8635621257082930121.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Mar 2020 23:40:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Mar 2020 16:27:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30bb5572ce7a8710fa9ea720b6ecb382791c9800

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
