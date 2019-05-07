Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E133D168FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEGRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEGRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:05 -0400
Subject: Re: [GIT PULL] printk for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249604;
        bh=MqL5PlmTIm3uLQu5xMhwJ2JsgU9dbIrVLcDeCaL9cX8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VKPET5DDmL/mydiHqeVseW6b4WHIp/Qx+HIidIAwmDRFNcRCES6ymWPuDiSxRbEBa
         dgm/OugVjRCntzd31ylDtRAzPbdYOINKXQ2hiUMAY+y9k3isOzkauUoeg8lWAqSjHA
         MXgjYUojvelJ23zHAVjag0RXLxIQq6DldoXjOHzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506105505.asfh2spqa4qairng@pathway.suse.cz>
References: <20190506105505.asfh2spqa4qairng@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506105505.asfh2spqa4qairng@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.2
X-PR-Tracked-Commit-Id: 0f46c78391e1348fe45af86a0cd52795726695af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0968621917add2e0d60c8fbc4e24c670cb14319c
Message-Id: <155724960460.23705.15983415274957364091.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:04 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:55:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0968621917add2e0d60c8fbc4e24c670cb14319c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
