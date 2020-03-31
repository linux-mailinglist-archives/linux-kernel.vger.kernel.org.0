Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8244198A49
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgCaDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgCaDAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:14 -0400
Subject: Re: [GIT pull] x86/entry for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623614;
        bh=c5nhMy/dBxSV0dLnMqAKVocJn0LoMFAuYlUZ+3vYB6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v4CPAEd6mtpOVP+5atalSm00+ivAx0x+vHBsFyG6Zo4JkNJ8ckbY8Okgz9QdIx97I
         C8P54poDR7ZdFcDR4tx7IMWoCWjKfQ+6x2YKcdNU81Phft9YoiM7lHtiDFL4YJUZEj
         cI6jTOWh0yeQHJZW8fgdhxRp4ckwBVlrPsLhmx8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963437.22376.13314216004420999087.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963437.22376.13314216004420999087.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963437.22376.13314216004420999087.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-entry-2020-03-30
X-PR-Tracked-Commit-Id: 290a4474d019c7e49c186100e157fff5e273ab3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5f744f9a2ac9ca6d5baf72e97ce6dc4c2f19fe4
Message-Id: <158562361438.8590.10677332368375359427.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5f744f9a2ac9ca6d5baf72e97ce6dc4c2f19fe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
