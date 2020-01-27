Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AA614A919
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgA0RfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgA0RfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:04 -0500
Subject: Re: [GIT PULL] hwmon updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146504;
        bh=EqnsXRKDVhCWAJpS5T31IP1ElgX8132PdDGv7p6eCg4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=axKDw0AJgR5EDRaS/5u41KkkjAp46Mt04CqIRzekNbg/L+PAA2v1kQiPiHnA0bYwT
         zq7yo03lzQ6hb2z1ZSD/dpa6s1NQHfp47sKbX97//EFEEd+zxs/tmbx+/UDEyfhxJq
         qnaGI5Kk5BtTmizTDpvJoLVYOcvExNpPc4RUmlKE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127005032.25447-1-linux@roeck-us.net>
References: <20200127005032.25447-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127005032.25447-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.6
X-PR-Tracked-Commit-Id: fd8bdb23b91876ac1e624337bb88dc1dcc21d67e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35417d57efaaf06894868a2e8dfcd7b9f31bd0bf
Message-Id: <158014650424.9177.13754819467074734167.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jan 2020 16:50:32 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35417d57efaaf06894868a2e8dfcd7b9f31bd0bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
