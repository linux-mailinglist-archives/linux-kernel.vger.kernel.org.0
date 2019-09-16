Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB83EB3A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfIPMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:39:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40336 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfIPMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:39:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so15983508wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D14i7QtQU4tmrbV4RjMKZgzmDz+Ft+nw2c4RKjJNbQ4=;
        b=JW/BtT7w13DEaJu31hH0n9bnEBYehpdkUPhkJEvtkAya/+JYiXCOvdJcCo7JpziID0
         1ftrAOunqLHvMvQTrsamfLuI2jk+iOnjJd2FUylqADMUeyWzhFdhwBzboV8Fty1KZVbf
         CKET5hm0nCIUutuVU5sCB9hRpCXqf3fPVUJk9CVeOwm8gAjiGakc3iF3UwUhg5MpXit9
         B2IaBCXJeLIoK4Bf1G2WF1LEqiSQ2ERgcw8F2Z+b7Fq/eEg630kAFqpLG2jW9zLB4eJf
         P9MZqpxkwG6fU96E+s/J1ZbqsitPcJQ5mICrthm2Wsedi16bKI689NkldFHuFrmH7dwf
         YONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=D14i7QtQU4tmrbV4RjMKZgzmDz+Ft+nw2c4RKjJNbQ4=;
        b=RqgNWR5/SgH0HLTkGBnFH+rese8kXW3CG4IEeBGJ1kbrMVJotFdUeIevjoxS3YY/K1
         g8WgMZ67+TZ3qkNbqed7KgfSopsf6BbJhh1BjENx2Ah95PJxSX6XPiv9TiP7vUT3raI3
         GoUQPb8mVEFTSg3E4M4P9nsvC1DErK5y+2sNYAGwBbFvzUA1AYb0mRiVsEHeCOaudVy6
         bv0/wJqq54+/RhnGInzv+yLyN2WzH6pYDhlONP+qQP0PCqp64CEa+3A1/diG8Y2Z4Sbi
         ShioiywXrHkwcaM8H4Yn5kzP1D4XK08+NldGl7RRp3/sfkEG9RrAfybxPIbKAZcijw/f
         wy8Q==
X-Gm-Message-State: APjAAAWjJCrSKqSlQDafJCtHrjfdiyhurz1bU7gVRlDYNCZVNX+fWuPk
        EWUljoSF+AZKg4VWOrgHAuM=
X-Google-Smtp-Source: APXvYqzSJsXXtmIKeROcUbMwrnS4CmayH092r/yNdoxci65o6vHyQaNkV7ucDUOmCeukmBnFT4UCFA==
X-Received: by 2002:adf:e591:: with SMTP id l17mr50026975wrm.199.1568637585693;
        Mon, 16 Sep 2019 05:39:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b12sm4669714wrt.21.2019.09.16.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:39:45 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:39:43 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86/boot change for v5.4
Message-ID: <20190916123943.GA98857@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: d5a1baddf1585885868cbab55989401fb97118c6 x86/boot: Use common BUILD_BUG_ON

Clean up the BUILD_BUG_ON() definition which can cause build warnings.

 Thanks,

	Ingo

------------------>
Rikard Falkeborn (1):
      x86/boot: Use common BUILD_BUG_ON


 arch/x86/boot/boot.h | 2 --
 arch/x86/boot/main.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

