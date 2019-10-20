Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371E0DDE21
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfJTKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 06:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfJTKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:45:06 -0400
Subject: Re: [GIT pull] irq/urgent for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571568306;
        bh=k1OQvqqy7J1bGRYpTHb8nefZ+CCEz1eiQBxiWDbub5Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m2W/jlb2ZWvgidUqGkbBNubxhcvJgqq82RcGcJg77an8MLs+D7qi7e1h0fk8pzxfq
         K0gxyicjOfdOtMj7ohPQbIFMz8sa2x0Ze85IMmYI+MEOfMuhmtDRgbEkct3EKrAcHm
         +v3gQIXKXMA0NQgVy+PixOOmD/Q2bbe75COl3sVY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157156643658.8795.10312616020081094685.tglx@nanos.tec.linutronix.de>
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
 <157156643658.8795.10312616020081094685.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157156643658.8795.10312616020081094685.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: c9b59181c2b09261056757f3f27db2b6c606952f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81c4bc31c4cd6a1e45805604aefd25eee1e72ade
Message-Id: <157156830603.17957.7034279210399332190.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 10:45:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Oct 2019 10:13:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81c4bc31c4cd6a1e45805604aefd25eee1e72ade

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
