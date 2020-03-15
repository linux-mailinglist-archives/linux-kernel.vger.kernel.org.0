Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47253185FC1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgCOUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgCOUZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:08 -0400
Subject: Re: [GIT pull] locking/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303907;
        bh=BwhigM3mFQHoTviqH0a1FWPCxvdMM2n6SB3UmQwwYjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wkQQt1t7z1yaYYqiL4ruvfHeBnVJTnWVe9CtT6ug3tl/9mcH5U//0svxw//cxDaJx
         heM0F3iiT0xZ/Ig3kJnZsupckTvif8FNqYWlWOe/Ai1u3NJMC1ZGVoyvS7fPmofpLd
         jlop6savwnEl4pZ28ph1fPGyl0TZnR9S72Ca82Eg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527863.14940.9797858854219279483.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527863.14940.9797858854219279483.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527863.14940.9797858854219279483.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-2020-03-15
X-PR-Tracked-Commit-Id: 8d67743653dce5a0e7aa500fcccb237cde7ad88e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34d5a4b336e7e4c247d532a841d05367357197f8
Message-Id: <158430390779.13594.11806272851008408427.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34d5a4b336e7e4c247d532a841d05367357197f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
