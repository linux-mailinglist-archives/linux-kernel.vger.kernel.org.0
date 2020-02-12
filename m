Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF1159E86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgBLBKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbgBLBKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:10:22 -0500
Subject: Re: [GIT PULL] tracing: Various fixes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581469822;
        bh=NFKJyW++GfidCTnHhfybxGf0AfrhRL6GFA3JyyzIfsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hELfn3I6jwBIiIUesY1qiojwZnOpr6FNeB//q+psgs3X+Vd6pLuTqVMFXK6y2CPdS
         KGrR5Ljt+JCCjX5q38yxEEsWIhwNdt41ubNF+CC4yY34X23P8W+SRjZ80MtqJEM8Jw
         W35lwf0oIElcOZcfhZvCcQ2MwPqEt15FBjDoFVeQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200211155519.64c8c589@gandalf.local.home>
References: <20200211155519.64c8c589@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200211155519.64c8c589@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.6-rc1
X-PR-Tracked-Commit-Id: 7276531d4036f5db2af15c8b6caa02e7741f5d80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61a75954034f951a77d58b1cfb9186c62e6abcf8
Message-Id: <158146982201.31393.11991474710114475956.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Feb 2020 01:10:22 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Feb 2020 15:55:19 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61a75954034f951a77d58b1cfb9186c62e6abcf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
