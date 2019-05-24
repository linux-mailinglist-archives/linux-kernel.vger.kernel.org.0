Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5195629EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 21:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbfEXTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 15:10:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40160 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391360AbfEXTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:10:19 -0400
Received: by mail-it1-f195.google.com with SMTP id h11so15331945itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRUuTYiShMwFtE56cW22VUT6bEYjNIFQelgnkYt+eq8=;
        b=VmsKwFSiC0VUEkprKQg5TgU1MmAz2u0h7cJitkY99mcmQNCfSGKeNM2ew8dV/Q1I9x
         j9kwUwdiHkcpvg6S3yYMUfNa014OuppKlmyoYkbVX4kwzLjskS42rQmmw0FA/C0gTok5
         mLqyrxlTg0In5P4GdNyYpkYT61pw3jE8im8dInM+w5sP3JiiRaXb3iMuQ8deZbmpRLxD
         giVIKn53iSEXE4psvUxYyOjr2cyG+ZjSOEmotBHdHUBnuecOKiblFY3mJNjlJNlBr8Oo
         FeE26+QEX0gzeOtPxDJOSMMQeLo1V+QHtjx+IS+phAC2R3EX6rHBxpb6XZxah2XgXpKR
         Ji/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRUuTYiShMwFtE56cW22VUT6bEYjNIFQelgnkYt+eq8=;
        b=rJ8uLZLxGm6thq1AtWNmk5SZptsP6RiU3IIfg9U2DRrWOKqXHgNOQayBF4JASN7cZx
         y9TflOnfYoId1JPkTRfpC8VeJ+qpaG6WCMGrO2t2xxGmP1evB75uS/INO7jW1DS1WabK
         YEwfxOfDOYQ4LAlYX7jjB3gyUpq1wUPDbAeb4XrWZgRil3XqjISqI9cRUePDMen2Yg2b
         zgcQ67D6RgzlfMtGsFAJRm236k+5wJySSa39Gb2XhUO+ffGFXtYyHw603onoUDqhJ/i0
         SLz8yttNNmoeM3Cz87zNkus7w+ZlJKBLCyiMqKhQfOmL7ehkdCZHIuIQpOrteWwdPrTl
         HLSQ==
X-Gm-Message-State: APjAAAUU/2OuPKmD9foDd7WZANyCZLLTFeK6zUFL1oQqPFU6FggU5EB4
        sy2+ikwGpptF0jE0yNevTQg=
X-Google-Smtp-Source: APXvYqz0rzwvqbSFRr8z9t0buoMdnl574GfCSR1JKODGSroNQ+Ap4blDmwT/aJDEyxkeWFsmEyqVJw==
X-Received: by 2002:a24:c242:: with SMTP id i63mr18254379itg.89.1558725018805;
        Fri, 24 May 2019 12:10:18 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j19sm756079ioo.17.2019.05.24.12.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:10:18 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 2/2] MAINTAINERS: Add entry for anybuss drivers
Date:   Fri, 24 May 2019 15:10:13 -0400
Message-Id: <20190524191013.10139-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524191013.10139-1-TheSven73@gmail.com>
References: <20190524191013.10139-1-TheSven73@gmail.com>
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

