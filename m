Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9166F058
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGTSkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfGTSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:24 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.2+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648024;
        bh=MKlP6dDSV8abusWQpcYec7uQjtl5PPanksZXTNzX9IQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xSY1wzhRKXNR7nbRJP+8PKsfD4LFgVHi1qceREikAwlXLJyop65eC7Cej3412IlCZ
         Y7gPL6EbE4TITT2WvKYkaJUBed68fQY1BfmnDcqC5vQVd5MorVpJq27ju9rcxSQXg2
         /jdgzCzLIx+erUvJKUM83NaOTlXB1jgMSqmUTErM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1563579201.1602.7.camel@HansenPartnership.com>
References: <1563579201.1602.7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1563579201.1602.7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 07d9aa14346489d6facae5777ceb267a1dcadbc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f65420df914a85e33b2c8b1cab310858b2abb7c0
Message-Id: <156364802413.20023.10699674701293879168.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:24 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 08:33:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f65420df914a85e33b2c8b1cab310858b2abb7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
