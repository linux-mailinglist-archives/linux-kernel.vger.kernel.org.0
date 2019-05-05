Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6E142B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfEEWKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 18:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfEEWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:10:05 -0400
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557094204;
        bh=lOc1nQMU9PpDM/qJDeKyMjEbFRHtqze9t32froXlzhE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NXXBozAKmeDE0hVHVyF0k8h7/HgSyz+kj1ynHOB0n/o1/s3gufblWrSmohk98QfVX
         TPkfvusSwGIKTvumydW4HWNhjiLaAW4vfbDPF+140i4u4DXNsGrPwTyiBpPTFFDLoW
         qojd5hI2JWYsGUyyUjdc3jsmqBXFpF5rsrFUHKuw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190505110237.GA5049@gmail.com>
References: <20190505110237.GA5049@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190505110237.GA5049@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 9a4f26cc98d81b67ecc23b890c28e2df324e29f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70c9fb570b7c1c3edb03cbe745cf81ceeef5d484
Message-Id: <155709420419.22198.7259395960132765880.pr-tracker-bot@kernel.org>
Date:   Sun, 05 May 2019 22:10:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 May 2019 13:02:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70c9fb570b7c1c3edb03cbe745cf81ceeef5d484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
