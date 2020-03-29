Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CAE196F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgC2SFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 14:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbgC2SFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:05:07 -0400
Subject: Re: [GIT pull] irq/urgent for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585505106;
        bh=jnfNnj0sv2gm2msHIuWPWfyk8rzk7M7kSvsX7bi7Hv8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JCwa5LMvae6ifDOyTtM0HIrpujhBCLtsik8M9j++RiCbw9kNpzMGA/tp9+nwDAGxb
         le4qapwKCAYgXsbecQ0lppqZQf6bxjUAYLvvFRcO3hlP9TydIigTIV8FcKxdcEm64A
         OhMrrn+Y4NnnJSN9sCt5fqeP56yvl6TqUYLDa6ZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-03-29
X-PR-Tracked-Commit-Id: df81dfcfd6991d547653d46c051bac195cd182c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01af08bd24edf50b2d9e06f18df13cb8d0d645b7
Message-Id: <158550510649.18128.2876457880766417245.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Mar 2020 18:05:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 16:03:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01af08bd24edf50b2d9e06f18df13cb8d0d645b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
