Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC78197B65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgC3L6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:58:30 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:41902 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgC3L6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:58:30 -0400
Received: by mail-yb1-f178.google.com with SMTP id t10so1354579ybk.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ1K5X1phN7beW28/2naiHUtsnsfPriBuUBHe9LpPRE=;
        b=Az4bL9vFGDr1K4y0hhsFH+xOvKKToQzN7JL9xNDwRlpLGXpvOlPpB5QuA1wpR1IedK
         vOthhhI/WFcAjr7evAevv9avDlMiSQHt/ut1rgvFf2zzr09aAngoh7Av+bVUCAUBQLGM
         0Z2xqetpu9Zg/RbAGAO/fiBnLEBthoNZG2Y1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ1K5X1phN7beW28/2naiHUtsnsfPriBuUBHe9LpPRE=;
        b=kMg6yCoRUDCB+EZmb2lguNBvjv075VEgLW2l11rBj30kLdRZihvtOvvtGNNf9QrbD/
         fCd+wVbJ8pNaPf/KLS66pi7s9tPXwEwJoONbdUKB0C3iGkbH4GJjRN89ON8eglo7he7j
         +3j1Fdxi9gZMKBXErlqpxCDL6PuKHMLPMxKHXViEPUZcGTS6KHKdYiu3g3lsHeVqHdPP
         /HsCwF/HhKeA0SIBLuJwV4pSRxYSFzFZWg9eV8aB4MWXdkDFO/HcpdVE58+7qIMH+Ujz
         /oAoOtzmNZRtMdQTXsHMelwSqmEdq5g3d2Vslk9BubJ1SdjcaYeWgwTOU0eFU/o/dMOy
         pg7A==
X-Gm-Message-State: ANhLgQ0bBsoT4C9w++DKkoRa/orMJvaNTHEtODp6PzFCKunrR/nY9afD
        y9L0ZlLlwqB9eU5D1iC8+hHVvvhqBn2fLWG5QxglOg==
X-Google-Smtp-Source: ADFU+vtuY4/KkBhkSck5B8WKc6bnlZp4dSirUh6Dci3jP9EzD3+YupYJ9TZ8C7a2KtaygPYZb89xdPw047tuL3S+HFs=
X-Received: by 2002:a5b:447:: with SMTP id s7mr19471531ybp.160.1585569508651;
 Mon, 30 Mar 2020 04:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200330110219.24448-1-yuehaibing@huawei.com>
In-Reply-To: <20200330110219.24448-1-yuehaibing@huawei.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 30 Mar 2020 17:28:17 +0530
Message-ID: <CA+sbYW1d0GPH+ztur6v-PzPiA4Y-GXf2ptA0hF=U6LgJvaBB9A@mail.gmail.com>
Subject: Re: [PATCH -next] RDMA/bnxt_re: make bnxt_re_ib_init static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 4:33 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/infiniband/hw/bnxt_re/main.c:1313:5:
>  warning: symbol 'bnxt_re_ib_init' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>

Thanks,
Selvin Xavier
