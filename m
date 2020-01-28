Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD21B14ADA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgA1BfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgA1BfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:06 -0500
Subject: Re: [GIT pull] core/debugobjects for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175305;
        bh=ZSu5mq6Oxdt0LaHPGJ0tpYBxr2ZqcPinCTQaArGsnXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LBU7xiG7TX6f4h9PtJFH/kRSE73V3WB3GKOsg2pRzJ3RepbJLTwrGhI0wnhv2Z0Cv
         2GsJLpI4nZPmaxTlSnUrLUB7xM569cKanp8JRHyVRZDUfor+Kex9nwyr/2i6O4RbxO
         hoiSoahzu1Mb2WBI8hROtPcfvRQwTE7G9huHs1w4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.18200732992760262654.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-debugobjects-2020-01-28
X-PR-Tracked-Commit-Id: 35fd7a637c42bb54ba4608f4d40ae6e55fc88781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 534b0a8b677443c0aa8c4c71ff7887f08a2b9b41
Message-Id: <158017530576.6677.3993435996530435106.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/534b0a8b677443c0aa8c4c71ff7887f08a2b9b41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
