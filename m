Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5FDD516
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 00:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfJRWuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 18:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfJRWuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:50:05 -0400
Subject: Re: [GIT PULL] usercopy for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571439005;
        bh=7YIazAbbMPpuUbNo0kFLtOxgOXFmmnIkW8p7EeCWw/k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NUI0x+EA/ym1AVVvL3eoG/9YsHE0N+0qJHdllNt3jq8O3V4BX4YYwXIq0isWsp+V8
         DH92N7kMh6DxNJjYlCKxUcnBJGgIi8U0PgMockoUdjnQ0yX36PrFb3InC/6H/tClKh
         J+CUX6jZcMv5sDI5Qa3R/DoGDD4+8uQa8aWLPNAw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191018153311.30516-1-christian.brauner@ubuntu.com>
References: <20191018153311.30516-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191018153311.30516-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/copy-struct-from-user-v5.4-rc4
X-PR-Tracked-Commit-Id: f418dddffc8007945fd5962380ebde770a240cf5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eb4b3b0dd9ae3e5399ff902da87d13740a2b70f
Message-Id: <157143900527.13317.16923139652749471962.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 22:50:05 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 17:33:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/copy-struct-from-user-v5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eb4b3b0dd9ae3e5399ff902da87d13740a2b70f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
