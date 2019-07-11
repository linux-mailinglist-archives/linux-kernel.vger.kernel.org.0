Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F006666108
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfGKVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 17:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfGKVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:10 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879709;
        bh=QzqTToCEYlK6lU/RhUacu+dYATy2MaCFB0ifmBkKeSM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oj+y/CnrYq4EcFFLKF9l9NrPn2M+sRj2ojf5pH781uyuRJ7CrQAUAYLJL/VAv+fUL
         RliQr6zNrsp1lrtYwANg1wA/QQhdnAsWVHxyPMwnd6iwk7otdS21vf3mKrol0wT+43
         eVlef/Y4hG7+Fz305QdVQAPbazA6qnKBRTV/Qs/A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.9936716199898120027.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
 <156287535656.8320.9936716199898120027.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.9936716199898120027.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: cbf5b73d162b22e044fe0b7d51dcaa33be065253
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 753c8d9b7d81206bb5d011b28abe829d364b028e
Message-Id: <156287970908.8575.16978677164387319719.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/753c8d9b7d81206bb5d011b28abe829d364b028e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
