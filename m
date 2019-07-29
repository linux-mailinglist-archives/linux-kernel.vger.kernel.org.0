Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626A778361
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfG2Cfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 22:35:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46335 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfG2Cfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 22:35:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so26856018plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/Y4lNvh0h3jAdVnF5IJqyvh1X1fO4/sHQLpJ3wgtbcU=;
        b=RCk+iXxcIoskmwU+26UFqkUt8BYKDBYE/8h9TEa1cbMtqoF4vNcqpaHTkQbh6jLInd
         pu63bEWzdnlUFbmrV2QP+tgJP6hR0GtVKLj3Z3nTmRq0WHd2LSkPJtlZyurEbPisTutW
         2/B5iHhk5BI4P4aMXztpqHx6WpPnL/8DSU72FUpbxNb3eczXy5jNKh2grBQsVpW3zfP5
         AXtDYu1uprLfdAbQhQclA8fEvUIX42ppZHh8yUf88JkKO/NRbgtMZ/bYF7B3NHUCM6Zv
         0247GfUaJVWdyach97AMYPHXDYLYqk2XSF4QtMdz0TQP1gPQ4lr+Pi2/FDG0ZGesG8D0
         vrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/Y4lNvh0h3jAdVnF5IJqyvh1X1fO4/sHQLpJ3wgtbcU=;
        b=PqkBRNnCv0C8QSS0UbbyGdh7bMAlcgwi5Hv1W67Q+JQ66eGegKm+NbHjjsi9PI6KOu
         RvofEK/MgYLz8wHqJfBsYVi4Wp/3FFo/39aX2Oh13zROMGF3jhbU6VLmn6c+ErzuPw7l
         kRZJupt9Wwsc4b+7v45lC+7EtoYC9Fkgw4RjPcpKhDBDt6L0xciK+en03zzLDO8CuJFP
         AKX2TSp+BcdlnPi0ihHiLR6pkxsnXQeLc9LqNVrQanqaLuJjsGBs927smdvC83NPLMVa
         3UOqUTcf6DO0NseTu+ag1+KhTt88Rnr8Zb6Tn3+jbzTovDYjAH3BqShd+KPVqWMMWcB9
         jMGg==
X-Gm-Message-State: APjAAAXBAITYqeqg2l3jzbTS8CJ8RxoxN4Gtlvvo8O9a6l1oUcxyGDFB
        v0KQDJzo1bYcfMCcII2pZug=
X-Google-Smtp-Source: APXvYqxFNsmm2J2EbPH8YhNy9OW6cMU8+kZ5GKlya0f18XIpJg4zCuzHzXn2O03xcEzaSMR8f71ehw==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr102774013plb.316.1564367753078;
        Sun, 28 Jul 2019 19:35:53 -0700 (PDT)
Received: from compute1 ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id s24sm60068273pfh.133.2019.07.28.19.35.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 19:35:52 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:35:44 +0800
From:   Jerry Lin <wahahab11@gmail.com>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>, jon.nettleton@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: olpc_dcon: Remove TODO item
Message-ID: <20190729023544.GA25930@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All uses of old GPIO API have been converted to new API.
This item can be removed from TODO file.

Signed-off-by: Jerry Lin <wahahab11@gmail.com>
---
 drivers/staging/olpc_dcon/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
index fe09efb..d8296f2 100644
--- a/drivers/staging/olpc_dcon/TODO
+++ b/drivers/staging/olpc_dcon/TODO
@@ -8,10 +8,6 @@ TODO:
 	  internals, but isn't properly integrated, is not the correct solution.
 	- see if vx855 gpio API can be made similar enough to cs5535 so we can
 	  share more code
-	- convert all uses of the old GPIO API from <linux/gpio.h> to the
-	  GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-	  lines from device tree, ACPI or board files, board files should
-	  use <linux/gpio/machine.h>
 	- allow simultaneous XO-1 and XO-1.5 support
 
 Please send patches to Greg Kroah-Hartman <greg@kroah.com> and
-- 
2.7.4

