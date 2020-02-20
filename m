Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C11664D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 18:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgBTR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 12:29:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35465 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgBTR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:29:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so2964898wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q4qx3jqbEI2LXNLHh2qRlEwTiPf4rASGS8w/sDrnmwg=;
        b=n1Zj7J6egyyu4XSEYNvVUsPUeC5N+ThU079hVverQJdLd2AnzZZi+nOVLVMiYmD/d1
         VLNAtYvTyKBk2g3m4+c54bVWhSvP4hn2rZk81KnDZ4j7zlDNJUyzaJ9lkFsqbdyimamA
         2azfNkSSpWMwnok41dG0eHUk6YUAWnKXAaRLBRBRBqBREaYrOcaPeOm9w3GFOKA+Lrjq
         fX3CyMHoE0gmNRULIVXotRQX+QVtk9AglCEf0fXIUzZFIo7aYyu5o4X95BzxLSwYgFIF
         o5TYPi1ofCdxQkjrz0/0aNtECIQOfrRXA3hou5A3EmDEPIzhbeXqiZ9bg8X4PUM9MQbD
         NuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4qx3jqbEI2LXNLHh2qRlEwTiPf4rASGS8w/sDrnmwg=;
        b=VbR15KXFSZ/bizix2mDSRym+Ggwje6fLbh+1Ms1Evo6tYm9fEyvzQkrys7aC2cWJYY
         WBkaWSJ7yPerGMcAAWrvqmS87EKXmmR+jss/yAx5Z31ZPq0wKNz8e8+aV4Bar76HXvkp
         wH23VUyrGMiqDAWWOVF7Upb2SWSzpdhnrwfzz0dx3wCJJTeT4+AF6tu68XJgdh/Rth0g
         qhfRUoSxvwIhy9Mu2a81S9r3CUpc8C+ra/Hr+Tkoob6dWwIqIXopVp3LEi0kG74KAsJR
         XQKj+Wu1bMqtVogZCGsgbp3QoxwEhUXycnsT4vLJqEKiEfxfQDae9CeSdGcTlx1qZoLf
         4Etw==
X-Gm-Message-State: APjAAAWQwX6tb+Ul0UHcgiXqfpOfGMMFuQEThujtHOiCfSSdQSHikaOs
        /wNMH9FXDPBbvRUL4Tjq21wf8w==
X-Google-Smtp-Source: APXvYqyuQKe1vF0yue4IgSN9scP6sj+6hjjPhnMRt+A7UulmjNFLWqQr6QTq4iwV57oNLCIAzEIlYw==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr5753542wmj.100.1582219767346;
        Thu, 20 Feb 2020 09:29:27 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:98d8:49e6:cdcc:25df])
        by smtp.gmail.com with ESMTPSA id e1sm244147wrt.84.2020.02.20.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:29:26 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:29:24 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv10 08/13] PCI: mobiveil: Add 8-bit and 16-bit CSR
 register accessors
Message-ID: <20200220172924.GI19388@big-machine>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-9-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213040644.45858-9-Zhiqiang.Hou@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 12:06:39PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> There are some 8-bit and 16-bit registers in PCIe configuration
> space, so add these accessors accordingly.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

> ---
> V10:
>  - Changed the return types to reflect the size of the access.
> 
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 623c5f0c4441..72c62b4d8f7b 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -182,10 +182,33 @@ static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
>  	return mobiveil_csr_read(pcie, off, 0x4);
>  }
>  
> +static inline u16 mobiveil_csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return mobiveil_csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u8 mobiveil_csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return mobiveil_csr_read(pcie, off, 0x1);
> +}
> +
> +
>  static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val,
>  				       u32 off)
>  {
>  	mobiveil_csr_write(pcie, val, off, 0x4);
>  }
>  
> +static inline void mobiveil_csr_writew(struct mobiveil_pcie *pcie, u16 val,
> +				       u32 off)
> +{
> +	mobiveil_csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void mobiveil_csr_writeb(struct mobiveil_pcie *pcie, u8 val,
> +				       u32 off)
> +{
> +	mobiveil_csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> -- 
> 2.17.1
> 
