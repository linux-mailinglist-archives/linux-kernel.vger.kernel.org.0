Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9E17080A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBZSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgBZSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:50:11 -0500
Subject: Re: [GIT PULL] tracing/bootconfig: Fixes and changes to bootconfig
 before it goes live in a release
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743011;
        bh=uDAltjlUxzc15bAOw/zdVHiNALU1XSPnfMKKfcgJPh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZFbCt+7bjWQrxEpGeFL/bQQWqAxK40JygrK/imZWSKn8EViv+ecdQxdF+2C7c37wi
         lV04DePBsTANoa1cvu9yQKD62nX0Iu+871AZtRFcx1x4c9p/ZrbpbuDmQEBztWFiCV
         1Cmpxm6qk7hRfift4bJk/G83fzlbVAbJFnlgEDlM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200225191927.3cbaa0db@gandalf.local.home>
References: <20200225191927.3cbaa0db@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200225191927.3cbaa0db@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.6-rc2
X-PR-Tracked-Commit-Id: 2910b5aa6f545c044173a5cab3dbb7f43e23916d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91ad64a84e9e63e2906ae714dfa3933dd3f64c64
Message-Id: <158274301107.12298.17642734079886031956.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Feb 2020 18:50:11 +0000
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

The pull request you sent on Tue, 25 Feb 2020 19:19:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91ad64a84e9e63e2906ae714dfa3933dd3f64c64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
