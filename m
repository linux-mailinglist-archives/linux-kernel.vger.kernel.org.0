Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6AB444DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392729AbfFMQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:40:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46832 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbfFMHC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:02:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so6284759edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEIAcCGP/z08es9NPtS+WIS/044Mw9yHEo/3xcrUrOQ=;
        b=aSm9LhD41KyVNm1kAG5u34+mKwpYwx5XNhQDDw9zsJO6CA9/ZrTjwnq03lmLGckAgV
         WB/Jufh/GaG7HI2DNmiZwwhCjV2CdQJTnimi+UiV2BU3nNGzYaO8EJQAELkQsWbdWzhj
         b06A1fi9dwGfA9OR0dJ0ZINqm/Zhg1X39GkGXb5IQXrN1QJM/AIkHv61ErcuitnDvW4S
         E9SjotrvOzO7iCyKwCroJgD0iRa2jeRGWe0cn1vb0w54JDzXDEDi1NMcAXXhcgG401il
         sQR8j7go+2RXq+kFYhM3xXz5GDtwGAzFxEXajV1UdVOi/H5DYC8JsebbyXhZEnW3WF8b
         frcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hEIAcCGP/z08es9NPtS+WIS/044Mw9yHEo/3xcrUrOQ=;
        b=p5Q9VqqfMADw4V2wcVJcFQvBKyIFzbNTIxNREHdpKDJ7Img3lAGxX9O4knf646DzyW
         CFB6ILIkOjyXw3cIrQBFtEfaXE48JCySnoNTAzHwm4yzcfBevd+1o5eXcRRPAVB22oPB
         f3NQm53b+HVuRTNpKryEtKuDX3sLUbvrj218rY1OxCiRzF1WFoYCfKUTzNuDoQMoWMxa
         +QAOUfcAYGqIQj5MOVZdf4pGZNdbuVzaco4JaW8D+Pguct7YNpdBPMHl/3r2QJyM6bFX
         1UpevOkzDofQrYCccuf6Bt9oPAUeW9Gubaqqvd7lQthMrsCejpqlD88WMoJ68fNlWCHp
         SorQ==
X-Gm-Message-State: APjAAAWLznqtJuroiMrjNSVEJIioNATxUvVCc60ZnkUMtGgoZg4pxPpa
        0SUXPbnnVhc+koPsTx7ELOp7bgqh16U=
X-Google-Smtp-Source: APXvYqza3mLrvU3YM5VyMqSx78u2vQxPUBVN06/agdAfqU+pu5LLY6r5sM67YvsmtZPlzjyIyXLBHw==
X-Received: by 2002:a17:906:d549:: with SMTP id gk9mr58363207ejb.268.1560409346566;
        Thu, 13 Jun 2019 00:02:26 -0700 (PDT)
Received: from viisi.d.ethz.ch (mpp-cp1-natpool-1-013.ethz.ch. [82.130.71.13])
        by smtp.gmail.com with ESMTPSA id e23sm383626ejj.13.2019.06.13.00.02.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 00:02:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     palmer@sifive.com
Subject: [PATCH] MAINTAINERS: don't automatically patches involving SiFive to the linux-riscv list
Date:   Thu, 13 Jun 2019 00:02:25 -0700
Message-Id: <20190613070225.7209-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current K: entry in the "SIFIVE DRIVERS" section causes
scripts/get_maintainer.pl to recommend that all patches that originate
from, or are sent or copied to, anyone with a @sifive.com E-mail
address to be copied to the linux-riscv@lists.infradead.org mailing
list:

https://lore.kernel.org/linux-riscv/CABEDWGxKCqCq2HBU8u1-=QgmMCdb69oXxN5rz65nxNODxdCAnw@mail.gmail.com/

This is undesirable, since not all of these patches may be relevant to
the linux-riscv@ mailing list.  Fix by excluding K: matches that look
like a sifive.com E-mail address.

Based on the following patch from Palmer Dabbelt <palmer@sifive.com>:

https://lore.kernel.org/linux-riscv/mhng-2a897a66-1f3d-4878-ba47-1ae36b555540@palmer-si-x1e/

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..66d23856781d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14332,7 +14332,7 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
 L:	linux-riscv@lists.infradead.org
 T:	git git://github.com/sifive/riscv-linux.git
 S:	Supported
-K:	sifive
+K:	[^@]sifive
 N:	sifive
 
 SILEAD TOUCHSCREEN DRIVER
-- 
2.20.1

