Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2412E451
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 10:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgABJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 04:17:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgABJRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:17:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so5016278wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P1yWpMNEaxwfIBhRDW7wOP3v2KrBiS92A23C5dUv0dM=;
        b=y81PQg98Hdora/vXrikMhof4CFV0BFU5ILO38gK/0YInu2e8p2/0GsezmrVF+0Xxiw
         AWIIU1SGy9e5WxiOzlTVBcNub5ufgG1fgT4WdFj2hOmEpwAH/Z4fwZZN3N1oFHPImDJa
         VbKZLJNzyHk7bdq11OWQiEWqsN5N1LiYr1ZlruexAa2RuvJk8o/nM7s2gZ+lu8Q/HpiW
         r6LNzP9nL95K31tHZ9pxbI9OxFUVU7xhk1nOUFV/tDc6DDu/yy7Ub4x3GVnz2gG69IWr
         OHxItQmS1mu42rmxOQip7QiSaqGqdC1NeuE2UqOn4Zbl1UCC1lwaDIyrASe9uJmo0dE8
         GesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P1yWpMNEaxwfIBhRDW7wOP3v2KrBiS92A23C5dUv0dM=;
        b=U1TQ4QKahShHCua3ku8NDsVG1FkuU1Wn5Z0n/v7rmolM2xnzrtpfug0QPbBKT0+gU/
         YMkaCNGUFZC+3op4BaG5JVwkDTLKB3rAdLvRwkxvobotnP7utbB8w9eE1wKY/3uUlB07
         qEdRdCQayspbjI2MIQLeywJ5Wzwb0i5bHEd//u2ATCo0psv/ziK2px+A74VLTPZ4jJ3Z
         qbFTBHC6fDFYoGoPkVh9Bon3FI/CgBLBpg8MF7kBo5zrGGutm6w3sSowCDkBKHD1vuZY
         LlJZbuXUU1AnRxdSHR/ttOqdGwhQ+XzhRZuWv10A7XrdYINhgbJyM94keKILg6X+nYrx
         rdgw==
X-Gm-Message-State: APjAAAUNs7FHaQVQBsmzokMnmLQzF9XyryrrAq0bwi7b1Jn/HEo7ryO3
        XgcFaun/Vz3QoKQh2ksTA2PgwmVIaTU=
X-Google-Smtp-Source: APXvYqyIHfgXCJU+HRibS9maCaPQRnzOAHtBic0biheyfooYAqMbVmoEhPZbjRBEN+HP4RqHEW4DKQ==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr14013277wmm.1.1577956641913;
        Thu, 02 Jan 2020 01:17:21 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id s3sm8055843wmh.25.2020.01.02.01.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:17:21 -0800 (PST)
Date:   Thu, 2 Jan 2020 09:17:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/37] mfd: intel_soc_pmic_mrfld: Convert to use new SCU
 IPC API
Message-ID: <20200102091733.GF22390@dell>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-29-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141716.13727-29-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Mika Westerberg wrote:

> This converts the Intel Merrifield PMIC driver over the new SCU IPC API
> where the SCU IPC instance is passed to the functions.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_mrfld.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
