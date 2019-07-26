Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF61C7724C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfGZTmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:42:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40497 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfGZTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:42:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so25242697pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LccYF3YyT8jElndL9g3VFRbu964seQMm2G7qLpuIBD0=;
        b=Xb7uiAMYaevP+8U/djYvb9TiTim6fNVGFYLLMwH3TQm9FLQMm56swPv7bjjltYFGUh
         1e5YRchOniNKrWT2u84QQhjOFF//tifui4aIq+sLOQ3WqxTKNMB/q/2m5vkd65QOq/Pr
         /Ww+/FVIq0SVBzIHLvo5pqZQbO0eN40dN8BIP+405cli333wnbmP/BvqN6YSAbaL8uMd
         qt56LW6iMaVyXKD1FZOp1QcvsaxuNxNya7shIQHvzMRPZDk7kbFmC35XGoPH2oAS3g6g
         NcY0IzrZuq/ZbH7jizeyGpRF9S+m5qPh7w5E8ppCgTlY4DG5eEop/hvsDtA9k58kE0F5
         heBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LccYF3YyT8jElndL9g3VFRbu964seQMm2G7qLpuIBD0=;
        b=ak6Efjj+WFkf9nHub3sfBe+Vyw7JoJyT4Ai1BoRIZxdkRIQb4ZLW8yjUNkqH1dXVuH
         +LT0rJwz6BL2Gje6SMwmn/gVPzMLWb9tTVrQanCM0paQCD12+ML/r88Q0gTu35PD96Xy
         svhCPcHfm5dorr4YE6bph8msYt5Wh4TjkNN0NJQI00oEHCMnibDExwZeIcpyy7OBGTg3
         2C0mGgzYmg3fSl+/LbVe3kJxCOfDE9fuelKXJabCwSOuKkbOR/pgMk1FF2R2lJ9sKTWt
         QNAiQgH2T8jY4NErzTreFsiyD8prMKJKjAnUxlqFYXY8/+A/OOIljUF4nY7FemDIS3N2
         wyCw==
X-Gm-Message-State: APjAAAUCToDQBtz2SDi7nNa1mq0nCE+Ko/GUS9ACWbxMANLKCBjSZabj
        +kmNAmzKlrNxRtyWJnQiUkk=
X-Google-Smtp-Source: APXvYqxD7hMpjBx2zGWbAQfPanVVJhpbkH33uz1mN4dXyB6mZ/MLhVMwQ+aBcGcGS8QM95MErj+LqA==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr66907199pgv.315.1564170132800;
        Fri, 26 Jul 2019 12:42:12 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id v27sm73348910pgn.76.2019.07.26.12.42.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 12:42:12 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH v3 0/1] get_user_pages changes
Date:   Sat, 27 Jul 2019 01:11:59 +0530
Message-Id: <1564170120-11882-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this 3rd version of the patch series, I have compressed the patches
of the previous patch series into one patch. This was suggested by Christoph Hellwig.
The suggestion was to remove the pte_lookup functions and use the g
et_user_pages* functions directly instead of the pte_lookup functions.

There is nothing different in this series compared to the previous 
series, It essentially compresses the 3 patches of the original series 
into one patch.

Bharath Vedartham (1):
  sgi-gru: Remove *pte_lookup functions

 drivers/misc/sgi-gru/grufault.c | 114 +++++++++-------------------------------
 1 file changed, 25 insertions(+), 89 deletions(-)

-- 
2.7.4

