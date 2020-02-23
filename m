Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEE16956E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBWCzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 21:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgBWCzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:55:11 -0500
Subject: Re: [GIT pull] x86 fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582426511;
        bh=RkDBUYFIyhRffUTVNMeFmrZN8lu2EqJFsPa6pf4VE8Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sGQPkOKaUDt8lIbstZRjJqzAiI7CmAqJXhHuar/P4q9FMq69YTDH1vdNur/bpyjIo
         JJksqo71vB9Jxbl+q9hqnjxt2/HRHhCIZ+5xOtboUf1VuOI5fD9WTK45gseuMEOtDd
         AjzePyvA0f+vSo+haK0LdY4u3zq1+mDYs4JiI9B4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158240520445.852.1076310115215713264.tglx@nanos.tec.linutronix.de>
References: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
 <158240520445.852.1076310115215713264.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158240520445.852.1076310115215713264.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-02-22
X-PR-Tracked-Commit-Id: 21b5ee59ef18e27d85810584caf1f7ddc705ea83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fca1037864a9fb75c9c48cb65649b24de8101ec4
Message-Id: <158242651109.13467.11705356658538719038.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Feb 2020 02:55:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 21:00:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fca1037864a9fb75c9c48cb65649b24de8101ec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
