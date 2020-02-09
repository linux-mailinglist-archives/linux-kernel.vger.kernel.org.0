Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454D7156C6D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBIUk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 15:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgBIUk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:26 -0500
Subject: Re: [GIT pull] SMP fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280826;
        bh=hWir79hazOBrkCFpWISrNPrGkwFOULKLV6U2H9A0nC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gqvx+xerjVqJX6CTzKgt5Ch3akLYtYP0u34tdGD8JpfpidpZrnhAj0dg/7QecDkVb
         x6aTou74EP13orR6YxBWz5g3kKDERGnUys8/phWxgaLO/mU4LmcecOfH0nQOh4Mxn0
         uZX0mEkanvQd+0ahKogF719tLw7ZpqcrYsTYpNfo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.1145889078762434274.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.1145889078762434274.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.1145889078762434274.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 1e474b28e78897d0d170fab3b28ba683149cb9ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41377609a722fec65f4b0df4e8dc5ea946fb866
Message-Id: <158128082641.31187.1634735421695073234.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:26 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41377609a722fec65f4b0df4e8dc5ea946fb866

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
