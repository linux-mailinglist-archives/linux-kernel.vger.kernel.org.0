Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6BF3A84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 22:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKGV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 16:27:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45471 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:27:51 -0500
Received: by mail-io1-f65.google.com with SMTP id v17so2879318iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK6q6zrwrUz/2YQcdvxZ3HcYVjvB9LVJa0VW9PrlQgw=;
        b=aMxarZDMn8/+ZTwLmr9xiJrCEyYnzUCeulkISZ+VWIkgM2+Tvg/SIBgLvqCdvgYaro
         7TWwstCis8HR1f+02LH8TxqFrrnfPmbocmfts3bNK6vn+paq2D6upM3h2Dh8ESWimLfR
         7KDp2SG/mmMF+UO1dGo2RVWC0kCR+t0kBzEWplgAndmgir7SdBPEgg+suEYnDu/q2+9R
         Fxour4E/NUcSYDTcC8UOg8KfyYNM792kAl1V5PMVpJpul8vApR8iDeS3A864PM5hz26l
         ceuQ/OlYDJHb0383d+9hMlyudwSg14ciUZ763g7KhMhGHDfIGmhgqb6gfJ22vYJaSefe
         BYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK6q6zrwrUz/2YQcdvxZ3HcYVjvB9LVJa0VW9PrlQgw=;
        b=pNu0MA1zkiJzgeZwHO6jHcdFXM0WmKP40jaqc2wMxg6mcI7HUYwDIxxEjn1aYv0W3M
         jDmk9VaGLR1XuMHA1xjtBWQVmTerEp/omX/mXhCP55Q/2gy92kr+EPYmhStjoC5W7cyb
         3BCPJcphUrbre8sK/GX4rMolgASBt8FGV4tTPTtpHU2XzUt8owZJaR6hI07gyA0MxFcR
         nzZS5k2kPiM57EXFLEzjeMozHhTJddp0dIGqwje1JZZ/Qc5uYsN7fu5+snpCouoK4rAI
         1xBtiUkX8+HNJvJdNoEBNKWdR0yhI7MbpuZcMwhPIP9ISbl5vlREkHofuXOMHSah5mdR
         Jdkw==
X-Gm-Message-State: APjAAAVN/jqHYRiElifotzX4JzN42H5LpoLMroKXgP51jwq+26z+1I6F
        h17nJVOoLCh5ixZEGTf+OFspF5dKesquPRK51m7IFA==
X-Google-Smtp-Source: APXvYqwVNe1X+M1QlsTXNL6HXP3xspn+6r9ttBYU8x8guIj6e4OBIfBd4K2Rxf8NXF5PTW22eei0bYBqCz+ztKWoy7s=
X-Received: by 2002:a6b:e403:: with SMTP id u3mr6358356iog.130.1573162070942;
 Thu, 07 Nov 2019 13:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
In-Reply-To: <20191107205914.10611-1-deepa.kernel@gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 13:27:35 -0800
Message-ID: <CABeXuvpYE9FCdX-FXTEg-rN_dtoxVn5+2psgU_AxPUPk38fQEw@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     joro@8bytes.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 12:59 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> +static void intel_iommu_shutdown(void)
> +       if (no_iommu || dmar_disabled)
> +               return;

This check is actually not required here, as the handler is only
installed after these have been checked in intel_iommu_init.
I can remove this in the next version of the patch, but I'll wait a
few days for comments.

-Deepa
