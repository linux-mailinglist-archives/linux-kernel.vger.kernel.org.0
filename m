Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBD14B8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbgA1O23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 09:28:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43327 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733167AbgA1O2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:28:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so10373502qtj.10;
        Tue, 28 Jan 2020 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yqk1C8lrdb1DLZld5pSoFu2cPtA+P5GkIV0KjhIeFLk=;
        b=kjxIEoKg7/lM1dYRY7dMYZWFhLw7CXiG/2RzEle7ozn+Bbh1YTvzzuu5w1W5yaGIvf
         s0LMpj9VKu5qYKZqF7FIl1CDGSZnpG1d3rTFV5f3gf7C6KpTPqcI2DWzno27Vqx8hfeZ
         uOFUN8TDRnHidIXo/6JuAOdvYaQQJC4yp5u0TXwyWOFxD62J6EW5C0aSokL3gR/RBnzK
         Lm3BM+96Xu8x0oVCBFIfI3vITJAq4pmb2B0Tayb/I9ocAb8s2WDvKUyypQfQDVe5alJo
         ho9ncw42EdtEOrggMysKX324UQnXwldzRCC5k4Jnw5DFDgMtP4aTbX77NYVX0kk+14B5
         gLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Yqk1C8lrdb1DLZld5pSoFu2cPtA+P5GkIV0KjhIeFLk=;
        b=lGmz4tM0Ox934aFVTw9V4Rxhf6i+b7UEPqQjql6iE64hQ4yrNeW6S8cG0NIo4ppm3v
         5r3Two5cbDRTEGfQZvBce32TwJTb5cJspvLh7DbRE/Krcul6D3iNhbEZpZNC/6ldSS6t
         bRcZu1NFFvz4SOQrh8jGCyAEpH4fQpe1RbebotNRUdKfGzf5S8zx0RrucSd63ZP6hgrT
         XDLSelzHZoH18DsIpHZxFeGj4t80GPl5WjD4+hv8kWRhAwE7pXCH9QLZJ+NttT+2k7+Y
         HBqvhiBBx6KimwZI48wDRVGaVkDi558T/YETWEATQkf5u0gx3eO9+Eob+wCdL/iQ6T6i
         o6gw==
X-Gm-Message-State: APjAAAVjx+2a5WTk+U36oG541ojPb0THFqneGISpgsVlHttDU72IBg0l
        ill3Ow+uBTQdom/LPpbvRjY=
X-Google-Smtp-Source: APXvYqzup1fp+i+JnWooocuItDd8YhwjZJebyMt1IdjaR/2bX5lUVpHSb/AIFej5XajdmTGSiOcnkA==
X-Received: by 2002:aed:3765:: with SMTP id i92mr17267845qtb.373.1580221703523;
        Tue, 28 Jan 2020 06:28:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:99c])
        by smtp.gmail.com with ESMTPSA id h12sm6197278qtn.56.2020.01.28.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 06:28:23 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:28:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/28] ata: remove stale maintainership information from
 core code
Message-ID: <20200128142822.GD180576@mtj.thefacebook.com>
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
 <CGME20200128133410eucas1p271284329b9b63c2c48167308809c569c@eucas1p2.samsung.com>
 <20200128133343.29905-2-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128133343.29905-2-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:33:16PM +0100, Bartlomiej Zolnierkiewicz wrote:
> In commit 7634ccd2da97 ("libata: maintainership update") from 2018
> Jens has officially taken over libata maintainership from Tejun so
> remove stale information from core libata code.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
