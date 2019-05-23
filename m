Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4F28B84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfEWUaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:30:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35508 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbfEWUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:30:06 -0400
Received: by mail-it1-f196.google.com with SMTP id u186so10500585ith.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRUuTYiShMwFtE56cW22VUT6bEYjNIFQelgnkYt+eq8=;
        b=PDSEhFz8d/Empv/y4Sz6sKRAbnAhJTa/l1NiWl58rAxJMksy7BJCHnxdNxYm2XnNxE
         xl4jfrQkZrmEaXX7JrI5CvTaGKCUsvMTfwmiBdDQfVrBAaKgZspTpXUbPHKZGc+/iVLM
         cCzPm11Xos9OmPufyiHx8+n82l6s6gry/SaGBI9gSY89X6bsnnxnVQ0+Fzn+aRvwn81e
         5dhMOEjRIdSbfBAtBceMiT2vAfuNiBYrx2gosW4Lxfwqkoo7o1/Cz7LHzSUFFzT7Q9Le
         fuJByJtKkDR++WO9KYzOPgcqzk9fBkzkbwW4MaW75QPTMsjXBdmJNoEwI2t7zuQg8kEz
         aTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRUuTYiShMwFtE56cW22VUT6bEYjNIFQelgnkYt+eq8=;
        b=OPJd9SkPfeVX81MU4fJM67otoJlIDsRzJvI62b5/DZWHf67muo1+Wy6H0185z8RgBW
         mY94t2WxeYTkx8cHxsRWVKlQj/05uummEJbRH2znYZdIjcUgoJwgft3jhZjnBqF3lQPS
         nVuO9XrPtXn1xYOlW4YA27m29vStwWglg6NvTPOscNfYhoohWNeI8WVaYalYMDjOiPKp
         Mx7Q3Y8064+5Mipboix6FzOfrBgq1xGM+oqCA5+aEbIFWZBCP4CqGN0yCpM5Dt1r9am3
         xu4UCSPItuEpESfiajBfYIIlAmx68sklRkAasCrWnOjPKV+dGqFbt0XVG3wX3kmTm28G
         KaLw==
X-Gm-Message-State: APjAAAU1ONAisS4GIxYrJb+GDLaOioH26IUPO5tY7dzm5spgkDbdtPyo
        J+qtYjTU8yWcB8Lswsv+y38=
X-Google-Smtp-Source: APXvYqyV16HbVdnD7pGkz9aQRE5k7Rt+YRiulyWCimbUB2EmAQYeY+UxO++c1m6EPe63Iussiws2qA==
X-Received: by 2002:a05:660c:7cd:: with SMTP id e13mr14333755itl.40.1558643405298;
        Thu, 23 May 2019 13:30:05 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id w189sm217903itf.39.2019.05.23.13.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:30:04 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Add entry for anybuss drivers
Date:   Thu, 23 May 2019 16:30:00 -0400
Message-Id: <20190523203000.32306-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523203000.32306-1-TheSven73@gmail.com>
References: <20190523203000.32306-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the anybuss bus driver, and its client
drivers.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50e164041e94..2b9223be10b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14911,6 +14911,11 @@ S:	Maintained
 F:	drivers/staging/fieldbus/*
 F:	drivers/staging/fieldbus/Documentation/
 
+STAGING - HMS ANYBUS-S BUS
+M:	Sven Van Asbroeck <TheSven73@gmail.com>
+S:	Maintained
+F:	drivers/staging/fieldbus/anybuss/
+
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

