Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645E014ADA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgA1BfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgA1BfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:07 -0500
Subject: Re: [GIT pull] timers/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175306;
        bh=8P4tKsHn4BJIyUqeDLor6y8yVhYtIQO7itZnd2K8bVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lbpJpntoWBUF/FQCvEHUAF4+IyH17sExT6nYIKSblClXLUo9i9WCRcbU2JFCbMeyJ
         9peomutUdOS3NcprAIeoHMxP1jMVEM25JCVNlWXgps4k6BVUCYo41pd18M6GhD4Rv8
         O3hard6CHXGq9KJAzFEgT5xI54koIaCTrP7sRcr4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896588.31887.14143226032971732742.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-2020-01-27
X-PR-Tracked-Commit-Id: fd928f3e32ba09381b287f8b732418434d932855
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e279160f491392f1345f6eb4b0eeec5a6a2ecdd7
Message-Id: <158017530677.6677.6776402225203859860.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e279160f491392f1345f6eb4b0eeec5a6a2ecdd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
