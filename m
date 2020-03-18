Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12000189492
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 04:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCRDnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 23:43:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42518 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgCRDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:43:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so10552156plz.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=hn2QLLz9khl4vcZxxszhtActpJYIvuOW4xfhxWZL50c=;
        b=PEYjyoazeRvjqPX8Fgm3qhBeOjYCp+u3knhdGXyXoA8V9dl0Uv8uoO+ZQhUM2vIrka
         m9XI85e57E58VRno1fh/af3fsrVhshjv2u4H9dJqw4XKbIxseRGUwIVPFwIU/8eHo/0i
         XnC6HoMESr2tWl7owoB+sRsYMfYZ+f5P7pY8j9rMJrobtYwpaCoKKxht03mwuAth34Pb
         w/2+5fUtimk+QROIydFso1IXaM0XGrAxBvrCJx3N6bi8nTZBE+yx9T+SeFGTMYl1xzuz
         /5Mf9X0NbfpH0uyM2SVeCWyff9xty8l+0I++5D1JIfw271+g+UBUehkP17oepua0jMD7
         yhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=hn2QLLz9khl4vcZxxszhtActpJYIvuOW4xfhxWZL50c=;
        b=TjsvLRW6Xh2J3G5j0212IFqydm0+zNM3veJUIFwhrLBSRg1VjBD+5a/OmyHByc1MfQ
         SZS3GfaoxKePKnigcW6XCk7AjOKurRxh0EnbT1MHIEaQwMt+6e8kAMLrTy9t8byuVPj8
         +Ht5sGmRY8EcL6xTCxKRrFDQIWQpqnM4oH6r+a69KLa3fNnvtfed6fYURCiaYNS/b3Zc
         KobFIiSGvl6nE5KHJhVnHvaSv/CXjGTVJHDn5gOdN2EAM9jTZ8rdMX95GwtlKM4Sx6uo
         xalp04yyeEv8ipPrtBWpAkw9p+h9q0KWFny6WprehuTV8bOGoQr2w/rl1JEsTbooE36y
         cBgQ==
X-Gm-Message-State: ANhLgQ0pqdWW2erP6oQgiy16It/FyfVPDABS9mDLyMWKIUhBN34gp8/G
        6CFLxJ/geJruyH9cNnfsEPzF2kit
X-Google-Smtp-Source: ADFU+vteli8ngKOiMutwQwv63fWPl8oGgc6GWSUuDOnhPhmYgfSTFR3jqlI+rcHMF6SijcpXNUBqsw==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr1734679plp.77.1584502978982;
        Tue, 17 Mar 2020 20:42:58 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id e24sm4508817pfi.200.2020.03.17.20.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 20:42:58 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] mm: Fix a comment typo
Message-ID: <0783042a-244c-0c2e-091d-e7002718d73f@gmail.com>
Date:   Wed, 18 Mar 2020 11:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Chunguang Xu <brookxu@tencent.com>

---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780..2acf754 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1271,7 +1271,7 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
      */
 
     /*
-     * dirty_ratelimit will follow balanced_dirty_ratelimit iff
+     * dirty_ratelimit will follow balanced_dirty_ratelimit if
      * task_ratelimit is on the same side of dirty_ratelimit, too.
      * For example, when
      * - dirty_ratelimit > balanced_dirty_ratelimit
-- 
1.8.3.1

