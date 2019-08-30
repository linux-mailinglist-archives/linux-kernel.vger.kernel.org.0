Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B4A3682
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 14:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfH3MRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 08:17:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33914 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3MRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:17:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so3492753pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QBDazDOM2X7FA70xO+freU9rlh5XTVJr8JINQl4RCWU=;
        b=pnDI0maV5Rv5WyuaigzZDWVEE/YsPTOr9eMvQv6PwGZwmIjmVvxfGwPWbHoo4LFHva
         7YtBD+fIbpmozffoEBVqOmjqJXt5IT28CIbqgxQD+D3gQisUzlViLcOOf3xBVec8rZwM
         2rbQsHVBcDDYjlR0HBxNtvIMSs/0f1jEL6i1Ah5Be+AeR9QbYPXdU6ChynJY0OFhXfYA
         Fd4QqS2TakHZSqvV93f6J6SG2odRRThP8TKVEF05j+7ZcOgt3Fn/Po05MEjOEuAnsRWz
         EzH4f1XNKjy5hLf2CQgvNH1a5GJDPpdLT4SPtWPlq5BhlAOevbsK3Mqna0Yr2inVxtRH
         FarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QBDazDOM2X7FA70xO+freU9rlh5XTVJr8JINQl4RCWU=;
        b=oFrc8c/0/oHEM1CQBpihGE8juzLISog/Be2LgK5+FmI33kVIE1I0a5W8d+zAFriLsA
         bJbxUJ4UMU9WJw/rirkmw0wHIwVB7INwdRqWtYopEFpENjx+JO2tKQwywyP0Dr6SBxsk
         /nL4Z9UBSARHcoETVzxVLI6rLPEqJTk82tRUFwfl0yZbzAxJU81RJw7BJuwkOvnS4qvz
         KOQY3vMMieuBHKEVJXGKet7UqyvhFm/370Z8/6P6IPK4F9dMihOpbMN0WcgAeKQ7Hqs8
         DWgKVRkIjvD1F/D0kYDV0HOjSXYMpKFQ6mRlKGnpWhj3vFQULg2RAsUe8E6ysAANpitB
         IMgw==
X-Gm-Message-State: APjAAAX9+IKkzmNECrXF8W9PvV0dOekPEJ4yivIYGYfPe0mosgXdyNPD
        +BraqB7dMz8ZwABUxCxouTs=
X-Google-Smtp-Source: APXvYqwChWOcfo60hRIMcjlLwn5Tgn1YVlHJTG1f190hzOo1p4I5EaJPzMWI+NmzZ+qKzQVb9ULp0Q==
X-Received: by 2002:a63:394:: with SMTP id 142mr12773017pgd.43.1567167426427;
        Fri, 30 Aug 2019 05:17:06 -0700 (PDT)
Received: from MeraComputer ([117.220.112.100])
        by smtp.gmail.com with ESMTPSA id i137sm6827671pgc.4.2019.08.30.05.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 05:17:05 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:46:56 +0530
From:   Prakhar Sinha <prakharsinha2808@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rts5208: Fixed checkpath warning.
Message-ID: <20190830121656.GA2740@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves the following checkpatch.pl's message in drivers/staging/rts5208/rtsx_transport.c:397.

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;

Signed-off-by: Prakhar Sinha <prakharsinha2808@gmail.com>
---
Changes in v2:
  - Re-structured assignment to solve checkpath.pl's warning.

 drivers/staging/rts5208/rtsx_transport.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d7895608..e61bc7c6ac33 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -393,10 +393,9 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 			*offset = 0;
 			*index = *index + 1;
 		}
-		if ((i == (sg_cnt - 1)) || !resid)
-			option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
-		else
-			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
+		option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
+		if ((i == sg_cnt - 1) || !resid)
+			option |= RTSX_SG_END;
 
 		rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
-- 
2.20.1

