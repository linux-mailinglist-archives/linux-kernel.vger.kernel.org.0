Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27512BC2F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 02:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfL1BuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 20:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfL1BuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:50:07 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577497807;
        bh=gX2uSCF/FJcgkN9bHzL3GcCgh2erjkE5svBOCnK2A7U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PvFuaL46XiPgAGpO/eyWmvr/q2odrPd5cnsI0KAfEOzI0dcATQ1ULOiO4Fxck1Ejm
         F6ADry4EBfPe8o0wREjNUydKpQQp8eXvkQk/H7WJL58nLAGHH3Q/EBeI1tqw1TFqlK
         iUJxPT1S/0M6PtmE3RL0h7jHBiTFNPFAlQQlvFHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1577487428.3225.6.camel@HansenPartnership.com>
References: <1577487428.3225.6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1577487428.3225.6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: e4dc9a4c31fe10d1751c542702afc85be8a5c56a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf8d1cd4386535004c4afe7f03d37f9864c9940e
Message-Id: <157749780714.14322.9215059600125703568.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Dec 2019 01:50:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Dec 2019 14:57:08 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf8d1cd4386535004c4afe7f03d37f9864c9940e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
