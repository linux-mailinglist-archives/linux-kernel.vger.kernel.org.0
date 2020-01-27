Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9814A914
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgA0RfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgA0RfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:05 -0500
Subject: Re: [GIT PULL] m68k updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146504;
        bh=AmfVE4V8tGDC8S23WoS+eywZvpCJjXRP5KDuglGSH9I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=huF5d6OtpG4Xu0++NSlbIQA4Obb52FB4TNan7Ypgs1MKQ5CDB32kCC55yRYHUkVaO
         pwrEnUHJJ2I0ibfFmBJcGAgfZlx17PIfwRNGTJBcfr0hEt3E1J8oB+thDDFV0b8DCB
         gswXL0UXNTmv7MqknAvW1qVXxdT6d/JLAiZYGDb4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127095410.3611-1-geert@linux-m68k.org>
References: <20200127095410.3611-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127095410.3611-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.6-tag1
X-PR-Tracked-Commit-Id: 6aabc1facdb24e837cfea755ba46a6be22a8860f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f11ba7de156558ac5e78e285dbf9e9af60ceb2a8
Message-Id: <158014650473.9177.2184027400030400580.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:04 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 10:54:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.6-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f11ba7de156558ac5e78e285dbf9e9af60ceb2a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
