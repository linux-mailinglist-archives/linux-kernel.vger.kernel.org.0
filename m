Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B56131C84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 00:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFXpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 18:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgAFXpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:45:07 -0500
Subject: Re: [GIT PULL] tracing: Fixes for 5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578354306;
        bh=wK/w/9w+E9BDyO3+eeTNnQY7G4egWMouThmIgQ10f2s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FGHOC+RjeOOyiZmJcdu8rRfWrBKiQBi407SALdBjhuqOJ/vWfWlkurOOTo4kR8eX0
         1jOwYrfu5G9nsVr2QRDm+mbpVQnpvtRKpuWJEF2qe7B/RggS67+iHIUh/9tAi3w+Ah
         tAZT3tFBXq3bWNixk7OjKyIaNvINPXbRr77H0BUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106162528.56814293@gandalf.local.home>
References: <20200106162528.56814293@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106162528.56814293@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-rc5
X-PR-Tracked-Commit-Id: 72879ee0c53e2fc17f443f7b1adcc0d5130cd934
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae6088216ce4b99b3a4aaaccd2eb2dd40d473d42
Message-Id: <157835430644.4029.3991291842174369618.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 23:45:06 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 16:25:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae6088216ce4b99b3a4aaaccd2eb2dd40d473d42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
