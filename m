Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586FF168FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEGRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEGRUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:07 -0400
Subject: Re: [GIT PULL] HID for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249606;
        bh=r655pN5fozXnGz64v9/ltLkTFF7ZA/0LxeNPU/6u6fk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=voBI5q1ht2pg2hKa0ycy3H9L5nr5g5U1znZ3UE3OoRr2Fd1fKDNuQEO6Zo2Jy6qLH
         +jnfiJf6mQXFjxbSGV7zygAXyOoDE4Nqg/IlVyLR4l6JEokXHhMGa9sA3uzuxHC1g4
         MGyUOfDbnC0GMxHG6gA1kerzmUwdU/dIgqy445WY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1905061547380.17054@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 63b6f0b827d6b40e53bac5abc8150fa117d27bec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4dd05dee0dbd16afdbba83b698a7110c687be2d
Message-Id: <155724960515.23705.13002310109191380642.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 16:03:43 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4dd05dee0dbd16afdbba83b698a7110c687be2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
