Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92FB198A45
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgCaDAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgCaDAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:16 -0400
Subject: Re: [GIT pull] timers/core for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623615;
        bh=U/niPiTlmh1V2CH8iONH4nINBRchEsU1497pngEtEaU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CNeJlzg+julyfZGkt9w5k8LC6TaEKoMXJn0ixfCqevRrhnT5mfHJB1BzK8ChatnGD
         lINf3TiwFA8HXu0n5/DP5IUxXndq50FAJFYJQoreOH/ij4pT5RX42vGtUTp1qSRMMv
         tF4K0Di0sZ1MBYp2vBGQ4q8bSWSzIjFp6N5oTN/k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963196.22376.689294297633133960.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963196.22376.689294297633133960.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963196.22376.689294297633133960.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-2020-03-30
X-PR-Tracked-Commit-Id: 4479730e9263befbb9ce9563a09563db2acb8f7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbb381b619aa5242c9cb1a8fd54d71c4d79c91eb
Message-Id: <158562361584.8590.17501828399630127575.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:15 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:11 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbb381b619aa5242c9cb1a8fd54d71c4d79c91eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
