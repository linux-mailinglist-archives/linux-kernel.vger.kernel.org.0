Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2891010A481
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKZTaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfKZTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:09 -0500
Subject: Re: [GIT PULL] x86/boot changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796608;
        bh=hs1LMd790UFV2/Bhn6ASrIjC7uvLcIM9FJ5wBoAouIc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A9T1Z0CPp32h8Mc2hJMRySdJj6/DKoR5lfwreS5+Q5ZT8kgJPt5NNJDS1p11pJEhj
         kqj6LTDU/l0iE9zhnKjCVbbsMCH3XspWtqBgxk1UoVX8QCAO58JRpas7kMlF/+QTyv
         T50SysWjQkKKNh3Vv4uzQMql0mPD4uA8g4+uliio=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125132346.GA82640@gmail.com>
References: <20191125132346.GA82640@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125132346.GA82640@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: b3c72fc9a78e74161f9d05ef7191706060628f8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85fbf15bc9ac458f014fe70b38fa5773ee6aca9d
Message-Id: <157479660868.2359.1862131032912808682.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:23:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85fbf15bc9ac458f014fe70b38fa5773ee6aca9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
