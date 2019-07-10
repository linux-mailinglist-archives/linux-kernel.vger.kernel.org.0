Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1D629AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbfGHTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404594AbfGHTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:12 -0400
Subject: Re: [GIT pull] timers/core for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614211;
        bh=157IR3Ufg3JWiy76+X0flX86REcLyOxGD6q28vdEHcA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S19IcaUpudgUzUx5yG5Whizx9Of1p0l7v4FRZEfZHcz+Z02lCaekf3zWhg/oKeRrv
         YCPjgdZzXfimdc130Dt0nY1fHr8WiS2rmppBEeWcOVfniDQKku1h0LlfNdmxiLwuPe
         ZJOMSyQBOh7T1/FDr430tUomabs2HmcSVI0o+KI8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673795.14831.1793413220192426712.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673795.14831.1793413220192426712.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673795.14831.1793413220192426712.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-for-linus
X-PR-Tracked-Commit-Id: 9176ab1b848059a0cd9caf39f0cebaa1b7ec5ec2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 927ba67a63c72ee87d655e30183d1576c3717d3e
Message-Id: <156261421128.31351.1099659926507403790.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/927ba67a63c72ee87d655e30183d1576c3717d3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
