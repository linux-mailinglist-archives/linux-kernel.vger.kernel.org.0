Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF71218C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfLPSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 13:46:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38518 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfLPR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id h20so10168609otn.5;
        Mon, 16 Dec 2019 09:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aw1ByhbMIhX8L3tpVoMfqyhN1NAHJbr1+p+FNO511mw=;
        b=nrMvKXP819hDukBTzAVD5fj7fjnXlO/iuNiZNRauhqvxPAleLPK7PhDPEEswRvauou
         tE53c/EHRbEmJiXf7zwCH3XN3m5qF1s5mYNpEEP5opSLUT4hqqlt0Lg/qtuvo484QaHT
         YXScST/HMAOvoj7jtqkkCKtD7IF/WE2T2jNWQ6Ud+35aOhIysvPZmFeHehQ7CoaQU+eT
         jDPZb8FuJcQQCNIC/eMpFJ5MiiKFHC9dQGhG76hFmKvNqQu2HkNhpO7HnYUXjOaFMIZH
         0W8gIt9at6MDjIvNujZtzkBsAW5F9lYwDMU7GZBT0b+A1lvtHCcMdVK+Qvy+t/m5HbZO
         u5Fw==
X-Gm-Message-State: APjAAAWIBm03hyu+rzzmsyhE6g4uB4ZnbfPNrsylMvyBZRSb5eIpn/ye
        ui71fIhptEQUiaITI3GjLQ==
X-Google-Smtp-Source: APXvYqwnnF6ea7JjKjRTbA+MoqjFiZwsAnK2w39lJst7Lqh4AyRaVH2JJ0Lo6JAUE+Ksjh06jg4ewA==
X-Received: by 2002:a9d:600e:: with SMTP id h14mr32060423otj.113.1576518977031;
        Mon, 16 Dec 2019 09:56:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p127sm7017255oig.26.2019.12.16.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 09:56:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:56:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH RESEND 1/2] dt-bindings: phy: drop #clock-cells from
 rockchip,px30-dsi-dphy
Message-ID: <20191216175615.GA23392@bogus>
References: <20191216122448.27867-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216122448.27867-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 13:24:47 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Further review of the dsi components for the px30 revealed that the
> phy shouldn't expose the pll as clock but instead handle settings
> via phy parameters.
> 
> As the phy binding is new and not used anywhere yet, just drop them
> so they don't get used.
> 
> Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
> Hi Kishon,
> 
> maybe suitable as a fix for 5.5-rc?
> 
> Thanks
> Heiko
> 
>  .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      | 5 -----
>  1 file changed, 5 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
