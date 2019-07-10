Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEFA629AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404670AbfGHTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404554AbfGHTaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:08 -0400
Subject: Re: [GIT pull] x86/fpu for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614207;
        bh=R1uTvBlQFqS+jGsnH+YkyDSG4zvRalJO3U4z90UyZh0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XowKL2M+K2eSCzBN0nbOFDgWYW7yizQK4sAXXB9A2JtkVAcYQqAUdimzojivMil+L
         eOma1afXWv1dkbG4jOPB3MYBFhlqauwhOpuJBw1/McwvWrmjlP/KIiAD3HauYaMh0n
         eq8S4WCOzp2VWEkf9JKL6Qx8Vk3SJZc+geiMcWeg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.15725585116804363393.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.15725585116804363393.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.15725585116804363393.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: 7891bc0ab739a31538b5f879a523232b8b07a0d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab2486a9ee3243c8342549f58a13cdfa9abb497a
Message-Id: <156261420721.31351.3443791631624541343.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab2486a9ee3243c8342549f58a13cdfa9abb497a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
