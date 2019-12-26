Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5D12AEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 22:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLZVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 16:07:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44311 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:07:51 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so20968169iln.11;
        Thu, 26 Dec 2019 13:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9k7wtgHRpTwMfH9WAD4FBjZIk1Pn3L2y9QCGxHvomLY=;
        b=oniZcOF2yRTipYcg2ir3OjHbAivyNw+RfpSkAbTpJteXj6hdn/vrTi1L8n0wI5By4i
         OD7k0Pm2eyPRRyiZnt18R1pP4ifOB0z7g4SBsdoau5CFm1ItCAZSyRZ2/C8MuN13KyZX
         EWzfJjW6CQHWtOGv2I1xs7kjb9oz0J2vxXLegCqaeBOAp9yYeThnAsUB1Bj9YgZgI6Gn
         l+HYFjbqy78uPUd+Gkt4NwDlrsSqr+ElbojhP1YAfIGtBO5rNRVL8qeEX5G30XMvtbgd
         +NsA6s8GFfLZbxED2UhGB72ykSH4G5ozkXQLVMITMQkyH6almTpliWQTwJ+wD/7ftX4Q
         g8AA==
X-Gm-Message-State: APjAAAXVw4io2VcXM1d5u5xKZUKsjd2K5Os09kozir9nvql3/6e5jCqi
        x+adqYhcm4TzRNCX3nj13w==
X-Google-Smtp-Source: APXvYqwxReudgDker7RqATUPrRlMIKQR3psE0VCnX9ECL4NfM9Ca/U71NcgWX1o7p7T/fabL70b0iA==
X-Received: by 2002:a92:8904:: with SMTP id n4mr7990735ild.88.1577394470816;
        Thu, 26 Dec 2019 13:07:50 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u13sm8968291iof.2.2019.12.26.13.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:07:50 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:07:48 -0700
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <akash@openedev.com>
Cc:     heiko@sntech.de, jagan@openedev.com, tom@radxa.com,
        kever.yang@rock-chips.com, Akash Gajjar <akash@openedev.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] phy: phy-rockchip-inno-usb2: add usb2-phy support
 for RK3308 SoC
Message-ID: <20191226210748.GA27760@bogus>
References: <20191217075722.11646-1-akash@openedev.com>
 <20191217075722.11646-3-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217075722.11646-3-akash@openedev.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 13:27:15 +0530, Akash Gajjar wrote:
> This patch adds usb2-phy support for RK3308 SoCs and amend phy Documentation.
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.txt   |  1 +
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
