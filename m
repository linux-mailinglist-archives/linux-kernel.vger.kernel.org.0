Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF61360EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAITR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgAITR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:17:26 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578597307;
        bh=xgijvTkewxtHJTvruQidXzNftFoGIOfZMNR2GwYO8hU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1s8IKAMhbf08t4hT1dkrpBBut5VVQvR8jx1DENpyaRv+g6pYaB82DOUEDwHE6nMJ6
         LFSK63LwTBq1iGrGTO0yM/AdG9Pm6SqAdDNIRdtK5/5pY8sYq3hP+AIYcDpfXtpbZU
         ZoSvBoE8Wvh4+PZSBRuDBd7TtL+Ws20bfu8M17Vg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 20eee6e5af35d9586774e80b6e0b1850e7cc9899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e69ec487b2c7c82ef99b4b15122f58a2a99289a3
Message-Id: <157859730696.26179.16266411918607310032.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jan 2020 19:15:06 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Jan 2020 15:23:09 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e69ec487b2c7c82ef99b4b15122f58a2a99289a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
