Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC80184EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCMStQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:49:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38775 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCMStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:49:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so4679532plz.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=290YlVmLLJJCRCOssjWMCt+6MQ1MCmicBbphMv3GKW8=;
        b=a//WCCTIxbhDJJjElvavoIj0VS8lmbZBNll/awQhVSp5zV/NoBNUmnd30LnTqTf4iR
         noMvqM4z510w0BljkxbNQVHJLLh8sqcT/0aFTEvXNnlvhxBSI2g+WhCyTfRz7WqSrglg
         VCvP1dSyj9kRgMVETR2vWRcSXNNl2sLozXt1fGZ+ygyV49WxLG1EkwQhkKBeMpLkQI04
         FiADtQyAEoOx5gbFXJF7uRzKbEw3cUgB7L0qcM07g9ecSfMbaQrEdC0rKNABZmJDMhbm
         PwSbuqAvZmQAFQHtIP+dwFRdW1BWOcSxsZhTY+dQiSPEbBmSM9Q8LGdB3K1AVtblT1sY
         Tc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=290YlVmLLJJCRCOssjWMCt+6MQ1MCmicBbphMv3GKW8=;
        b=tq83aa/UlHoCdIIikW5iV/yKMZQG16rc31PLTfpNjHwRC+vuUF48zikAHrdpKZDJek
         6bcjQdreXn7a9O6zGAh49C9oILeT5FtI+piE6BvHOtYMd6OZGcRrju5UoRnZPKvZ5usI
         NLxBNkji0BO6yGmZFRRb4WNwYy4XTJHLZsNMSQ90EyNRBi964MEu/sxsibjPXGyJbvBE
         s2/oA2rob6/H2NlJytDgFUWuytNPax1f1lYZqB5ZavEf/0jhTVd/7fKa3jyWEbEYdJ+R
         cAsuqSVjoQMSCYYDIqmRcxyT51AYzEFYr/EW1N4bGhfRtD2yhjwHH6DG37kWzQAk6TSa
         W7lw==
X-Gm-Message-State: ANhLgQ0jW9N/iCTJYc5erENHkf73Nird1UYSnLUOXNg7cDoLbUbVKqLT
        vGCfqD5fsrFoPxzU12ePEqlVPLROpvY=
X-Google-Smtp-Source: ADFU+vt9smw2Ms7j7aSyz07798hwnZCsUi94kWwcs60oW4y2CSgQ+ltkGIe3P5nFTpkPHSgK5ku11g==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr14446314plz.292.1584125353885;
        Fri, 13 Mar 2020 11:49:13 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id 18sm60087181pfj.20.2020.03.13.11.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 11:49:13 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     willy@infradead.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 0/2] radix-tree: fix some errors in comment
Date:   Sat, 14 Mar 2020 02:49:07 +0800
Message-Id: <20200313184909.4560-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment.

Qiujun Huang (2):
  radix-tree: fix kernel-doc for radix_tree_find_next_bit
  radix-tree: fix a typo

 lib/radix-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.17.1

