Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9282CE7347
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfJ1OFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfJ1OFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:05:06 -0400
Subject: Re: [GIT PULL] HID fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572271505;
        bh=tQvXaDIwCIcYHfDA7yN+FUhesHg5CVQrJJveO1spFxI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oXyAM1INC+6Iw96BQWkJGilMJ/A1qXAH/T5Ql/xUvtJbqmwo047l/pD2k0/peBL+m
         WaTqqDTwTRDYU7QUX809hAY2e3b0kX5EMGTJ7BVaBUiCst/oqLRzkp+V52nSU0Lmzn
         Z4hMcfj3RhYZkxLcVRI+cnUXb2fnOSwVvu2XIjAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 09f3dbe474735df13dd8a66d3d1231048d9b373f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0365fb6baeb1ebefbbdad9e3f48bab9b3ccb8df3
Message-Id: <157227150551.11779.13715501880943537881.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Oct 2019 14:05:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Oct 2019 14:17:53 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0365fb6baeb1ebefbbdad9e3f48bab9b3ccb8df3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
