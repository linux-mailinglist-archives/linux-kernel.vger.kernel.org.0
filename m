Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D51146CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 10:28:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46414 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgAWP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:28:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so3855994ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Qr9BdbkkgkuLaABxg1maqPFbi8IH41Lo7L1VxAqiyw=;
        b=iGZFnSn+vi28+z3do2lW+WbQQJIwuMVk+nTR6JGwyfDav1RKSSd7CcJ6KK6LcpVCo2
         0fiNppfjuAfjdpSLuQenKgpCS4QV+Vufpcl2FY4z+ARDLnP0QoKMSlqBVFoiIMk4AcaP
         lY10C7psqauI55WjsxDwb5YlBe6knaX/slmuyLZvhmUMmFDoRBFAadi1km59bjfF5J4d
         kWzkfEIo6Hyh8axepy05Q0Y0SukHwLD8Y5KSTFVXhwDfNAMU65YRWb91H4NB0tbBm1YZ
         /lXTng/W2mJRJ1Q/Wi2BdLzvpkQQ6oKyIgnKelSCPWF84hqCw0+9+1BojMj7gyxKItx7
         jPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Qr9BdbkkgkuLaABxg1maqPFbi8IH41Lo7L1VxAqiyw=;
        b=qChdnpytxiJh0c9F3BqGNRALO50aR8zuZnvJGHh6O/wQJ6Hg4k03QYEfabPj/a+A5C
         3iiGta5Tlg85L4RnlWaB/5toVOrE8pBkMFCre0J8bwEwUZ6GZwz6isDJ97jif9CDW7h7
         vpkeq65rFRySbpsE0CIIFydbTlDRr3aOn/gBAU/Vgr1iPaf8JufQnZmBXz4ElolO1hDX
         h7/UPJHAhgLDMFVWY5m2MfHMxmPVGpsWuuIQzfPGhhgni5BhuXmRPz2mXal4VdmjWj+l
         Sylzlq/TJHUxTKzucxfkelmTN7qjDqsQl293vBvUdXczlQRcfdA80Vzkr/cwLnG8u7pp
         DCRg==
X-Gm-Message-State: APjAAAVr45jCjvQPd4sXTiP6e/VS8770Y7evPnfaXoU7wWbqX8j0EQih
        MJcbCRf6yavbeGHTkprBVb3Ym/3frmKkRPECv9Wtfg==
X-Google-Smtp-Source: APXvYqz9aT6DBqL1eSjmsf3APA52AKWR+11VI/tOJBRr1Zl3oa9tmU2n9K3uxQplpdd8BuXZX19EDE3gZHHtzgDtTcc=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr23654693ljg.168.1579793319446;
 Thu, 23 Jan 2020 07:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20200121161757.1498082-1-colin.king@canonical.com>
In-Reply-To: <20200121161757.1498082-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:28:28 +0100
Message-ID: <CACRpkdYzd13xu9ETj_a4eWrm4FMrVnF1NQ5G+=d_Ch=6SzRoxA@mail.gmail.com>
Subject: Re: [PATCH][next] iio: st_sensors: handle memory allocation failure
 to fix null pointer dereference
To:     Colin King <colin.king@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 5:18 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> A null pointer deference on pdata can occur if the allocation of
> pdata fails.  Fix this by adding a null pointer check and handle
> the -ENOMEM failure in the caller.
>
> Addresses-Coverity: ("Dereference null return value")

That's a weirdo tag, but I suppose you have aligned with the maintainers
about this.

> Fixes: 3ce85cc4fbb7 ("iio: st_sensors: get platform data from device tree")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
