Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170E0CC294
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfJDSZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 14:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJDSZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:25:17 -0400
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570213517;
        bh=Dgr+e4VoPGbKGHtJ+S2y2h8pcRaXPakDcv4W6ohIRY4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VqYKj2LjECAEfK787tTmife4lKb4VubLGSrQyECeyexRWNYkqQPNHUmX0R1rwTGMC
         s/fjYjTOV58rWHaAxvorQs1zxcAw3D06Io11AoB4GzXMqiQOKhSLIAVObE5gybuUn+
         U3JgdOez60dNTqYBbEXkXj3W+UjtJG0lNFAM8JlI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191004104116.20418-1-christian.brauner@ubuntu.com>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191004104116.20418-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/copy-struct-from-user-v5.4-rc2
X-PR-Tracked-Commit-Id: 341115822f8832f0c2d8af2f7e151c4c9a77bcd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e524d16e7e324039f2a9f82e302f0a39ac7d5812
Message-Id: <157021351721.30669.7159530418605250249.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 18:25:17 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Oct 2019 12:41:16 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/copy-struct-from-user-v5.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e524d16e7e324039f2a9f82e302f0a39ac7d5812

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
