Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541F812DF03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 14:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAANS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 08:18:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39023 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAANS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 08:18:26 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so2185681pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y73WD0esFVIiFKwnv49K8dSksfT/GdQG+qhY8YjmiSI=;
        b=BipOJKK+MrbPsqPnJ6WVVV5UqsZU/CD8nlnLhr+rXryGQzXaLfZu1VefIOB4BaFIOX
         SMs/uO+ouFRqvOStoOO3a/oq0Az4gd3G0mAaEpBZotVAW6v9WMVV0U0+2yx88rFqTppC
         RBWOqAEIreLq6CY8mFw02CC9pZ5htfjkpTiS5vpfImQKKHj0JEVBOgxr1E7v3ZwQjtJa
         UMchZ/IXXWL/j8wXbsuFLzSdgVmb2y9HPadjOSM307TSmMOv8wz5td5oTBRldiLhomhD
         2F+STESbVH7Xe53MT/5ZGTtuaZJQhgBA3Vtum+wO9grOzt9HlmJUTNONtMKW+Mr5c7Ft
         LYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y73WD0esFVIiFKwnv49K8dSksfT/GdQG+qhY8YjmiSI=;
        b=NvRi/mgZ2RgChOf4IW5xee1nE+4Q2wdWyMbVrNprrKWty09IVKZyO1tsPzi5gChF2f
         ZNkGn6M0ARanzDbtUfIgRIwtjunZwQXV3DPCpMnImUBM2UrUtbw8DzH90UDXUBbshSAG
         ktyUSfpJu6IlEw+4xgb3IfXq1BVlmRoHBNvQ/ltrPIdSbEGCk/Oy2nKcSmKX6q8S8IIY
         00pItwwf5bN5KMtmxT4rV3pjYP6jyQClnmUHsEoP2csSK6dM/KoKXRbliaNom1AZC2Sr
         mem5UkL1VHyh35jjmq1OacahPxZUIwvyq1pDOM47i0JGSz1WMqb+dCqCfKW+rcr3MDeT
         HMiA==
X-Gm-Message-State: APjAAAVBa5cePQQgnzKBtfTtJfeRmoraFcr3il0as0Gl6GWmiDsqTYul
        aBNpHdYGEP1b58YcQzgFAp8=
X-Google-Smtp-Source: APXvYqxlH6P3MmEX0ilr1ZXn9Vfx+MzG+wKLV/MLddlx/93PRfl+ux4aqt0UIBTGjTooVcn3IQssoQ==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr13300122pjo.84.1577884705698;
        Wed, 01 Jan 2020 05:18:25 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id g8sm59323171pfh.43.2020.01.01.05.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 05:18:25 -0800 (PST)
Date:   Wed, 1 Jan 2020 18:48:19 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] siox: Use the correct style for SPDX License Identifier
Message-ID: <20200101131817.GA2895@nishad>
References: <20191228071544.GA5214@nishad>
 <20191230125232.5ykjy3foljqjvhz4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230125232.5ykjy3foljqjvhz4@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 01:52:32PM +0100, Uwe Kleine-König wrote:
> On Sat, Dec 28, 2019 at 12:45:48PM +0530, Nishad Kamdar wrote:
> > This patch corrects the SPDX License Identifier style in
> > header file related to Ecklemann SIOX driver.
> 
> s/Ecklemann/Eckelmann/
> 
> > For C header files Documentation/process/license-rules.rst
> > mandates C-like comments (opposed to C source files where
> > C++ style should be used).
> > 
> > Changes made by using a script provided by Joe Perches here:
> > https://lkml.org/lkml/2019/2/7/46.
> 
> Other than that, I assume this is fine. So if you fix the name above,
> you can add my Acked-by:.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Ok, I'll do that.

Thank you very much for the review.

Regards,
Nishad
