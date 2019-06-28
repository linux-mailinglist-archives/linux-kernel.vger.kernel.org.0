Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE215943B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfF1GeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 02:34:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41236 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfF1GeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:34:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so4965568wrm.8;
        Thu, 27 Jun 2019 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vndYnR6xSudskHsKtFXR3NkfD1HHznEE91yHBNI6oSI=;
        b=XkHgnyqTXZmlY9k2yBnHgBlH7kAHKdQHDqFzhAeOYVEBlMIFIsFTR1iv8hYGw6RfDx
         8wpYk5nIaIiupJyHJ1MwM/kr2zyOx9X5C8I+i+KzOujkaZUzDEdfOtdsxqioRhbd89Ac
         ckaq3tIEYJcmJm/ERNmTbW61q28OWsovzd124yOMF2A4ICyj3wSivlV9VRV7uV/YpfaH
         j4XgDtTEbvtDLJop9wOX3ddXqFHHYnqabeiiohH3jPB+Zrxb8uw0U/YTHohlJXGuuugq
         5W8HxPXxfeOAjtHsWMFBJROAeKL7s6FE4w+0tSfIz4lSyU6yh0kk9Vd/TjTlspBJJbTu
         uDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vndYnR6xSudskHsKtFXR3NkfD1HHznEE91yHBNI6oSI=;
        b=TREuO8UbahT+FqMKhpgx0/WPRNg1aKPF275csvoI86+pNDjxyA8JykgrfD91MrzHQB
         aFoFI44Hv57R4+hDncgnCiXw/9A7fOpFQiQn6W6a+LJ7j663Yav4MSaNIhYJMXIlHBV1
         RgyhL6RC73B+x6q2YUr5WSMiZjk0cj0EXKRJ5zbFP1JzWGIW7q2lIp+IJJWFaW3IHD0e
         eN0MZjQ6GJpPb/uW5Zl5dB9BsRF01fVU3aNAZ+ZBaZ4zrpXn9HODuXaeio9aV2OuP1/7
         axGRF0DXmU7xFLINzZFZ8NZqY5o/f3NfyfDY9TwJrujPAu+CApiurkQN1N+5xJCuxrSd
         J6Kg==
X-Gm-Message-State: APjAAAUUKd/A57SE68oYFxapUiw2EB7K72rNK8sFbfA9HecEyBPrBVmb
        plvfJVFwclkRLzIqEt/UlO0=
X-Google-Smtp-Source: APXvYqxfCCUwR0x+LFldMV1mssicN2RQBgYErhyfJWb5cQbYPr02hEWciw7MT6AwyPcdQVN6tXGNlg==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr6423642wrv.322.1561703639902;
        Thu, 27 Jun 2019 23:33:59 -0700 (PDT)
Received: from localhost.localdomain ([41.220.75.172])
        by smtp.gmail.com with ESMTPSA id l1sm4413755wrf.46.2019.06.27.23.33.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 23:33:59 -0700 (PDT)
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Sheriff Esseson <sheriffesseson@gmail.com>
Subject: Re: [linux-kernel-mentees] [PATCH v2] Doc : doc-guide : Fix a typo
Date:   Fri, 28 Jun 2019 07:33:42 +0100
Message-Id: <20190628063342.27613-1-sheriffesseson@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628060648.25151-1-sheriffesseson@gmail.com>
References: <20190628060648.25151-1-sheriffesseson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the disjunction by replacing "of" with "or".

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---

changes in v2:
- cc-ed Corbet.

 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index f96059767..192c36af3 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -359,7 +359,7 @@ Domain`_ references.
   ``monospaced font``.
 
   Useful if you need to use special characters that would otherwise have some
-  meaning either by kernel-doc script of by reStructuredText.
+  meaning either by kernel-doc script or by reStructuredText.
 
   This is particularly useful if you need to use things like ``%ph`` inside
   a function description.
-- 
2.22.0

