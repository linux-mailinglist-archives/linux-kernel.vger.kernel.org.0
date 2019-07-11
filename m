Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C616610A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 23:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfGKVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 17:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGKVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:10 -0400
Subject: Re: [GIT pull] irq/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879709;
        bh=rEU8Tka+ZBdPXvFQ9I4byC1FkdV2xEecMndijSTEcJ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fw+rPhy9lqPKGRabmTDMJV4CM1bRGYnwV0mz0jWFOKhHpJtZo1ByBTbQlk2Nwlqf5
         NMu2tocbv5GaE8YnzSR3uklAaQ1rKptL+7CudMAHzpQEKwisJsk2fKmaTibGDNp7Ac
         u4Y4PM/apNqxQ8pYRkdZExtqHlfOFgP38Gf2eXQ0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.2782582303624911598.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
 <156287535656.8320.2782582303624911598.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.2782582303624911598.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 20faba848752901de23a4d45a1174d64d2069dde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a83f575a33b960b7b1d582dc17f154d887c9b8d
Message-Id: <156287970974.8575.14741967372446830499.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a83f575a33b960b7b1d582dc17f154d887c9b8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
