Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA50EC8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfKATKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 15:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfKATKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:10:05 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572635405;
        bh=ipfFBeDHMpw8NVPtpWiOvheA2MIJpvQb4oodlGwPkKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xPjcTRGgR3zFSE3ZHj6KC/PO8tsDUZx30/45fQVdT9BFJ+EQpoeRua18uR7mSgvPI
         R47Vb4jLZsYPbkAwqdiWLU4XgHBJ5cQff9tqeWY+aq7X+9E/NDuypxKJLQ77mGXt75
         7aAlJnQ1DvZXfejFolOiij4SxiqX/lFe4aXeyrpw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191101175508.GA125660@gmail.com>
References: <20191101175508.GA125660@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191101175508.GA125660@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: e284df705cf1eeedb5ec3a66ed82d17a64659150
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dbe6cb8f7e05bc9611602ef45980a6c57b245a3
Message-Id: <157263540511.17460.16890126514986955205.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 19:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 18:55:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dbe6cb8f7e05bc9611602ef45980a6c57b245a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
