Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDC1988E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgCaAZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgCaAZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:12 -0400
Subject: Re: [GIT PULL] locking changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614312;
        bh=qwU1/8t59tm4LLzC2gwAW+L8nxNE/7Nll+AHKfoOvpI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dME98o50OGrr2o49aaH/ybD2LPxE6Fj7Q4DX+eGTjN1VN12BhqLGX5LGIqTgO4nYX
         03Ko+i8eEG+f095ONI1QtozWJferyfWXZqtbYgLEyMvqe4013vNY+9zyI+w0QAkljL
         lpO7Yi6jVOQkUMKdmP9/Z//6lznf0FEhc6UR9kqM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330151840.GA99197@gmail.com>
References: <20200330151840.GA99197@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330151840.GA99197@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: f1e67e355c2aafeddf1eac31335709236996d2fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b9fd8a829a1eec7442e38afff21d610604de56a
Message-Id: <158561431197.380.15881604297342148798.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:18:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b9fd8a829a1eec7442e38afff21d610604de56a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
