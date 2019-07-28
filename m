Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2718977E18
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 07:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfG1FAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 01:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfG1FAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:23 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290022;
        bh=9vHIEX/HP3w7SZRgfGUMAW/ipa2bxSzdCa4/ZUUFQPQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bl+2zKHRM/qzQHe+/ph5o/5TUy1GtoemQmvKER6jOTfN9R4KFc2vszqKaJXt1KLmD
         1dnYmh2OMXLfCLKFiGJfokWzoSRfaSU5vJFyawVmxzsVKnHoV/vdO2m4gEfeOb2BbW
         D8RbtNftZ2NmlmN4VXG8pG4j5Otw22J+JKZ/TskE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
 <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 289a2d22b5b611d85030795802a710e9f520df29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750991f9af5b4019fd0232c23a4815682ff91021
Message-Id: <156429002231.32180.16977131787063752082.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750991f9af5b4019fd0232c23a4815682ff91021

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
