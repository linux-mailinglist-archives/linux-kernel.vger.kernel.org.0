Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1534E4DEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 04:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfFUCCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 22:02:30 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41170 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUCC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:02:29 -0400
Received: by mail-pl1-f174.google.com with SMTP id m7so2175739pls.8;
        Thu, 20 Jun 2019 19:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AFbwO1jRWsTAtt+9IaHJiWngndRjDQJcqp5XdbdyL9c=;
        b=oFXKiLs5n7lKspuTkAaWLLELjdDJ05lR+og05o+2JWm6qdJ21lGCPLldXBScr73oSb
         8mmJ6e/KVdhYsr92qhChbRWTwnr0xWthRb8VcJFD9hy6LiFeenm/zsqaLSXvtGYL7ix9
         9xPedkhjbv+N7aj7otuf+5iBwUWdhxi66D0Nm/As5hP8EyV3UpJbWDyVtOM5/RAnxYFC
         x584WlNZbmJx6WQE9RvjcFFrqrhHa5mv77ppprq1d2sRDH0BVyTPew60i70f1mWHUG3V
         PbzRkJ48skGpBa0ix+PPBuG2dxRz4zCDeW8BYcCSDDTN28g9Raeu+aNDd9thIDSNoDM5
         Q6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AFbwO1jRWsTAtt+9IaHJiWngndRjDQJcqp5XdbdyL9c=;
        b=mZpUy/xzdLirrhLNURV6ZAHHPhV1vnw+ZGJDinnwX/w72tUvxutq/hEnFUwXjh8aGk
         +JOtzWv/sDDk80UiQjdP2QB9x4uGTknRc/K4wqOwdjEmdvM1ZTv/hs7lwAdsX/6jYkkt
         7PJYGN7cklXv8+BwFjC4uKypI0lcfM/7Uo2rHeZpdWkMnXZttmywqHTY3zvT2U2Us8fw
         Zd1iPfY4zz08HmApQskTBQyElASFV4a8tbyabz1q9v41Q6c2anXlm619YRr9C6t7FuW5
         hzlRcQ3nJsEKEuHCsmJ2o9bFrMlvPzoHuf4VIp6wi/EvoXSaNJMqp4czz+TK9vxnEMdH
         oSvw==
X-Gm-Message-State: APjAAAUBCbhPQ5HwMd0UjBFe2OmPQV91Oo+3HetziiI85KeMrAm/Iq63
        4e904gcGOi7o2QPFLP0en/4FZiz2tv/V1bnaLd+KURJW
X-Google-Smtp-Source: APXvYqw7ZS313aQoPl3UNEXrrZv4QR3g7b5hu7+ak7QYDfVbs5TFSuSKSWeqh7Qk49/33PMIJ6j0gtEkcLouScdbJ5Y=
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr5516036plo.78.1561082548472;
 Thu, 20 Jun 2019 19:02:28 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 20 Jun 2019 21:02:17 -0500
Message-ID: <CAH2r5mumke0cYEdt3nCsmWmqgUcShYFMy6UacMnAuKcER4RNSQ@mail.gmail.com>
Subject: [GIT PULL] SMB3 Fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-rc5-smb3-fixes

for you to fetch changes up to 61cabc7b0a5cf0d3c532cfa96594c801743fe7f6:

  cifs: fix GlobalMid_Lock bug in cifs_reconnect (2019-06-17 16:27:02 -0500)

----------------------------------------------------------------
four small SMB3 fixes, all for stable

----------------------------------------------------------------
Ronnie Sahlberg (3):
      cifs: fix panic in smb2_reconnect
      cifs: add spinlock for the openFileList to cifsInodeInfo
      cifs: fix GlobalMid_Lock bug in cifs_reconnect

Steve French (1):
      SMB3: retry on STATUS_INSUFFICIENT_RESOURCES instead of failing write

 fs/cifs/cifsfs.c       |  1 +
 fs/cifs/cifsglob.h     |  5 +++++
 fs/cifs/connect.c      |  2 ++
 fs/cifs/file.c         |  8 ++++++--
 fs/cifs/smb2maperror.c |  2 +-
 fs/cifs/smb2pdu.c      | 10 +++++++++-
 6 files changed, 24 insertions(+), 4 deletions(-)


-- 
Thanks,

Steve
