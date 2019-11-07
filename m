Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1EF3915
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 21:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKGUAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 15:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfKGUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:00:05 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573156804;
        bh=jsI7hVeXFWR6bfSlxcDGJ3w8pusWGXX2IT9iMl4+uRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hYWLxR7VMbt33ZP64R4ZprjgML41Amk9w3rps1Grb47K/wlZd14ndSqdDGu20W8vw
         bIL/khiPnZTskyJ7uoZwUbuGsbe3lexkXEjjNiaHugpJ6AOTS11lLvGfT75EVO4KJ3
         vxt8MvJnEFDvePzZnymhUShckPiZleERtAu6YPyU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1911072028330.1799@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1911072028330.1799@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1911072028330.1799@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: ff479731c3859609530416a18ddb3db5db019b66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 847120f859cc45e074204f4cf33c8df069306eb2
Message-Id: <157315680484.5666.1121786146617338722.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Nov 2019 20:00:04 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Nov 2019 20:32:00 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/847120f859cc45e074204f4cf33c8df069306eb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
