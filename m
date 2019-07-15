Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB569479
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404886AbfGOOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 10:51:42 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:42388 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404198AbfGOOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:51:39 -0400
Received: by mail-pl1-f176.google.com with SMTP id ay6so8411026plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BKSJgT6whNkC5IhAzvavX76L682ogf/O2G93SLLSkJU=;
        b=b0d2J4xCCm0KNw/qj3HIU8dYECM7kBb774a2roV1NDXUzy40acvViTNPkLvMpoeVy1
         CFSHyq1ZWedJfp86ClW84qNkq1AjRgF+v+RZqi0+inn2UabmAyUxV8qNJIZC6G4oO26n
         w29BK0hVtBXD4LwjALyTVznYtlCg3Qm/ZEq7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BKSJgT6whNkC5IhAzvavX76L682ogf/O2G93SLLSkJU=;
        b=BymwSr4b9coygjgXJ79BF2yx3Y9yhuWoiLWjgR3iY2Wir/QZbmlaFAMvTrHSxxzfq2
         GwR8w+YUAeJS7+ShDDjGXQXlTs/mcLcGTvKKlJeItzfMDEKNLQvxPySg9QnqaK3i3ZE1
         vakYitxrrTzYbc1F5wDBuOUdv0uaXmAyqt32VSO413FRVyuzgvJq1jFUlxq0vNpOt96o
         AYvdX66B+IDl4BZwFj9/PurKW1vAmpRH6+aueL7Mc4xQCnOD8519Z3MjdVU+3uD4SCBo
         qRbYWt61Tp8hduGcqeGzHtnn92Slat150x6kJdtLj9g44H/MIMa0wC6YylN8LBJUurJU
         5keQ==
X-Gm-Message-State: APjAAAVgEUgxoA+dE6uP7yDZfR+QVGQqeGlKYHlvK2k8qU8dZqPXBIkI
        SVf7E+ZOgQPS8MhGfXtrjUXB1A==
X-Google-Smtp-Source: APXvYqzs6mlTcK+ml7tdLCyuJNk2RhWR6UrxxN4jOQP+aclPWgn+HI40YmyK+mAZDxd/IftfWFnwrg==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr29180895plp.257.1563202298366;
        Mon, 15 Jul 2019 07:51:38 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 30sm47698095pjk.17.2019.07.15.07.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 07:51:37 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Remove unnecessary null check before
 kfree
To:     YueHaibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190711141037.57880-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3a56b01a-27e4-6ebc-0e99-8a06a2f2f75f@broadcom.com>
Date:   Mon, 15 Jul 2019 07:51:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711141037.57880-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2019 7:10 AM, YueHaibing wrote:
> A null check before a kfree is redundant, so remove it.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 4 +---
>

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james
