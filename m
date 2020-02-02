Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D614FF13
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 21:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBBUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 15:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBUUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 15:20:14 -0500
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580674813;
        bh=po/EkdwtNa+zreBFmqFHz+DcSumbOUa5aNZxL6LpnfY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XJ8AT6FbR3zNbm8ek6+P5DJWnZySOOVLCuvsghQJ8YdzA/QYqykmXv77/Ji4jexGU
         Vq4o9gtq1MCD2CVmWuoU33YUU1XDN1qmyPphkF3RO65zM59UAX7dEAwKFfd5n/GNKV
         RSN1+0pQbkC1cXpu0nFNJCQeTapJ5KUEcY+h7dDc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200202.115757.1806399388803712136.davem@davemloft.net>
References: <20200202.115757.1806399388803712136.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200202.115757.1806399388803712136.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 11648b8339f840d4b1f4c54a1abec8025d9e077d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46d6b7becb1d5a8e697db786590c19e4067a975a
Message-Id: <158067481377.26837.15865712190713168229.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Feb 2020 20:20:13 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 02 Feb 2020 11:57:57 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46d6b7becb1d5a8e697db786590c19e4067a975a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
