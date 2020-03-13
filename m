Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB38185272
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCMXpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 19:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMXpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:45:08 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584143107;
        bh=Kxau0moSAMYSWiLcpmT3YowaPzatf5NFeuKADxdAf2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1cgSFqo2oAgVAq8LFQXigb2JPX3MOKB3jSzs7ahKTZ9h/7im7bawJdiCNAI16Wk6j
         9JDccKFZEWdytAg73zJMqY7d2e+wZnWDulT/BzzeY19utGgX0W+009EU1HThPjW4Zz
         /m+hQlPvcYCzqV83mDzNrUzxA+Pk5p9Xzn2Gws2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1584141787.20167.3.camel@HansenPartnership.com>
References: <1584141787.20167.3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1584141787.20167.3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 394b61711f3ce33f75bf70a3e22938464a13b3ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fffb08b37df928475fef9c7f2aafddc2f6ebfaf4
Message-Id: <158414310781.22111.18203643165756736516.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 23:45:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 16:23:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fffb08b37df928475fef9c7f2aafddc2f6ebfaf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
