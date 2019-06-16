Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7D47618
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFPRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 13:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfFPRfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:35:07 -0400
Subject: Re: [GIT pull] x86 fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560706506;
        bh=617KQHfj2Ryfjn1DYBmM0LnRSYlGsYKRB0UYPgmKMoQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aXi/uMaSphaaOhig1tVMvmhhn27p2TfMNKPJt7v0mHXwxqhrY2Uc3bgT+wnj8uP4W
         Hud2nSU0/UNRylONdKDS6iPkXYtvVtb+LWJrxtqJbIRU2NKCPQuIn4EAmAoILk1mKP
         tWHgib+7GWilgcXRRVpYdr9n3JAM/XDFLrfycSl4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156068459205.30217.5408680705089895210.tglx@nanos.tec.linutronix.de>
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
 <156068459205.30217.5408680705089895210.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156068459205.30217.5408680705089895210.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 78f4e932f7760d965fb1569025d1576ab77557c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 963172d9c7e862654d3d24cbcafb33f33ae697a8
Message-Id: <156070650676.13049.6101879897496740987.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jun 2019 17:35:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jun 2019 11:29:52 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/963172d9c7e862654d3d24cbcafb33f33ae697a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
