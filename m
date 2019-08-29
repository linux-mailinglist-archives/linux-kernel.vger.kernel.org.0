Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529D1A210F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfH2Qhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 12:37:31 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.142]:15633 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbfH2Qh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:37:29 -0400
X-Greylist: delayed 1248 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 12:37:29 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 4E416D8A8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:16:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 3N6HivFfKiQer3N6HiEaum; Thu, 29 Aug 2019 11:16:41 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a8rjYnS9SnAenydNSMbeP8fAIqWeMKJbCEld4zbuKyg=; b=YImsHoaEb57QrRDBGNkDwNiQe5
        PedtbVNWm+ldbhzT28tPDkRUQraLKZRWq0FUMOBqH8ESqnz523rUVD4RTTgoOeI0TE84OH8uL3JKf
        fEh+Smm39COP1uXgd3b0jbnoSdt5/pmQEWOGTxRPKQIqgrSLNMgky+OcYMmfj9yrma9s9WCly1nEI
        7pOQFTG7zgaD4PrUUFrayejnzUZbFumDuxOZ50RY5BxqM8sq+byD78+ZRAQICVAjJZEHVpXlEZa1Y
        A6TnFZ3tNB4HTdqJlxlV91cblQACupkDMmgDT2RF+7M1gD+LK1ioLWro27mjP6C7ZiCyqP5du1OYo
        WyylJQPg==;
Received: from [189.152.216.116] (port=37814 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@linux.embeddedor.com>)
        id 1i3N6F-000Bs2-VY; Thu, 29 Aug 2019 11:16:40 -0500
Date:   Thu, 29 Aug 2019 11:16:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@linux.embeddedor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc7
Message-ID: <20190829161639.GA18147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linux.embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i3N6F-000Bs2-VY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:37814
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc7

for you to fetch changes up to 7c9eb2dbd770b7c9980d5839dd305a70fbc5df67:

  nds32: Mark expected switch fall-throughs (2019-08-29 11:06:56 -0500)

----------------------------------------------------------------
Wimplicit-fallthrough patches for 5.3-rc7

Hi Linus,

Please, pull the following patches that mark switch cases where we are
expecting to fall through.

 - Fix fall-through warnings on arc and nds32 for multiple
   configurations.

Thanks

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

----------------------------------------------------------------
Gustavo A. R. Silva (2):
      ARC: unwind: Mark expected switch fall-through
      nds32: Mark expected switch fall-throughs

 arch/arc/kernel/unwind.c     | 1 +
 arch/nds32/kernel/signal.c   | 2 ++
 include/math-emu/op-common.h | 5 +++++
 3 files changed, 8 insertions(+)
