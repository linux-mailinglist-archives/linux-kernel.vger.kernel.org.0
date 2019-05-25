Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3432A22C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 02:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEYAzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 20:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfEYAzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:55:18 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558745717;
        bh=6vz8ToqiAo8y+Q9DRK5b5As4iQxOqglcI8455fzgkaQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ldMJaqDwIdIGC9+XiMwxLdMgjUnEl8XJ8HlvX0lKMoKUbhE/QUYLPY+5by2hkrfzA
         7CllnQ63Qea4JVRNYGY41kHG6X4kB1OXh/N+8GY+GChlNwsqlG+EKoiNE1e+meZ/Vs
         N8EnRccmmt9jC3pFYx0j8u21Qc21nl7IZlGhWvQM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1558739503.3235.58.camel@HansenPartnership.com>
References: <1558739503.3235.58.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1558739503.3235.58.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 8acf608e602f6ec38b7cc37b04c80f1ce9a1a6cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2409207a73cc8e4aff75ceccf6fe5c3ce4d391bc
Message-Id: <155874571757.25799.10363647256514675305.pr-tracker-bot@kernel.org>
Date:   Sat, 25 May 2019 00:55:17 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 16:11:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2409207a73cc8e4aff75ceccf6fe5c3ce4d391bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
