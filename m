Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C71ED06B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 20:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKBTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 15:36:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45963 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKBTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 15:36:38 -0400
Received: by mail-io1-f68.google.com with SMTP id s17so14335289iol.12;
        Sat, 02 Nov 2019 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=j9sn2mRAsDCQ6+VU7UlCupqMoFKLj6Ys+TMlg5SaVxY=;
        b=BUAOjXEYCk+CjX8+RBLHNnOXet5x2qd3zrsZV+r9msUYPqdbUBhnPK98TuDdOyn9TB
         MXlfVNlvbUHKJhI62sarw+IL9qMRrKv8j7fDsEOqIWBu0g4ejfJVzJWLqiBG7HfN5Idt
         hoLcn6U5KYwVrxZrDtc9E7sbLY41ZU2chI5fMfYQYIl7/f4b8MMOMLuCgXk4btKKCEs9
         H1YbXjHB1mSEnQTKWiS3tKEI5iSmerUGFhsVHpAeU39Qvw4/Aw37jjNyceLXHWP6sUMv
         LgJKH0aXzxGyU8CmnIPMgdK6ctx/lweywFpAnjQL8qYEuXs1ibBCi7fiuZbny5ROMM0E
         WZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j9sn2mRAsDCQ6+VU7UlCupqMoFKLj6Ys+TMlg5SaVxY=;
        b=WGP9CxAVwVS+tBPEryyU/kW4rsEOKe89TaCfKu9omgBgF2brpJSSZj2VAQGdy57+QF
         ANM5gafM7qtMsneBJSOwmeb5KOZFsHe37okLf637uiQXPfRM2fn9dXVSO2ikaspIoF0F
         YXCVm8iYhihL6HReuhaYmfRg7lKBWcSNWcwpTKpkZDbVDVszxz/Q/4sRnz5xXvgTVwWP
         YyVDjgSju7+372dUJHzO5m4F95oMpFX0oXo9o/mmR5jn68XVNoJS485GG4Nu0TMa0ZXz
         NOcqxfQeZrMQZEJAoesqjn/malCp3vCTo4we5rSu7EUzS6PLuHqgGSDm0oLlqkRj3Hff
         p6xg==
X-Gm-Message-State: APjAAAUUOzgM5mNupdcQbTXLFSqHjVltHZklQTABQoJCUbDHDTkNLXE+
        7zKqL5YjyCRDhEd2hw8yKorMvXEFL6MTf2IVFylkcMBp
X-Google-Smtp-Source: APXvYqxiuan+muqG76TGyIOdqdhVktM12bDwKcTn3yQFaY/muF1n60xImUC0kFw/Lf+x8TSNBfwASDgLhjKEWUY6fWc=
X-Received: by 2002:a6b:fa12:: with SMTP id p18mr16363593ioh.272.1572723396149;
 Sat, 02 Nov 2019 12:36:36 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 2 Nov 2019 14:36:25 -0500
Message-ID: <CAH2r5mt+UYbU6=K4f_5FQLuDH2fJHwWhGKVGW3wzX-UYDcLMww@mail.gmail.com>
Subject: [GIT PULL] SMB3 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.4-rc6-smb3-fix

for you to fetch changes up to a08d897bc04f23c608dadde5c31ef194911e78bb:

  fix memory leak in large read decrypt offload (2019-10-27 14:36:11 -0500)

----------------------------------------------------------------
a small smb3 memleak fix

----------------------------------------------------------------
Steve French (1):
      fix memory leak in large read decrypt offload

 fs/cifs/smb2ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


--
Thanks,

Steve
