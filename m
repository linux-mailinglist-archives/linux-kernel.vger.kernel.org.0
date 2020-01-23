Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD261471C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAWTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 14:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAWTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:03 -0500
Subject: Re: [GIT PULL] tracing: Fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807803;
        bh=gGqf9RVxZhCKoMFY2ldJgR1sCy1Grazo5FMrYdMp0Ow=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LMXuPBRRovnTqpFhDbme27VcyW60UfdcvE3ae/bcaPzfI1aHJmqEuHir672UVDDkD
         RuIcnPJmBEOuzrHE5yTKpmSJOTA3x43RGYVdyEk71mHlhdcMu06woYQ/NCCyzNO15o
         lyV31qGNjzS6MDSG26/SEgA1sSAhduGNiTaDVyjQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200121094906.421206d7@gandalf.local.home>
References: <20200121094906.421206d7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200121094906.421206d7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.5-rc6
X-PR-Tracked-Commit-Id: bf24daac8f2bd5b8affaec03c2be1d20bcdd6837
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b61387cb732cf283d318b2165c44913525fe545f
Message-Id: <157980780316.24133.5551941136795201050.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Jan 2020 09:49:06 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b61387cb732cf283d318b2165c44913525fe545f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
