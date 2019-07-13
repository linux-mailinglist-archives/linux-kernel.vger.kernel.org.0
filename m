Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5246774D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGMAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 20:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfGMAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:40:15 -0400
Subject: Re: [GIT PULL] dlm updates for 5.3 (second try)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562978414;
        bh=YEdvw8KKPDlfcOiH98l1gke1HwRIqid/SZHdOShcLA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Cvd6uhuDmeUMa/GUb0BDXfAH6iGYFvFRqYYJ1o5D8LsR7QHFTF6GjipeXq/yeoAzK
         5tzvoraa0dVwPekVvIGmqH22+//jqowWOt/7FjE/cOrujhTinShKmlptI7s/3W5Mol
         ZwOIOwpHoLPVp8ETHcDrQJs5YEU9/IMc8xLbflsc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712151844.GA24064@redhat.com>
References: <20190712151844.GA24064@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712151844.GA24064@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3
X-PR-Tracked-Commit-Id: a48f9721e6db74dfbeb8d4a2cd616b20017f4b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964a4eacef67503a1154f7e0a75f52fbdce52022
Message-Id: <156297841464.30815.16194210122331063303.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:40:14 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 10:18:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964a4eacef67503a1154f7e0a75f52fbdce52022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
