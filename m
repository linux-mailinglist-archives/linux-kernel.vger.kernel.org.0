Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA7138198
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgAKOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgAKOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:10 -0500
Subject: Re: [GIT PULL] HID fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753910;
        bh=1XBJySitFGv3NCeUviFXxskLZAXGqGoSYgd2XutTIR0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=btgxChZnDWqzU+q7dCNtfOS8CP4ZN8eUNRTPuzeCkgBCGaH0cLNqpSVPeEuONMYfH
         UP0y4+9Gzvi29KbvDExOufV6ammrs/xixYVYxG47rqCJysJ4y6I7c6orN2V4G2GaO+
         UENEFB6g+x/9KIijQYbMIDGXjUYIp/tCtdpl5JZc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 9e635c2851df6caee651e589fbf937b637973c91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac61145a725ab0411c5f8ed9aeca6202076ecfd8
Message-Id: <157875391003.30634.6168670234232946731.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:10 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:32:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac61145a725ab0411c5f8ed9aeca6202076ecfd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
