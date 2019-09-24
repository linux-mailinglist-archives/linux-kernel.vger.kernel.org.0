Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE767BC04B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 04:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394439AbfIXCp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 22:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXCp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:45:26 -0400
Subject: Re: [GIT PULL] MFD for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569293126;
        bh=kiMHv4EzKPXILofZb8wTlzddTjuhxLOOlAcmf8tWLFI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GufTxB7nJGMSYaw+rThGxkiPo+V6YJjUgYfP6as6ZjqFWQuncpkoBjKPh1IdPvQpu
         lAc3zJqTzpsR8W9OW9wBpXkC6K/G3XFQdnYrhBPoM6MEjZGxCb/N1pEVWxytQrJFdO
         yf/zwg0CflG4mNViWFivqSBwRoIA5EPmJQPPdIJs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923230848.GB4469@dell>
References: <20190923230848.GB4469@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923230848.GB4469@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.4
X-PR-Tracked-Commit-Id: 8391c6cb2414d9a75bbe247a838d28cb0cee77ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc
Message-Id: <156929312599.18533.6374651945533731208.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 02:45:25 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 00:08:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
