Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883639C523
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 19:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfHYRbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 13:31:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51170 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfHYRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:31:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so13306033wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tVl1fH5tYo7I6PDT6ZmRc26pY3vL2l4YUgatTNuB1fA=;
        b=pU1fNSx4e9PbLMLP73TL1pQfR9YwsihI3NijYrumoMjtVCgBOu8wvoQLoX7RCd424X
         Flj2MSKgD4MdmZ38C1YuG9cV0/rBUGLNXUQD1+UVZIwMBTq5qgfCcXDLWppjPh42lyxb
         TbDjXnfpai4sHUZIRw7W+EJb4nbBytp7h+XuL+BUmXGYNdT6P5LhFh7JDc/ZXDGUFh+G
         UAWfu3bG3qPT8oVoQN8fwyqxDj3uMwqEtUb95dKyld9Qaa8QA1zSMH+YW0R8KYG1CZE7
         HH/havCEvRuviFvYFOvA/4YHuuS3o3JDykfin7vpPobgjyth44z31sgSY2+Uzdn2i8Xf
         ELdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tVl1fH5tYo7I6PDT6ZmRc26pY3vL2l4YUgatTNuB1fA=;
        b=mK3Vci3wcELq/p3HBdzHnQh7F5SsxzzMQgn3XZ2zJUonM8fUf/XGLkhmn9mNDm3/pT
         xDGiGV52kaNa7ygNLBQCxQYnJ8YtA130pXXDa607++a36Wgq/mD+9qo+O1zJA4L1lFKM
         12EIYc5sfAMUeV6ZmBy+1iYiXml5UV7KaD3HuFpoYBpz5qmQe/Z4R89wlHQqmmMvwLAk
         mYbzAa4KZBkuabXrIdz0ZdDdJSzWuRVMjmlSu+Hk03gJHXn7DPwqKaigKlzgzVeSOVPp
         mTSXkpLokJuqOA4MJd0G1b1fqJUPc7jH3z9EBfo5vFO79SFEIOzVBmWS5gPoAP58tytb
         XMcA==
X-Gm-Message-State: APjAAAXDisg0t3eeLOAdcQttRaYRQugndJTqHfbS6XoM9m7y6bTsu7vR
        uXTl03wzpuSyTenQTkV8VDU=
X-Google-Smtp-Source: APXvYqzUzmZh8D5+DONy1KFI3ECoX/lQiqjZt/54xB1lcN+AoetMfLm1GbtYfYfywDfCcuzS18Jg5g==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr17172434wml.138.1566754270766;
        Sun, 25 Aug 2019 10:31:10 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df7:8200:64bc:6b75:d016:739d])
        by smtp.gmail.com with ESMTPSA id k9sm9336059wrq.15.2019.08.25.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 10:31:10 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RESEND][PATCH v2-resend] MAINTAINERS: mark simple firmware interface (SFI) obsolete
Date:   Sun, 25 Aug 2019 19:30:53 +0200
Message-Id: <20190825173053.5649-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010. The recent
activity suggests that Thomas Gleixner and Jiang Lui were maintaining
this part of the kernel sources. Jiang Lui has not been active in the
kernel sources since beginning 2016. So, the maintainer's role seems to
be now with Thomas.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

Len Brown expects no further systems to be shipped with SFI, so we can
mark it obsolete and schedule it for deletion.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Thomas, please pick this patch.

v1: https://lore.kernel.org/patchwork/patch/1033696/
  - got Acked-by: Len Brown <len.brown@intel.com>

v2:
  - also change status to Obsolete

v2-resend:
  - applies cleanly to v5.3-rc5 and next-20190823

 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43604d6ab96c..87ad837c62fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14641,11 +14641,9 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.rst
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
+M:	Thomas Gleixner <tglx@linutronix.de>
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
-S:	Supported
+S:	Obsolete
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
 F:	include/linux/sfi*.h
-- 
2.17.1

