Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0510E4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfLBCup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfLBCu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:26 -0500
Subject: Re: [GIT PULL] hwspinlock updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255025;
        bh=36RyslkW61A04Bgfx/t9HsxNYAU+9E3zR0aRaeKOomY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YJkhILgN0aUtq90rFl7hU+6KDo8Oc0x2vh+gUyyTCxAqv1I6YEQ5cJaoUYpglpvMb
         7j01M+pSaM+1jXNrDeef9i7X8teT6HRc5+ykinFofmoJlKtKQPBRPbGMibyMY+uwu7
         YQKMQomkctCWXQFzNF7uApwuoaZxal21ZwlsVk2A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130191448.GC151303@yoga>
References: <20191130191448.GC151303@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130191448.GC151303@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/hwlock-v5.5
X-PR-Tracked-Commit-Id: 9d399f0c52951c1acf972bf98ea55ba8798fea7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 454d9c4aa7d54fd4f15c1427fc4f51347f300262
Message-Id: <157525502547.1709.7511129762810124596.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:25 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 11:14:48 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/454d9c4aa7d54fd4f15c1427fc4f51347f300262

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
