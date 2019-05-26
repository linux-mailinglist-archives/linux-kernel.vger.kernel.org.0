Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712D22A789
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 03:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfEZBTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 21:19:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39707 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfEZBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:30 -0400
Received: by mail-vs1-f65.google.com with SMTP id m1so8364938vsr.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvvzFoJ2ck5oHxGDatOJeomVyH3WyqM7LMnChkSEXnI=;
        b=UjMnDA9wE57AVcTR9JMgVNO7ZEjWaLxR5EEP8MDA8Xue4hH2E2AoY694nTZF52hiY+
         r0up6C6XIeeIwPqQ7XSXi4O0oeE4VX64KsJ1ReMmpRrGIspUEWmg82ONk44bCLY5bLAR
         PMPVlMgYMb00ig4GxxwnGNgPdUGrFv3Rf8skBRRt2gTxlNiXxx3aMSEvbgeiut8TPlVG
         CGWHEQNrDA2bLmlW9bvDLWU/PTsbJOuTBxmhlH6wWpYikUTcKkyKCCXuocRGEmLV7i0s
         S0AuvpieyEzHfqX/Wn+75eAdPu13RgYpm2XqMWt5htXxBq1tG7QzblZEwDwkaxVldFpw
         Tr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PvvzFoJ2ck5oHxGDatOJeomVyH3WyqM7LMnChkSEXnI=;
        b=ZGAyWoyL++99vlN/mZqpekHuv5vnt1Q3Fz6nHwUhwKTmeBjPSHJHx54Q0U69OyuryK
         Ul/oC0CtgrxLviYE8bSiq43VBWbqRbkfZ4KcNQVfZyeOeHzGDvfLVah1oXzahSxFwE4D
         peqv9UrIFFH2IJ3tVSd0SAPefnqwiudFYjXN4JRzefIQcN22+Q4DqNsoY7NFwwAMItpU
         oNc6M+SUDMQOBSSuNAdkt8KKVpNL3O0H4nmgEHsFtL+2CcRtzwLOlaxRYTxhW9LVopIt
         fT2Syv0CijIZ6Uaom8uItV6aaF2l/57y1tYGfEN+n+7vVQRuOAYqtYtrPrMUmik8fXIh
         B7VA==
X-Gm-Message-State: APjAAAXo62N9MkqSpBoniFvPP80I0lLK8j2hC8KqxV4GQcKrMmrY3t0b
        OKCNoBkEf6qyWlfC2o+mWqnc+4xbvcM=
X-Google-Smtp-Source: APXvYqwLFbh0mFG92YhLGGaRgMd8hdvalz1VWjEk/C3Ybyusw24PKru80bf57vqoXtX+UOA+lwQj/A==
X-Received: by 2002:a67:ee96:: with SMTP id n22mr26950562vsp.187.1558833569750;
        Sat, 25 May 2019 18:19:29 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:28 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 0/8] staging: kpc2000: kpc_i2c: assorted driver cleanup
Date:   Sun, 26 May 2019 01:18:26 +0000
Message-Id: <cover.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some patches aimed toward:

- cleaning up unused/unneeded parts of driver state
- a couple of small style fixups
- a couple of API changes
- better error handling in probe()

in the kpc2000 i2c driver.

Geordan Neukum (8):
  staging: kpc2000: kpc_i2c: Remove unused rw_sem
  staging: kpc2000: kpc_i2c: Remove pldev from i2c_device structure
  staging: kpc2000: kpc_i2c: Use BIT macro rather than manual bit
    shifting
  staging: kpc2000: kpc_i2c: Remove unnecessary consecutive newlines
  staging: kpc2000: kpc_i2c: Use drvdata instead of platform_data
  staging: kpc2000: kpc_i2c: fail probe if unable to get I/O resource
  staging: kpc2000: kpc_i2c: fail probe if unable to map I/O space
  staging: kpc2000: kpc_i2c: Use devm_* API to manage mapped I/O space

 drivers/staging/kpc2000/kpc2000_i2c.c | 33 ++++++++++++---------------
 1 file changed, 15 insertions(+), 18 deletions(-)

--
2.21.0

