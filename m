Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED7198A46
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgCaDAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbgCaDAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:18 -0400
Subject: Re: [GIT pull] x86/timers for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623617;
        bh=683VXuHAXDiRDZYb0vlK4a/r5inl3sDh5Auqan02+DU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KjDj5rp5P6cbRq7ul1MhPH45yNKWcde2hkkdu6nhaWwY/onqEOx7kfrXGRTKTqlCN
         ERQuZHxlUaSXc1eJiGMfAuF0+SOjLongpu3a0cmR3U5PtNZmY23v2bQy3X/rhIP71t
         HsfnrpoFDU0B7dnB9n/8vGUiMjecWb61c0NWVrtE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963678.22376.17697748296819329736.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963678.22376.17697748296819329736.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963678.22376.17697748296819329736.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-2020-03-30
X-PR-Tracked-Commit-Id: fac01d11722c92a186b27ee26cd429a8066adfb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 458ef2a25e0cbdc216012aa2b9cf549d64133b08
Message-Id: <158562361778.8590.4529324346808786877.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:16 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/458ef2a25e0cbdc216012aa2b9cf549d64133b08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
