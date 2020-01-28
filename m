Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19E14ADA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgA1BfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgA1BfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:07 -0500
Subject: Re: [GIT pull] x86/pti for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175307;
        bh=vB/vmGJvrT5mTNB2gQAX9U199YXnGtolt1nPOb4pYJc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A2v5wLtUUNZi8Ho6IoQnNZJsX8fgCglIHP8vCpsmCcG5lKC6W3TZTKNXtGv4MdWa+
         ZH+8HvgxmlWerja254bfAnFg6YcOesuwkUI5eFIt3P/xSmh5Bk47LSBKcv+dV5yoyv
         JEPuLVS4pK/NY3rZMIc08YVne7gZoAwvGqacnDhw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896590.31887.13698042592919956648.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896590.31887.13698042592919956648.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896590.31887.13698042592919956648.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-2020-01-28
X-PR-Tracked-Commit-Id: a84de2fa962c1b0551653fe245d6cb5f6129179c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0be0eff1a5ab77d588b76bd8b1c92d5d17b3f73
Message-Id: <158017530728.6677.2598917917725215240.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0be0eff1a5ab77d588b76bd8b1c92d5d17b3f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
