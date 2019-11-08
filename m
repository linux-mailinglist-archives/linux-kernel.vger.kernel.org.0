Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1857AF4DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKHOXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 09:23:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55543 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKHOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:23:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so6352730wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5uQDbB03ZbZYa7okRjk1GbHxDUFyg/HpMEad1zcN0OY=;
        b=VXQdxdR3o1U/YPb4vlujX4lM16afpwzf5VAY/XAs0KeeTNQRdLy5Ld+J6c8jrJ1Ds4
         1HICGy19Z+Wf9aq+q7mIqQj8Kik+sLg7a22PT8uEvaktRqwWjtEdf+cOTB1g2OkafM2f
         L1g6ygXxlMqAF8APzc8JxMeTPU+FEUiSuUsRzlkbTRC5EmNM2rFvfQEpsRlRFBKmTksP
         NzwlBIDUJNox0T8y/gKYP5Ku+9aWZY8OtKCjBul+pFrCRH4k/YaZhpwIeGIdctBYds7q
         OjmZSXqUa1fK2vr08wmuSlgbx31wMC6DXXyJHGuEvdPCnZ5sX9tgbn0MPWSDClSe9c1D
         GWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5uQDbB03ZbZYa7okRjk1GbHxDUFyg/HpMEad1zcN0OY=;
        b=HrDP30t8RbuDemU2GtXpoo5sS4LF2BEwBxHyvAJ1U/cSSDzGQ6YVSiDQ++3DTwvrwh
         wuYcDQWxwyXjgacmBT7gkGA4+0O1a1wL2ELXqlIl937VbpZGuywi3n3I+TIZkG4II+EG
         p2IFXAY9desTyjVEEdSb3FSIZMfcjbnJYTKMn6K43m+nYHS7CqVM8AA0tBPFe5w1IMHl
         QNzvYED1nhfg7YXQa4F7HaqyvLeBvmpxWZtI/KEpiJB3dgJy4np9CPRb0eJwQYrAMzjo
         47QqpvZHFtUHqVT+lPlEtGJehoBAWnJBJ2gmL3oP+RGFKEM9/mjO6cvlF3kasyPfsFKs
         FU1A==
X-Gm-Message-State: APjAAAUp+QARvTTSDsCfPwn/pjmjghZu9/kpJv2XADQKzugPutCouPZH
        GKFEa7gmHMoptPAK32iHtW38N4D3F2iZbA==
X-Google-Smtp-Source: APXvYqxTHp1GM5ny1PYyWMnPJk2yjkyAhXAcFcXJU8A7AZ1IVfy9Tpxeu0Wf5K0+ml9a4Q3MjQvHgg==
X-Received: by 2002:a05:600c:2550:: with SMTP id e16mr8105043wma.69.1573223011229;
        Fri, 08 Nov 2019 06:23:31 -0800 (PST)
Received: from hwsrv-485799.hostwindsdns.com ([2a0d:7c40:3000:11f::2])
        by smtp.gmail.com with ESMTPSA id l4sm8869452wrf.46.2019.11.08.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 06:23:30 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:23:29 +0000
From:   Valery Ivanov <ivalery111@gmail.com>
To:     gregkh@linuxfoundation.org, willy@infradead.org,
        wambui.karugax@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: octeon: fix missing a blank line after
 declaration
Message-ID: <20191108142329.GA3192@hwsrv-485799.hostwindsdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "WARNING: Missing a blank line after declarations"
Issue found by checkpatch.pl

Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
---
Changes in v2:
  - fix huge indentation in commit message
---
 drivers/staging/octeon/octeon-stubs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d53bd801f440..ed9d44ff148b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1375,6 +1375,7 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
 	int port)
 {
 	union cvmx_gmxx_rxx_rx_inbnd r;
+
 	r.u64 = 0;
 	return r;
 }
-- 
2.17.1

