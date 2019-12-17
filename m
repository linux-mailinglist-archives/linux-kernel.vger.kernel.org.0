Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B30123588
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfLQTU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 14:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfLQTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:15 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610414;
        bh=BHVYdzG8ksJXXCaPor9GX/bfq8K9t4erG+3T7klxFRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V45NajcO30yYmIboZa4b78pkRQBnk9IddUGAWK5z6k347V6e7ii6OlSo0hvDuJOna
         aO3uMg9avk7N3Cjf0GteDnE0x1Mih1i3/vsALH7jSJ3DetPn2H6yIz8PFgpmFh6m+A
         JuV1totDFoyYdxLK+6U80tMm3XuJsiVv1MGo/GQA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217113425.GA78787@gmail.com>
References: <20191217113425.GA78787@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217113425.GA78787@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 57e04eeda515ee979fec3bc3d64c408feae18acc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89c683cd06e03dfd3186c4cab1e2a39982c42a48
Message-Id: <157661041451.14288.7477009397154704712.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:34:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89c683cd06e03dfd3186c4cab1e2a39982c42a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
