Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40055195D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 19:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgC0SI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 14:08:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53892 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0SI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:08:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id b12so12387667wmj.3;
        Fri, 27 Mar 2020 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dLGBA4Mb9FTGMIlIs8CkqjXevwkXDBhsu7I/2DN/lVg=;
        b=XSavPXEt6mUB1SdOj1YBnqkqrJe93YaS1Lj87R+jSLPm/kVKARDUyB6wB2AsEwTBCG
         qM/z86PE664z3DTmfnDVf+nltCnU3Z4XbDn+9FgM3kzV+zc9oUgqzDs8ssodwhFPqZUN
         1GDLHoxfXi1CVPhYMLuuQ7wg1ghTeGKNF3rjU5rN3Un45oaLRB3atl2DXkP3BnhUZ5GP
         aPrwLdkzNF0qQsb7+9VsvLuOPs4fFaD1E6C7olvwr8paQB2o+NbPRnQm4UlpmN3OUcYm
         hODliHhjyyg8ePlqV3nOZ+pAhqQlpzVgMcVUts0qBAowglOFgJjHeIA9RPsxTOds/bBi
         CnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dLGBA4Mb9FTGMIlIs8CkqjXevwkXDBhsu7I/2DN/lVg=;
        b=odDuH3soAgj3hpF8nhHlO1vGhQGCzLLCkC6cBN0SFsQe2mE0xBfZ3V1y5+kVW0YBKc
         DCUglwLs+EHRNDDBGXqgW1uUmKM4GHdBXx1eXdRAfyneMDPSgt7bK4Vszg+vYB9g3KNq
         FDl9whwI5TJ6TyIqhgji2KA75QSfr94glw85s553qPsMgjj2IYnTQHsN9avSmlAqI5WN
         ZwugKt+tCgTs0kHqzp110GP8z5olDx+hj08AwD5fbBxbsZgYpmNni37w2xuboXqmwy05
         D68WiHyYCX3CP/0bmUc3Pn41nhfhyj4YewDD7BFj+eow0HalQ3ymzaLjwruPR6Bn+1Lj
         whNg==
X-Gm-Message-State: ANhLgQ12H83/DEOuB6BMiQELtdmO84lBgmg+37KvdILQVJIqVGyDA1wQ
        HBw1u2dI8kQNlOVmH6yb270=
X-Google-Smtp-Source: ADFU+vuRMr0aC1EEOQ2IUU53LmmatocpY5HzNQyaogQnO2V9F4Wmb186gwCYrLSt0dT6vHzlGLI58A==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr6515752wmi.9.1585332503792;
        Fri, 27 Mar 2020 11:08:23 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df4:e800:d943:cc2a:2aed:eb16])
        by smtp.gmail.com with ESMTPSA id a186sm8789185wmh.33.2020.03.27.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:08:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: rectify MMP SUPPORT after moving cputype.h
Date:   Fri, 27 Mar 2020 19:08:14 +0100
Message-Id: <20200327180814.7255-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
added a file entry that does not point to the intended file location.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: linux/soc/mmp/

Rectify the MAINTAINERS entry now.

Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lubomir, please pick this patch.
applies cleanly on current master and next-20200327

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a5332b3591d..d1b21510fe5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11199,7 +11199,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
 S:	Odd Fixes
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
-F:	linux/soc/mmp/
+F:	include/linux/soc/mmp/
 
 MMP USB PHY DRIVERS
 R:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.17.1

