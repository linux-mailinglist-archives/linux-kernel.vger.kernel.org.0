Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0C15668
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEFXkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfEFXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:13 -0400
Subject: Re: [GIT PULL] x86/mm changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=C3DxW0iM7YbgnkllOXTEU68bItN9PkZlWf+ubQ93Nc4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VvoUuoJXgjPln8vC2wcJQNJYYDcYizaJlnkxSlhsKq4EozVFds++ZcBtJYNaNhpHu
         N997LKC3NQV26c27S6KXO2R1AVIHrUE8mCa5xpvPyEngUZVUUvRSIpmbliaQvy/cDy
         HRPrhUL/Yry0tfwD+YJhNDZvoOvSa6UAJwqo3VjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506104035.GA39266@gmail.com>
References: <20190506104035.GA39266@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506104035.GA39266@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: caa841360134f863987f2d4f77b8dc2fbb7596f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bc40e549aeea2de20fc571749de9bbfc099fb34
Message-Id: <155718601289.9113.11584977696832531909.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:40:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bc40e549aeea2de20fc571749de9bbfc099fb34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
