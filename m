Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302089C596
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 20:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfHYSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 14:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbfHYSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:45:08 -0400
Subject: Re: [GIT PULL] UML fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566758707;
        bh=L75zu3z7BrzP6ONcgSvhorpHOCnujJ6am1fME82Vo/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sVQ6pbD+ii7sxgvWb3kwItDiov4Go0ircCw3Ht0FQsFXPkcs2eBTHHPuoKeHN90i+
         xjcsYxESGsPzAvEuiNWc8oAYXRXyfWeoOeFiHJk4HUomdsXpK17pgN3nR4k+/6K161
         ikW71Sp/hrRT3eH5eItqC6LlnAtup+v+OdvXOao4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1911490926.73826.1566741715800.JavaMail.zimbra@nod.at>
References: <1911490926.73826.1566741715800.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1911490926.73826.1566741715800.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.3-rc6
X-PR-Tracked-Commit-Id: e0917f879536cbf57367429d084775d8224c986c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32ae83ffec6373c226d177bdbbbb156962cc638e
Message-Id: <156675870739.26029.6141227322739942733.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 18:45:07 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 16:01:55 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32ae83ffec6373c226d177bdbbbb156962cc638e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
