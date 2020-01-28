Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79414ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgA1BfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgA1BfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:05 -0500
Subject: Re: [GIT pull] core/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175305;
        bh=Hjr3d3h5whnBYsBHWzM5u9bma3tcCMAjnwIA35fyCRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TWhhngjnpmpbid4PuLoBg+i86KmFvVglucsOwlrWIHS+jQKqQxls8GFqimzKugcxe
         pbpTxnpUPbMnRQ9eLMpMkmtsZQr5w8NjKwRI6zsKtSxURUIG4kd/Ye/Yt5btGWiwFj
         hcXApLKzrIFmfqgp0q4toGc6He3i/VYbtAz0MSUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.11649925452756898441.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-core-2020-01-28
X-PR-Tracked-Commit-Id: 11e31f608b499f044f24b20be73f1dcab3e43f8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b11c89a158f29a9b9d740f8f60b74f261ce6557f
Message-Id: <158017530523.6677.14792144326908583718.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b11c89a158f29a9b9d740f8f60b74f261ce6557f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
