Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E214219A1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbgCaWPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 18:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgCaWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:15:14 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585692913;
        bh=ne016EYcgo1BXB4ktHvGk1kdHTYidGrFCVPBwbZwbUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hssACP7P+gxAmwonGyrElO683ewcOAIawNRPc9mdqmkyOlfmSLmna73k8sjvp3GSa
         k4JQfTbP1n3zZwOKsuVtmU3FkaBY2S5gfqA78IU2Gb4S3/dQzQIhGpx6dnI7l9RpXq
         vNVmvANnOiZqB4XZQvAHDLHRSjt1cXeTOu4gtZvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
References: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQoqpqiFncTP1w0+--hGTwcm57LXgrXVsGnNqcRSof1WA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200330
X-PR-Tracked-Commit-Id: c753924b628551564b6eea3c9896e4a95aa25ed9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3aa112d57b704441143d84b0475fb633a750035
Message-Id: <158569291347.4579.3524814433990268929.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 22:15:13 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 20:38:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200330

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3aa112d57b704441143d84b0475fb633a750035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
