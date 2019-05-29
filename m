Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE82E5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 22:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE2URx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 16:17:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2URx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:17:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so2655423wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8oEKZozkL4jsgGM/i3GQ9/OGUfUGea1mU/dmE87dwL8=;
        b=oi00JVdiMhRGT23pE+wlNyBH8zwTwikmyfnprOBPF7rGhDPkeCS0tR5PI4ZGGV5EAE
         lgYgtn0WnXKAIrPtBk85V+8qq1Aw+1pOeWLc/nLB+GpXHsfo1drAGwWm8R+K+C4vqoNO
         VI5OmIoA6/d0YaReAF/PW/cZw3s0hudO9yzkNmHo+tgYv5wn832em7pmULNRy2W5dSls
         wsGfYgoXfNvp/x9QwvOJfjGeSyzUu0Y/tVhVYoRLXEdas/tRmhJynf07MQettC1IQVT1
         I/7J4ulQitZKXCRHWgfbYQuECei9PynhYRul1YJE6RIqyHiFnqNoYY685s/2PAvI23+z
         D/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8oEKZozkL4jsgGM/i3GQ9/OGUfUGea1mU/dmE87dwL8=;
        b=eWEZA5PaqKY0RdBZs2TIicjXlxXb5E+ftNG6rmv9cNr8vWZprozsyGdq4oRaZgGLlA
         Ki6EOmoUklwnz8s9xxSPVOtkyewkTmZytH9n5P+ni+yheQSdDADk5WvnIQSGaBe2lshH
         OnAYt1dz1k9K4NxtkTVvitEJKsQ5PURf8wqNI/eOTxXd5ngON9xEGRAA1Kk4Z/7gOjVH
         REgoza8/CQfZxyJ0gnOsMcz04vRlLNgf2PCXRX8ZRjARmn3SkpNuzTZXC4EACZeWQ4pP
         XTWBnI2CgHBkc8gxRd4cbAgbkaIqU8D9Dg4Cv6wQ3UfO6MkMKzU/yhQqsYkD6qZk9mpv
         hCRg==
X-Gm-Message-State: APjAAAV7HfFysyicxJsfHDwqJVBak6BzzvUM/RZaNp/5fqOS7rX7JXo2
        5kzpApOTAJusL4yhDLR70Jl12FE=
X-Google-Smtp-Source: APXvYqxh2X2AIvFrefbf6OdC+xoRWby5Ph1PJCKYsrqEAB/YbQltarLm2XpNLotK1cXCx2XPvCeSiQ==
X-Received: by 2002:adf:e544:: with SMTP id z4mr15080122wrm.295.1559161070442;
        Wed, 29 May 2019 13:17:50 -0700 (PDT)
Received: from avx2 ([46.53.251.224])
        by smtp.gmail.com with ESMTPSA id z74sm7843297wmc.2.2019.05.29.13.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:17:49 -0700 (PDT)
Date:   Wed, 29 May 2019 23:17:47 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] elf: delete stale comment
Message-ID: <20190529201747.GA23248@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"passed_fileno" variable was deleted 11 years ago in 2.6.25.

Fixes: d20894a23708 ("Remove a.out interpreter support in ELF loader")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1129,7 +1129,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			  load_addr, interp_load_addr);
 	if (retval < 0)
 		goto out;
-	/* N.B. passed_fileno might not be initialized? */
 	current->mm->end_code = end_code;
 	current->mm->start_code = start_code;
 	current->mm->start_data = start_data;
