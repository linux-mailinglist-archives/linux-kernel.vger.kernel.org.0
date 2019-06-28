Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E95941B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF1GUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 02:20:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50418 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF1GUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:20:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so7847835wmf.0;
        Thu, 27 Jun 2019 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vndYnR6xSudskHsKtFXR3NkfD1HHznEE91yHBNI6oSI=;
        b=fH6D2zDDmoxCD4ujb17jwE7KgMB6Dv77jbnKV0bk3ddIGyhmpQu9aoffjm9LDKQo28
         L/rKlAv8Hmd2ZCds9+vJK4SVFvp3Wkf67CyPb4i9ALwJ5Np9KaS/JnmF18oVkA3mloPt
         v+CGshR4rW3VHKg9WQFoNqaCsxyLvyHif6cbJPY7rJciSadSpGTWYxsSlxn//D6spu+L
         wprXzXEgH4dQTnJ7QPZ45wYWu2vZBnboScZzJCLVPYtsh9K2T4aTyX3/32l6ylZNFLA6
         HFk/EiAJdOBYOfDct+gFM4Inwx+bBF/o5YYhItYJn9WOYA+gutxdoUyU33rsadKNh0th
         2iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vndYnR6xSudskHsKtFXR3NkfD1HHznEE91yHBNI6oSI=;
        b=SXWjF+Z4X+NYxJPyIl8n59d8MCYkKj8hG8Wt1f0cZY7IwUPgO7HeMCITctgpuK/hn6
         Se+wWxTyvZEgwtyS+rGcTktoU/+CgJdda9pnu82deZExeBSz+DF/j+Oe3r1aWCKtXxbx
         VTWod4HlGLP2ry5cbq4vtgEgfn0C1cv7V/z/56BmjYMDGdZDm6ORVUEQGNmaUjGzaRnA
         HTs48bgvRykkG8HMRy6LXf1zwq7oHtbnkBjRtrR8rvirj5RYAf4akLWoTjBbUQCiIAK/
         k1D/NPdSsGlr5OHmR9dXQRkiBuSfurI9ReK8YWf274OrE4A0g0r5oxfCwJ37J18RRbUR
         5rpw==
X-Gm-Message-State: APjAAAVU96EO/8adELYnxOIskZGOYWvT4aCysX18gFK1fmXFOgJ0zqCK
        rqa64cAjtzMD62ubPLLyMG3/EgIwepk=
X-Google-Smtp-Source: APXvYqySVPatnGa5TPofKT5fcIprLSQtjjZkKTn2zp4I1qcQ/IuSirpgWIkj02+Q4KI8rx8n0otYpA==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr5510226wmc.34.1561702817418;
        Thu, 27 Jun 2019 23:20:17 -0700 (PDT)
Received: from localhost.localdomain ([41.220.75.172])
        by smtp.gmail.com with ESMTPSA id v18sm1130995wrs.80.2019.06.27.23.20.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 23:20:16 -0700 (PDT)
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Sheriff Esseson <sheriffesseson@gmail.com>
Subject: [linux-kernel-mentees] [PATCH v2] Doc : doc-guide : Fix a typo
Date:   Fri, 28 Jun 2019 07:20:01 +0100
Message-Id: <20190628062001.26085-1-sheriffesseson@gmail.com>
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

