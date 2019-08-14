Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EAA8DD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfHNStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:49:08 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.108]:30631 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727558AbfHNStH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:49:07 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 850B584EA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:49:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xyKYhblEQdnCexyKYh25hj; Wed, 14 Aug 2019 13:49:06 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p5hynSMPXMeH82n7jbvD9dJKoFqmmN7YuPALk1OFdaw=; b=uYVSVOcnHoJqxxVQ81EpEL0Ehn
        /H6Eij6gUT9VharDNvklb4dHGu7B4iZZ3EWPFy1OPg3HFrkn+oM2adEA3ETcx/7V1mauczSgXgrK9
        Trqs8xN3s5SPZhJrJ7EUxj2Rjx9Sbr2/QsXdBdGx5RCg1c/TGQnjFfKTtbLkXQwEe6RKSVjE62dOJ
        eCcczBhYbo8Il9JSV5yVOwNkaCRDkVlIFGTxn63Imj0F0wph3b0xx5ox0u/+uQFj6jTE7+n/3Gqgy
        jKR2OVjI4anj/P1mkT+EoJCPWmWG1WLFYnLqj17TYA0JOajkR80reKtOj1InBGmNtnAWe2eSWGP/m
        ghAYGl9Q==;
Received: from [187.192.11.120] (port=38588 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hxyKX-000GEO-8y; Wed, 14 Aug 2019 13:49:05 -0500
Date:   Wed, 14 Aug 2019 13:49:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc5
Message-ID: <20190814184901.GA16709@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hxyKX-000GEO-8y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:38588
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc5

for you to fetch changes up to 1ee1119d184bb06af921b48c3021d921bbd85bac:

  sh: kernel: hw_breakpoint: Fix missing break in switch statement (2019-08-11 16:15:16 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc5

Hi Linus,

Please, pull the following patches that fix sh mainline builds:

 - Fix fall-through warnings in sh.
 - Fix missing break bug (a 10-year-old bug) in sh. This
   fix is tagged for stable.

Currently, mainline builds for sh are broken. These patches fix that.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      sh: kernel: disassemble: Mark expected switch fall-throughs
      sh: kernel: hw_breakpoint: Fix missing break in switch statement

 arch/sh/kernel/disassemble.c   | 5 ++---
 arch/sh/kernel/hw_breakpoint.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)
