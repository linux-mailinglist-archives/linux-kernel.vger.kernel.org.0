Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB50FFA9D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfKQQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 11:07:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34940 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfKQQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:07:02 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so13702863ilp.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 08:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uS4LgT4jvENLa8rsriScWM6XKaZKeGJUdSUfbJgFR9Q=;
        b=uSCyKxORg+/h0PESXpWpQcbCRC9CmxXmwQKN1IdqP93Ja2+hImSW4ecRRH36sBNOAz
         Nc7W0Co5B9jzpeci/t3vCqhi5OS55RCqhYK0xOJTAvFr7P5Lk4XbBpnn6eFggUZ1Pjy+
         4fChuXZAtgdhRPmKM0w7j3HGdlkIHiUKQxkvbH5gvL+UnmxBoVb6AvWHo9b/POwB9B8x
         wJ/2ho8RPwYl+BQ6XVdN7qmyDDJnmos14k/f4VpzpEwmsSA7eG23cdK50NX9FNpTTbzA
         NeDv3rrQ2p/tpFy3wjdfsWfuoZtlAai3zIBZUgoGwviRkJ9LnTPsFPe0NNlwZkRYQ7r2
         O5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS4LgT4jvENLa8rsriScWM6XKaZKeGJUdSUfbJgFR9Q=;
        b=oZK+COt5pPd6hXTUo5HBNwmPpXgDnPkHvgu3WUTfadgsC11YzeG0DzPX44FMeAJoaV
         7MMfb30zlszhrrin2a87vMuW2rstkxcPXP395lcFp5DkbTRCgGxMlSFCDmpZbT0uvNoe
         kU6U2vZ9YGNhEBSsHCH5mbkWuzBp6vowgDs7SYJWw9Vel1PMTz1aRB25r9Q8z8guqwe7
         YsTHBJbbmKcl0UDp0ySyjxqsWHmaPbfZU/owEeSGiEhhgDywF3woFeHnxVq7TahiADkO
         wFNRqcbJdDZTwzOVt5Hyna4KwElsRBB6N74KwSzqtZaz3xuvGOQjNPsKxxhyn5ybwZIH
         WAXg==
X-Gm-Message-State: APjAAAVUL1XgNvvQ/NvXNyWg6U9L0XGu9fUKLAQPU0/lo4WzpI5ITWxn
        uh0uAd7174LwoaymCb0Puia1GTPl046YfmL7xqmy/P6P1Mo=
X-Google-Smtp-Source: APXvYqyhX4WlL4Q71g4CdNek3Kk4dFtUbgCBo4DXfQ6Lty+XVSKNK+0TzcHKnyfC0JkYBpN2hCzgTBq9DcN/zremN9g=
X-Received: by 2002:a92:46c9:: with SMTP id d70mr10672598ilk.159.1574006821132;
 Sun, 17 Nov 2019 08:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20191113071836.21041-1-hch@lst.de>
In-Reply-To: <20191113071836.21041-1-hch@lst.de>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Sun, 17 Nov 2019 11:06:50 -0500
Message-ID: <CAPoiz9x9TrC5Pe=pGB=irgV9YreJCp4ZCCSZYoGV4t34neV-JA@mail.gmail.com>
Subject: Re: Remove the calgary iommu driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> per the discussion a few month ago with Jon we've agreed that the
> calgary iommu driver is obsolete and in the way. Jon said back then
> he'd send a patch to remove it, but as that didn't happen I prepared
> one, plus two small cleanups touching the same area.


My apologies.  I have one queued but forgot to actually send.  Since
you already did the work, no point and sending it now.  Sorry for the
oversight.

Thanks,
Jon
