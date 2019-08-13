Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57B8C17D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHMTZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 15:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfHMTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:25:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565724307;
        bh=vNQ+joMke2dm7yF3Ggx7RmIRhAahrYe5k3lhvhMoqHI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ST24tBVW3by8A7O9v5VdoRi+7Rz0W3ZBYRr461wtNP1AFosVX/X6/FHfx7I5cgDwq
         OVp0sd/xMSZsdu/TJe7JkF3NKC85EwpBBQy6+d8fsJ2PrH7l1qJ3/p5eU9vSTn2s2S
         BIjKvKmmuNPQ++S4o+nFg04Uplri+4lxFwH2zefo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1565691473.3371.4.camel@HansenPartnership.com>
References: <1565691473.3371.4.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1565691473.3371.4.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: a86c71ba3022331f79662d7f12d1b25188c7e377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60a8db790255a6bebcdc41d97e8084a440398206
Message-Id: <156572430747.27765.2413663810950001658.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Aug 2019 19:25:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Aug 2019 12:17:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60a8db790255a6bebcdc41d97e8084a440398206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
