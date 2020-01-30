Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD82E14E05F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgA3SAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbgA3SAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:22 -0500
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407222;
        bh=2/ZSv7Dx7c+P3mc4S1Sy8HpjfXMRztYJsni16dkb0XA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cNgyfblXPgKJ2+plbH7PIraTdzTHqF/pBvAOiZUim8w6DX2XXcVJ5kZRGLyOX8tPt
         Qu2HzLd/890g6SQqJ4Y92Xj1dR/OOtSr7SAjwByWYXXAInorHL6DYVZXUG0EawA74t
         0mF1pQNEpfviM0E0VKfjdF/VJMTHf8hsM3k2+UEc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130.111927.1184332737812002632.davem@davemloft.net>
References: <20200130.111927.1184332737812002632.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130.111927.1184332737812002632.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: d68712ee35069455ea4043d443c8d4fb9a1ee956
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ca4c6429f92598a84e4c3292ea7d187c9d7b033
Message-Id: <158040722204.2766.8349842403156129206.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:22 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 11:19:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ca4c6429f92598a84e4c3292ea7d187c9d7b033

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
