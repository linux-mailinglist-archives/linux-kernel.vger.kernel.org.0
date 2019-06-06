Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49256381EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfFFXtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 19:49:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34738 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbfFFXtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:49:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so232489lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 16:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psKBDCizYo2t7/L7gqLXGelpLnD+jY7p3GiTQEkg51c=;
        b=OaJv0V6b6IDJBnzlRTnjZxRoKBpyER4juyhuiHD8QjSh3ONORhri6pyAVgGfm+lvFH
         2qfPF+m4sNNcfbK9/LcxaWACu617vKaGbGaV/iL4+3OH7uJL7Ogzg+ogMdJ136755LTD
         7nGBWGf7JB9Gi/OlIVPvAlQfaHRoWhVSPW/xuHeLW2JNjmKKsH/Ai6QNfphjrAO2PAwA
         IJDZK9wiFmrs+Jy6h0ly6Hf1DI1urDHme+SnKTxngHwY19cZ1r0kHlY4FmL8dBfRyxNh
         dL8DAZOinCAVrNXepOOFuqRpsi6LyMX2Um0kuS7rdqHifeYhxGx0vN0PUUpv8JzwvIQ2
         ri1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psKBDCizYo2t7/L7gqLXGelpLnD+jY7p3GiTQEkg51c=;
        b=aeNJxiK6msa6UJt8jbo99dbjO/w7oChG0Z99oVmOJFk1SV9v4Q2ENFH9VM5+37aV/S
         J+8Mdpvp6gToIIENza1nkiBevhdEG++XgorOHXDOhPvnIXGRFoGof6xVN5vb2FFWtEvX
         HRfsr+0+onfpNW0hF6TNOLv4VyzcRe8KiWPO9MJcXJoiUIsSj0hXkTAONkPVpw6uGhd+
         /cC/bc85892Ho761D096sjw9iqXFScN0wA1ZdFmq2gZ2lVD28sJhQPyI5POvCgJqbOo0
         jFu9M9UMsxq0GMfSXCixZ626Xnd3D2sJ6VTPTNBAINL/qEe3ICvVf997cHL7e838HdZq
         DBwg==
X-Gm-Message-State: APjAAAV3nayaxYxvIobewkgPe+EOw6flLkU13fuw3VQC4bc0upUrFUJ8
        UvaglVnTELvDtqmCPPcCc5P7Ow==
X-Google-Smtp-Source: APXvYqxoCjjaR+6HjDMMj+pHkS3CVVqzBuK/wczyL2Yq/bA7WYgkdEy8UfUVdJlRK1hWsTJXYrlp3Q==
X-Received: by 2002:ac2:53a5:: with SMTP id j5mr24957110lfh.172.1559864961884;
        Thu, 06 Jun 2019 16:49:21 -0700 (PDT)
Received: from xps13.ZyXEL-USG (84-52-227.5.3p.ntebredband.no. [84.52.227.5])
        by smtp.gmail.com with ESMTPSA id i188sm92813lji.4.2019.06.06.16.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 16:49:21 -0700 (PDT)
From:   Odin Ugedal <odin@ugedal.com>
To:     odin@uged.al
Cc:     Odin Ugedal <odin@ugedal.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Yu Zhao <yuzhao@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Fix comment after #endif
Date:   Fri,  7 Jun 2019 01:49:10 +0200
Message-Id: <20190606234912.18746-1-odin@ugedal.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config value used in the if was changed in
b433dce056d3814dc4b33e5a8a533d6401ffcfb0, but the comment on the
corresponding end was not changed.

Signed-off-by: Odin Ugedal <odin@ugedal.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a1bfc4413982..7babf9728e9e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -776,7 +776,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	return 0;
 }
-#endif	/* CONFIG_ARM64_64K_PAGES */
+#endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
-- 
2.21.0

