Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC518EADE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCVRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 13:30:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37735 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:30:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so4055990pfe.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4ZoVQ1c9ycCJ8Gj1lfk5UAo2vuQPMTOZvWhGMpvKEUE=;
        b=e5+mDZWLNRbJUuoqDXwBJW5YIqPp6MblyeiFGTFz3gUtrNwjYD7VVxg88u89qdnkNB
         YonZUzNE4K4spQGQQaxpmB/zxewAiyjExivnkz1SukOWdnYfY584NrKJvaeVHq2Pfwzq
         AQtbrNIz1px0DMNltutapcWkEHl1kNZuBO1qKZFNA1xoQQiy2R1L2T4Mih1YSf3xqsrf
         eB34YXdekCSGzYajt85QS/JbkjkO7qM0/Qu3irCQ8yM/ifWOqfKo3tSo9e2GrcA6MGmP
         P/0El1GF701OqtbedrdpRjuEVfCjiuFelVm40Q+f2opsVKz4fzR/qDmFn5eVPbgoQbwb
         p+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4ZoVQ1c9ycCJ8Gj1lfk5UAo2vuQPMTOZvWhGMpvKEUE=;
        b=L53HqbRXMTpQNtyY67pszI4G1JfvhXGj/F+0C7E8CH46SZXi2YKul4q+wooNAvArm4
         rAOvQW1YjexldZkJy5bK/pTftfh8KDh2XuUDiKS18kcZTJy2ClMbPLvuxn5P1ohz7RVp
         8LLY5HT2zZlevAxJ1o03TF07f/6fSjUzcHkdCr14ZmsOCPTLHGDs8JD7DU8hgQ93sj89
         OzQPCxBmG+UqTwFtIsd6oiiX9uGaCJL2pAqHy7nylvYH8aYo1EALQqUlrtjowhcHIShS
         zEiS0MDoNPCQWRk4Z5Iv9F+HgLTK7xKms4zCiwTfvBiJ5dFSAQndYW7VHKw79/zn9ghS
         ICCQ==
X-Gm-Message-State: ANhLgQ02qeqQa8Yaw0CTuOadEGPtgLfJhwrv/JGbfv5XUuxpcJvCNOop
        vyyxIcg9Eh+YpRaE3aXOg2B21Ec2npY=
X-Google-Smtp-Source: ADFU+vsc9Fkdk9zntgPTPaN31WhDeuT4qIt/2hez13I2SE6xGSsiXmMfBlFOK/tcmzJE/O3ONSjnoA==
X-Received: by 2002:a62:6244:: with SMTP id w65mr20692876pfb.89.1584898250652;
        Sun, 22 Mar 2020 10:30:50 -0700 (PDT)
Received: from simran-Inspiron-5558 ([14.139.82.6])
        by smtp.gmail.com with ESMTPSA id f64sm11732499pfb.72.2020.03.22.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 10:30:49 -0700 (PDT)
Date:   Sun, 22 Mar 2020 23:00:45 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: greybus: tools: Fix braces {} style
Message-ID: <20200322173045.GA24700@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the check reported by checkpatch.pl
for braces {} should be used on all arms of this statement.

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/greybus/tools/loopback_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index ba6f905f26fa..d46721502897 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -801,8 +801,9 @@ static void prepare_devices(struct loopback_test *t)
 			write_sysfs_val(t->devices[i].sysfs_entry,
 					"outstanding_operations_max",
 					t->async_outstanding_operations);
-		} else
+		} else {
 			write_sysfs_val(t->devices[i].sysfs_entry, "async", 0);
+		}
 	}
 }
 
-- 
2.17.1

