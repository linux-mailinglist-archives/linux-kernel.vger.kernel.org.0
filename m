Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88EE128E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 15:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLVOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 09:40:14 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:34364 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfLVOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 09:40:14 -0500
Received: by mail-wm1-f50.google.com with SMTP id c127so5340941wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oy2LjJSLec2D59fijFx+c67E3+02VMx6+pY3xXIM7tc=;
        b=uNSUM4XdIsmMeLStHloN9C3c8woduTojbagMd9+QNQ/25pOnk8qryJXpxA0EDjBPNG
         iyNmmMDJ4A4TzjQV9xGT1Hv0ASfY9gCplTCnRNNITn3K/HJ0H/9NkafBSlhMGdmhHR5a
         xxu1jq0RqpJlki/ArX+Hw/0uO1y9xnS1SnZD4t/iTxjRMkPWTM3VuoRoXSd0ndavu+OZ
         GblyHWcQ0TaKhkgrD+oDm7WZPJm+xU3FL/AaKhEA1cptSsyT0n3rz7mrXg2bHENoMD6U
         Qd8DvWQqqjgE48ol/CAbq8AdpzYfkerWpDHhnjm2mdw8flCEHQ4wmWGqaJQNKVD/3byM
         U6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oy2LjJSLec2D59fijFx+c67E3+02VMx6+pY3xXIM7tc=;
        b=IuIEe6TgntENgR6xIbQE2qq7x1+e5r6ChJvG9MIOFA6+0gCmeezE3KYNTI1UH2C8xI
         m+CTcsFc7LcmgLpHOnJ6gkJDryomI0PLSovjYGOj8BQRc7AHzQudUy4d1Gaars0/WsvZ
         OyLDkrvl+8GgrSCs7hTtx9UgZpbfoLL+jvOPy0Zl+wqV5AV0nxjrux+VfBdmJoxJvu/O
         18Z8jOFHkfecxDkFF6X91cxpTpZLPZg5EEhWUaFurNhn7+CegzilxRkbBSV50yupMib9
         YuJRaLSqC5BWhnfslijQe9QG+ovLQ+M3IupJrdcFbWeCBPudBxXnsM/ZpNIgm+GsCN4k
         /8PA==
X-Gm-Message-State: APjAAAUQdunH/uJrQbgd+nTKCZ3FexqKzsW63FQ7xv0ktewWIErAkcbY
        4swl89m5+WB2EJJpDgcTzOItK8M=
X-Google-Smtp-Source: APXvYqzHJnblWg/+gDC0Y093ZJBWaUY+19oLjQsYrB4i/B8e+C2OwMreUCINzmHuq8YU03WDA35R2g==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr13786325wma.8.1577025612295;
        Sun, 22 Dec 2019 06:40:12 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id a16sm16959673wrt.37.2019.12.22.06.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 06:40:11 -0800 (PST)
Date:   Sun, 22 Dec 2019 17:40:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/3] ELF, coredump: delete duplicated overflow check
Message-ID: <20191222144009.GB24341@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array_size() macro will do overflow check anyway.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2257,8 +2257,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	if (segs - 1 > ULONG_MAX / sizeof(*vma_filesz))
-		goto end_coredump;
 	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
 			      GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(vma_filesz))
