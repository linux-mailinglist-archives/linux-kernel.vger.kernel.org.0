Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41074137509
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgAJRlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:41:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42622 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgAJRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:41:20 -0500
Received: by mail-io1-f66.google.com with SMTP id n11so2931747iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbQyo97E12JiQyYySbTSdZx19yjj8JSBt+Y0Mb9k/oE=;
        b=RKyYJqPd9zuWTcr8+5KldE2tUJzeO2CN3ViQHERbo0EJnK2GKt99YpaYTAiJb4Ru7V
         L8jtDu76+CEmTMv/62SLLtA8lhEBzxkCF73LFgIxoIsYtEdYhrLfX3WWUJvzkxnV+PlD
         mY/KFBBHoV3tFwOisY9SqD34FzfRtJwFsIk+FQMKE8iZ0H8xlTySuNZDVTzQaGrcxTKk
         hiz1QSdziqkh/JXGLpAlkHsD8uJvusD+mkaWRJmUG/BAV27rUpTMCCJRDD/eDgRq8ct9
         Ht8ybkxZGyzWdDDy42ylwsuJy1Unws2UoLugSiKDK8AhAtZ+93BVEQKajyLwFEqBjKyE
         +jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbQyo97E12JiQyYySbTSdZx19yjj8JSBt+Y0Mb9k/oE=;
        b=RiI9y0XeLslbgRXEDL1SzooZrtYaIOBON1mnsuhticpwzZtoY+vKwC0d57+B3EViH/
         aml60i/tGyUCxU3FdoIbrgc7bq98Du9iqHQddiQKdtRHHEDblP+KXOHNayecORdVXcaw
         FvLjayc5WY7QHztDpXk9+UVNyMiyoYJaellaOskNZI54QI08s0bYo6IBtuCi44X+JgJl
         gsJxjzAomJFM6RxVJt4+0qopzgeqD4YEr78hB4deDg01YNYPPTVFTVqr/sf5nmc7OBv2
         Us5rivdT6thm8hoBOhIqYn6BA+bbPl6fLXyAW60W7Z3oXcjv7/fcSgZ5vLLDaJRqkzlM
         C6Vw==
X-Gm-Message-State: APjAAAVl5Mdae6NTknMoXLc731/fE/b76GJpYT+tvE7FL/5/2Q8XEN/m
        qe0qmi3ULVwQbrbigtWDn2ZkQQjq3hxrVz6ZYzJ4HA==
X-Google-Smtp-Source: APXvYqzxTQ4SoPYj84MBP2256b9N8PKJf0z7eKjlQ4rhKSqiQW9tWF5+C8Bg+6bi9ottTHxKKTZIFAGBUbF/pJe2gXs=
X-Received: by 2002:a6b:3a8a:: with SMTP id h132mr3396308ioa.207.1578678080202;
 Fri, 10 Jan 2020 09:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20200110063755.19804-1-zhang.lyra@gmail.com> <20200110063755.19804-3-zhang.lyra@gmail.com>
In-Reply-To: <20200110063755.19804-3-zhang.lyra@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 10 Jan 2020 09:41:08 -0800
Message-ID: <CAOesGMjNkVpTOhSrLUKjNZnKFk55DTgg29QzVBEFVh3Z=Ra+cQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: Add Unisoc's SC9863A SoC support
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 9, 2020 at 10:38 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add basic DT to support Unisoc's SC9863A, with this patch,
> the board sp9863a-1h10 can run into console.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

You reposting a patch that we have already applied, and there's also
no changelog for it in the description.

If you need to change the contents to fix something, you need to send
a patch for the delta by now, with the usual expectations of
explaining why the fix is needed, etc.


Thanks,

-Olof
