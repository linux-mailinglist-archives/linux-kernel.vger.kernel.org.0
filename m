Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57FA4566
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfHaQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 12:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfHaQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 12:45:10 -0400
Subject: Re: [GIT PULL] tracing: Various tracing fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567269910;
        bh=dx1dm/UvZPssok6LPsk96F3h8aKfd55oG6yy8ZZs68c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BKf6879FKh4kvkuswixkXAO85gjhdAdZC/AWKwtXd7SkR0JUKeJbSzkjuoUeZwhfm
         Rb5UFe+E/qMtxM5RJGx1nPWFwj4wcT2/AvGn+xorlBUW/pSb0TFZIlbAvO6ohI1cV+
         ejK6xu0sxTDnIOnwLgiZUNgu+H5wxNW/pcmPbcyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190831070839.3f7dbc33@gandalf.local.home>
References: <20190831070839.3f7dbc33@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190831070839.3f7dbc33@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.3-rc6
X-PR-Tracked-Commit-Id: c68c9ec1c52e5bcd221eb09bc5344ad4f407b204
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95381debd9ee8787256c3cdb92d2b167efa4b863
Message-Id: <156726990997.25629.4041151467580480068.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Aug 2019 16:45:09 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 31 Aug 2019 07:08:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95381debd9ee8787256c3cdb92d2b167efa4b863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
