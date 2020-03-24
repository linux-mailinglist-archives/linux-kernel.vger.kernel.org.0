Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C054A19174B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:15:09 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070108;
        bh=6iz/00lA67PKU53GPRZ6djTMfIMd00kLqbqrKNWFlLw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vrrcIy9FSRLFdYOXlCrRx+4EyAr0i3FZPf6lgzL5xd2sBSnzpGOzhJl8DzEkWM2p1
         Cz+P4s1jsd356oXgHULkeMLxNeCwJnfgcHW4KiFwuOwuZ3IA/nSBkmoOyO9RjLuSvw
         8SLhgWArr2OxKOuS1/iDiW7eyUwITc4g2jvhOb2U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200324090627.GA46739@gmail.com>
References: <20200324090627.GA46739@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200324090627.GA46739@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 870b4333a62e45b0b2000d14b301b7b8b8cad9da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f3ee43a462344f6509bd15c988e39d330af91b3
Message-Id: <158507010802.16590.2166787800981748763.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Mar 2020 17:15:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Mar 2020 10:06:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f3ee43a462344f6509bd15c988e39d330af91b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
