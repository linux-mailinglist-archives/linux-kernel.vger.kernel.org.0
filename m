Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB67907C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHPSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 14:33:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44769 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfHPSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:33:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so3509629pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1+ao2IBwUTG544LcgLQFxtptIi4HS1pjgmRhYbngM2w=;
        b=Prdco6OYMZxzOli44Sj7mjMEKbDerzpJ6ALO0/xuB/kuNWvjc7JA3dLqsa72S4xF5O
         rcLre3L/hA//mtWgW4kWL92XZx4mGcIxo67zNRepDBGyoVrecz2tcCxRBBI/nCZ5gKCb
         ipfz1BhUy6JZmbc5eOEZALr8DP9Ty0hq4BhUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1+ao2IBwUTG544LcgLQFxtptIi4HS1pjgmRhYbngM2w=;
        b=Ulcm7M72C0XyCvzr8pWUT6xzNkMfg6E+qIsIuvRUMD/X2Bv6YwNfQdv3QhCCzJHpp7
         nRDPLkPgkSjtK1ZZfi9xQLVb6OWXP8QayqGh1RKxvvpRORlVdvaL3LnIkaK3TUc/5Oj+
         E5iEGj9+t7Kny2ZVmQsb+VsH7DIc05KpjjnqtjExVtBaHwCl1BW4qghqhkJucV37hNIG
         fh2dFWNc+EFG02k1pOTRtdUdUKmHijTYy6v5hQu1z2wncu3FX4bE9cl7S5EBaowr00r3
         W4Pj2SMZYqqqsX0UmWcr2dW3R/QfyyBzTJNHBWa5qhFDC/3+t4Nmz17pqyXFenkCffBJ
         pAJQ==
X-Gm-Message-State: APjAAAWBleRNDKutAV14Smayw0USlSApkjmkgimtMxif4wjqopHSg2ua
        B2+oRqRBPoGNCunpWgAEj85nrAVcV9srDdIxf3M0mDZBFP4f2SHM8APZosCOKhDaEO3u7rlQQa9
        gAtZ5SZBTa96gO4+O5V1Gj7iCFUiO0vBwH9Nb0bpXBSZw+xQ/W3pCpcjqoRVaZmwXznJCy+HlyB
        ffNCo=
X-Google-Smtp-Source: APXvYqwg+faC+jvNrSMwHumh7wKDELq4+16i7m0qeAubzIgvhRFJqOQN8XmRXrWTBh2V6AuSQxo/FQ==
X-Received: by 2002:a05:6a00:8e:: with SMTP id c14mr11752890pfj.241.1565980415871;
        Fri, 16 Aug 2019 11:33:35 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fa14sm4949344pjb.12.2019.08.16.11.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 11:33:35 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: fix "NULL check before some freeing functions
 is not needed"
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190721114229.GA6886@hari-Inspiron-1545>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <585302f8-0c91-4c25-94f0-09aa1525142a@broadcom.com>
Date:   Fri, 16 Aug 2019 11:33:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721114229.GA6886@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2019 4:42 AM, Hariprasad Kelam wrote:
> As dma_pool_destroy and mempool_destroy functions has NULL check. We may
> not need NULL check before calling them.
>
> Fix below warnings reported by coccicheck
> ./drivers/scsi/lpfc/lpfc_mem.c:252:2-18: WARNING: NULL check before some
> freeing functions is not needed.
> ./drivers/scsi/lpfc/lpfc_mem.c:255:2-18: WARNING: NULL check before some
> freeing functions is not needed.
> ./drivers/scsi/lpfc/lpfc_mem.c:258:2-18: WARNING: NULL check before some
> freeing functions is not needed.
> ./drivers/scsi/lpfc/lpfc_mem.c:261:2-18: WARNING: NULL check before some
> freeing functions is not needed.
> ./drivers/scsi/lpfc/lpfc_mem.c:265:2-18: WARNING: NULL check before some
> freeing functions is not needed.
> ./drivers/scsi/lpfc/lpfc_mem.c:269:2-17: WARNING: NULL check before some
> freeing functions is not needed.
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_mem.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>

Thanks

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

