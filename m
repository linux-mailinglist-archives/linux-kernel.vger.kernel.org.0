Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4210F1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLBVF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbfLBVFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:23 -0500
Subject: Re: [GIT PULL] Documentation for 5.5, take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320723;
        bh=kb8PGjziUHv/KkDLxOGSoaPrB+6nVxX9CyYMF71QW1M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z7F8UVQKR2fNxj3+sfYocVDCN5vYix494aVuD/BxymCAznbC/+/MZ4vGHGcoAhRFA
         9mg+2TA0DLcqaui9SvllpbIImAAvy4S+n/tE42wtNkzNuBkeYZKrzuRS6jDrm3PbOa
         FrgxkkD+MiOonLAZLDNWS1Pluua4grs3yDoVFaNU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201090945.69c6aa4e@lwn.net>
References: <20191201090945.69c6aa4e@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201090945.69c6aa4e@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.5a
X-PR-Tracked-Commit-Id: 36bb9778fd11173f2dd1484e4f6797365e18c1d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 937d6eefc716a9071f0e3bada19200de1bb9d048
Message-Id: <157532072337.29263.11064952657785957219.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:23 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 09:09:45 -0700:

> git://git.lwn.net/linux.git tags/docs-5.5a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/937d6eefc716a9071f0e3bada19200de1bb9d048

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
