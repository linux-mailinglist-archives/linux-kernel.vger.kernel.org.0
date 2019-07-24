Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894BB72DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGXLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:41:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41040 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfGXLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:41:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so20834068pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqvsbl2w9ubgA5WmXqlNPepTd4gyiLD5l4bjkw0rY64=;
        b=sbZR1J1/xqSfxGhYdGe1aFC5Zkv0bIcVVCiEERD1YNPQcvJu+dI2eJwklfIzWnOinC
         wgzv6UwGtypD3oNxaNtqomTVBIb1YN0lcxHk60raGqu7gC9U3yuj0AO5dyeTmlDq2wsE
         tz9vqtq+shNHs/qAQoJ/Xohi6S0hphqNq9B5rBnNOtWxxfa2CCfaiIStlWKpcoFNQcOA
         NHaJuSgyUQB6cc3bli+/HQb9uC9mmSODW57RXUZx+2W8FXHIwa7POYv9odL8WsPcNIa4
         ol+z5m2bndZA7uWkCFqwSXnG8oKhXqGUmzpnAycP/R6yUpBIR57luL0M0fwvfH2wLoah
         6uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqvsbl2w9ubgA5WmXqlNPepTd4gyiLD5l4bjkw0rY64=;
        b=lwE/f+mf+lp97iEYsobGU5QR6Qi0rO2Gct9RYrF5cDRQIFV549+HE6r/QI0Sj5eIX9
         M0m1zemLdk6Idm9Wa0nMYPztEFHCTzxWfK7twZaQU0r0G+/0NZquhmdx84sbZ9P8YlYK
         sex5lrOm5f6hpJ1egwSh0KNTd89eL9S1b80OmO6TybbiYvQmDYurEbzDj+NFXJUAS/u8
         8UfAqW/tLvFX2FXIKyqdUmBxlr0E7ZL6T5EfHp4HHkm0onjZmadNElSSTqtnqU8SB/ku
         BumVe1kXFeLWF6lJ0fI9hR/b8hIuU9kco4NSss3VRtMYHCK5nRdZIdXj6bsHZmlKCvmC
         k04w==
X-Gm-Message-State: APjAAAVeccSSF+PmjZQvVr815SmL9r/tcVX4u2OOxdzzf6+7abdAL0/j
        +VxVKrD0/vQitkvEmyg4Uoc=
X-Google-Smtp-Source: APXvYqyslSaLqtp4I3vK4ITATRHG4NBqTSovhWR6FrUXhe3TD7S2jUbFqr+lU2cQJA3rJYRr2NHLFA==
X-Received: by 2002:a65:6850:: with SMTP id q16mr44415063pgt.423.1563968494767;
        Wed, 24 Jul 2019 04:41:34 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id b36sm70730923pjc.16.2019.07.24.04.41.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 04:41:34 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de, jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v2 1/3] sgi-gru: Convert put_page() to get_user_page*()
Date:   Wed, 24 Jul 2019 17:11:14 +0530
Message-Id: <1563968476-12785-2-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
References: <1563968476-12785-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 4b713a8..61b3447 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
-	put_page(page);
+	put_user_page(page);
 	return 0;
 }
 
-- 
2.7.4

