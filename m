Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78331567D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfEFXl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEFXkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:04 -0400
Subject: Re: [GIT PULL] objtool changes for v5.2: Add build-time uaccess
 permissions and DF validation
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186003;
        bh=W3ik7iNp9HuFV3wZAwF2ME+7eZkN4UdcUjSOU3Q1Xi0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JrstXFrT/2Vx0aH6MlX37xs/PjQOCuY2bOwZbqpKUzjGVOFuw3bC6go5yshoPZvAE
         xjGMc/+jpPadn4KBYCbB48U7Mnx6J37PhjIMJWBr7eRjAjIKVjrzfycL1gXyiwEdeS
         ra9NttVkZruI4u4rWqvaDSA7+XisOAo/frJD+wds=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506072012.GA33946@gmail.com>
References: <20190506072012.GA33946@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506072012.GA33946@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: 29da93fea3ea39ab9b12270cc6be1b70ef201c9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ec62961e6de9506e8b8620dc19897d8cfd41c2e
Message-Id: <155718600393.9113.2903009226925365728.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 09:20:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ec62961e6de9506e8b8620dc19897d8cfd41c2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
