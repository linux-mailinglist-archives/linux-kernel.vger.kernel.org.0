Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C681BE576D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfJZAPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 20:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJZAPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:15:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572048906;
        bh=rQC4XbYrMqWWLZagDoNm9vQ3zG6j/t/yzJaiF+YNkC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0+FQOBIVRNAuNrKJYALL9EWAZnHNWKWmd3G2ad4z6kHBl7k+JuG8bqynDwRQ+9EUc
         FD5PAogLNRHrZFFqm1xiTAwwWDj2wYmU5H23xgq+g2UJJ+znwrn8qFMluE5VbVR3mt
         9vHDrq51KDCrb6k2df/uEgZ8D4yvGrS5B2a0vHxY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1572042507.11722.5.camel@HansenPartnership.com>
References: <1572042507.11722.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1572042507.11722.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1052b41b25cbadcb85ff04c3b46663e21168dd3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c4e395cf7ded47f33084865cbe2357cdbe4fd07
Message-Id: <157204890677.31513.8706891859222082329.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 00:15:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 15:28:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c4e395cf7ded47f33084865cbe2357cdbe4fd07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
