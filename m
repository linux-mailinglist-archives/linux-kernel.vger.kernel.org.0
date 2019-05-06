Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AD15665
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEFXkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfEFXkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:14 -0400
Subject: Re: [GIT PULL] x86/topology changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186014;
        bh=MGrBDG7xGxtNonL6ACJinoe2njlzKnCIVifBMsoxCCk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wEfOUqLKyRx0e2icA+vqsSSilJPKjWI1WCVEdM6OYfDfIiE2ZEGvt66P3Nxhrkuc8
         oYZ2SnH7ByxTLtYCk3wMsdk0RHQiZ5pc7WJYznhYZmiSVBBnNPjgGmK+XQVoAZoShs
         9wZ8iYwOhAfREjIcEGqsysVFMGatXP6FKlp2J7ag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506105554.GA71356@gmail.com>
References: <20190506105554.GA71356@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506105554.GA71356@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-topology-for-linus
X-PR-Tracked-Commit-Id: 8fea0f59e97df3b9b8d2a76af54f633f4586751b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 948a64995aca6820abefd17f1a4258f5835c5ad9
Message-Id: <155718601406.9113.3249748304487031580.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:55:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-topology-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/948a64995aca6820abefd17f1a4258f5835c5ad9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
