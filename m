Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3310E4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 03:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLBCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 21:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfLBCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:20 -0500
Subject: Re: [GIT PULL] HID for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255019;
        bh=l4B1IX37UfFkU4Lb+WAAtoxHXkuqE1hcn7fuCgG9yD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ACtqT/s2fpBz7MiMt8X6FaKHWlEzaYp3zlScyW24X6OANHzRSDEc0nQiCESExA3B1
         ZIiAauUW5C1FyiD0mw+UMrG2sTks/xsixKojUOMFWaXIE+t6fn9Vpuj5M4ZNyYg0by
         +XKU8fmvvpZRnNf6t/RmIH7NtB34pJdw60s/LxHw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1911292041280.1799@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1911292041280.1799@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1911292041280.1799@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: d8d0470875aad437053b6743ef24eb9bd72d9789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d004701d1cc5a036b1f2dec34dd5973064c72eab
Message-Id: <157525501979.1709.16385122795756212111.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:19 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 20:46:49 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d004701d1cc5a036b1f2dec34dd5973064c72eab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
