Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2351667B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgBTT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:57:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44347 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgBTT5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:57:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id g3so2442084pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nAWUMwqWIY3D/+QdxFiIISW276z/h4/mNno+zWK07qg=;
        b=P2WLVKSxLVE+j1O5y1/8R8pwftnXEN4wmqmnrbX8G62jgG7VL0X9hO/6YJtURSyR0/
         L4HnS2KANSaFhLG6F5VcjMCfHlGJpLiTfVhx5qAL/ihQFtwbJJfzQ5utWx/gdlfWrRw+
         WrcIimideYR1TlCO8Eh9Q0DGDHltWXvV5mmIO3bW9Rz+4iNnwvKOxcEMHzf7zTDsdpmB
         PvbM7Xqmxl5CAzI4NIPn1atiowp9M4dFmnOrHwUnIE9Gsxbp2kSAkjUj8sH9NLopjEs1
         im5CeXti/mz0O+Fld1KX12OS2PwrJ0JdT8qW+vSBWQmAoeNDVr+8/mhkKEeWQWhF44xW
         VW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nAWUMwqWIY3D/+QdxFiIISW276z/h4/mNno+zWK07qg=;
        b=tgPqUzbjrJKRhuVRZg0j7kmI7EMrsvIyigd8j4ehHKFGKV1rXjtqISbG1gJB+87dZ2
         sH2IXtO07FNqS5hxXUxfjJJ27FpuoCTkK/xVQqQcOgXfPnB47vuIuGYbjuuo5wz56Atm
         KvMvKbayv0Y3irJn0AkjyCVbB8SbsbRZL1cRq6iu+Ab/io8tkbnztAiKJEvcMhArqOva
         Ja0bDeY8BVQQ7s5NSNb5u18uioNtDk8t4rDbrD3OYO2iF/jLOkh8m/pHhm+9jk/eIdbL
         zWkYsOlJTOyM6ecAHdQD0v0JLsnFAYT27/+jq+qecl1orEVXoMEqZ3h/XGJLcoKmfUsN
         SGkg==
X-Gm-Message-State: APjAAAX2VxdfacD5+WQm7SBdI6+oW+tkKHyI5rLEviY+m9/9btesCRnZ
        SnkW7/fM+zDCF+TArPSAlIrnMA==
X-Google-Smtp-Source: APXvYqzU6fsfiC/IXBiENMa+SEW6bd33sb3C4yGSiGYNHLrfLFHW7InCbZ2ReCslsOL5Wox47MuSxw==
X-Received: by 2002:a63:30b:: with SMTP id 11mr1935326pgd.275.1582228620091;
        Thu, 20 Feb 2020 11:57:00 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id w18sm154305pge.4.2020.02.20.11.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 11:56:59 -0800 (PST)
Date:   Fri, 21 Feb 2020 01:26:54 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: add blank line after union
Message-ID: <20200220195654.GA14056@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a blank line after union declaration to fix checkpatch.pl warning

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/octeon/octeon-stubs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index d2bd379b1fd9..ea33c94fa12b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -382,6 +382,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 		uint64_t reserved_41_63:23;
 	} s;
 };
+
 typedef struct {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
-- 
2.17.1

