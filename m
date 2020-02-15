Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0851600AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 22:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgBOVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 16:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgBOVZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:25:22 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801922;
        bh=zJBT2YqubCCCwgBU575p+pJ4sIMFEAC0q80GVBIJxPw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PpBgJIs8+2D+BFWUweMwxmcRIcsBJmLMTpeYs/m6/fNdxAJkP4eo9625ONWWuqf2L
         Rigmwk2tDXooFl8IsFqz+XBwSmC3WdmIMYDLb6ckP6S5kCEeIbGmmsVYDRxKDzCI1K
         h1Bo1MtoBdGrHUk1ipzc1UAAxANg8Ns8YmYqROXg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200215194910.jmvolzk6xsngpcbr@localhost>
References: <20200215194910.jmvolzk6xsngpcbr@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200215194910.jmvolzk6xsngpcbr@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 3bf3c9744694803bd2d6f0ee70a6369b980530fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b719ae070ee2371c37d846616ef7453ec6811990
Message-Id: <158180192212.10388.582319674379439182.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Feb 2020 21:25:22 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Feb 2020 11:49:10 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b719ae070ee2371c37d846616ef7453ec6811990

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
