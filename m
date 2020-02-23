Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B94169ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 00:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBWXSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 18:18:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38139 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBWXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so8236983wrm.5;
        Sun, 23 Feb 2020 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkZxQ6B+RPug7Nx/pyO26mqDK5+EhLYireVzDOPYgMs=;
        b=HNu+zqFe4k4trsUTuFrKnD8ePsws7XhpIhdhtcht9VVtObGOgcU83p03udY4EzxUk2
         FG5W1h9AgyIFusy7DPRCB1s8PNU1Damwx6nZahwk2ZIQBryEkPOlTOWL19Fc8Q2U061h
         +cY479Eh6DXyc1Oa1XAQt8ry6rxubUPLHvUCQz4Zm/jKi0FBSrL0FfjosN7uinbMobX+
         Jz6wxtHQcPFHWnwJp6KQqjVxo08RpaKISzu5F+B8cG3GsnBFpqyxX1wb3P+b6ALsLf/N
         E4Pz6D7cjDXD9zLiIZoO3Fjo2WZbQHczSb8t2VOxg6Xv2JX2ABnCrZDZec+GNfkkfuYq
         iKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkZxQ6B+RPug7Nx/pyO26mqDK5+EhLYireVzDOPYgMs=;
        b=Em81nzR4dJ8YuPhq8tEmH8WwkI70Vx6GhlMveN11ao6wn5D2TPMcqifiHecxpfqHub
         HQXUydROlyOFOZEAtNy0YzgYe9Fn/YSrvqKth8dUx5Uh3uaFTGaIKOm7RXhiAar+713G
         GuGy4u+bURqoTeVXLtjO/xwQrmOb3VX4EJLCWzTvn4eZFFX4F+YTn9V+70DI39sSr4aw
         0J91fe93ZzIlFIbYqzF+mrVCkShsIFm3dwMXVluy61S0AlCdESYDN64gAMLgWx036alX
         ejONUO34oVof2m6rbQAH4wz+bX3KxcXoQrIcwrINgWJjRSAm5OsAljAyJj7y3aPXN45U
         fdmA==
X-Gm-Message-State: APjAAAU8xj0SIfhDe5tPlujIpGGr0N7atb8C21LHb1fFF2Ph9265dBTj
        SbLGBR0nqGrHWA6J9xDbsA==
X-Google-Smtp-Source: APXvYqy9OXr3hcWD4vPlfc7IE484f01f9gdQBFm+qkPOVBa72h1h0RM3ZMX1QmAB9YtsaIi+dHbzPA==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr60374595wrf.385.1582499905573;
        Sun, 23 Feb 2020 15:18:25 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:25 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH 25/30] zram: Add missing annotatin for zram_slot_lock()
Date:   Sun, 23 Feb 2020 23:17:06 +0000
Message-Id: <20200223231711.157699-26-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at zram_slot_lock()
warning: context imbalance in zram_slot_lock() - wrong count at exit
The root cause is the missing annotation at zram_slot_lock()
Add the missing  __acquires(ZRAM_LOCK) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb5793842b..1462b1bfec11 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -62,6 +62,7 @@ static int zram_slot_trylock(struct zram *zram, u32 index)
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
+	__acquires(ZRAM_LOCK)
 {
 	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
 }
-- 
2.24.1

