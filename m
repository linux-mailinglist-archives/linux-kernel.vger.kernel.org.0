Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4528A7D609
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfHAHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:07:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37941 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:07:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so40762251wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zKS+bHOSYnyT32IPvAXO9rhh7LcLf3miOYkXJWe5L4=;
        b=dWrBmkFn3vVe7tzKRYyjOAhP9iOvoPwRcJ+f1L9bjQCjHEQT/Gcm6d1goQk1rH4SoB
         Mm3i/w296UYLfpg2VEljZ7JynmeDSON5gpNNeQo9akA6QBdvdndiPje4wRZeW6sknNVt
         3s7euiDANySVHdZRFoqvvXP58bLXAeM8ne+hOaui4UNrTznEwH7KC+Z1Fym9RmNaXOiT
         kmaUtkCmujuOBn99xFoqS6QeKbTgoFxg2FjFjkzIUC8uArAtMZshVkdwp0PAGmRZRWoL
         ygoLCV3MJGPbn1nKJD1m3gDBWXw126bKtoqaIEboV58sKqae675+raNZY2ZVnENOHSgA
         XrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zKS+bHOSYnyT32IPvAXO9rhh7LcLf3miOYkXJWe5L4=;
        b=oN7iGbYu1Fv5a3M2qTFNp+p12zaSYT9nljhNV89zayORBAYxzw8wQlDliOXE3vy1X+
         wynvFfGOQLj+IpNXZskZ+x3RAEG1g0fuIDiMtehdEcy7+bw1d7aqzppsDN2FCxlusC0z
         4clFdIfTp1DGrOoEHHr+x4zSyoeAev+ng5C3ANr9Lg9bq+GjTxnDsmgFFOIkwdY1pBKi
         pth4pUlOkrYTZMHFkPusvfvpI54gMikv9uhrojG+pS5U+Ab3CNcn98UVMC4s985P/4kQ
         w0p5fEyGPfPG1oQP/xhZz1HxoDUmlpsBqMIS9cSqDL8qTyiYmLYgZ6ud2GvhPNx6Md4F
         5Yiw==
X-Gm-Message-State: APjAAAW01DaoSQhFzPLDn/aX7qWfkiJjGsu2BpZthxS57AGzCahGtwn2
        AFpowavGe+PvpYSXS/JXJpcei4rvykyOyesnPM3grQ==
X-Google-Smtp-Source: APXvYqxn8QMZyUJF1yqlNdxeuz9kgUitutcq7yzpiuVeQyEV/36zZBJj76nPfArr7DZ9GPlU2VJmM3gn88wCcDp4qGA=
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr12874903wml.59.1564643265374;
 Thu, 01 Aug 2019 00:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190731222214.15720-1-colin.king@canonical.com>
In-Reply-To: <20190731222214.15720-1-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 1 Aug 2019 09:07:33 +0200
Message-ID: <CAMGffEnQ7oRebm9QNKQUcx+MQan1tgQWw6R=O081qbm1kKSw9w@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: remove redundant assignments to variable rc
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 12:22 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several occasions where variable rc is being initialized
> with a value that is never read and error is being re-assigned a
> little later on.  Clean up the code by removing rc entirely and
> just returning the return value from the call to pm8001_issue_ssp_tmf
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>

Thanks, Colin.
