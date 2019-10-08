Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D9CFA7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfJHMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:53:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40369 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfJHMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:53:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10558069wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lG0BiHGKtQJYQPseYgImOuh5oBQYI7JsqZj/f9OA+vE=;
        b=xoe0O4j3lww/x6vqoirLYDGCX64FXGWzyddsGQpfvipXVuEaQ7TMr2CgAcaXLf1V6H
         +ydiGzyxPlIgtyC1Sr1Eh+G0zgk4hxy5U8BJJ3j0TcjD+JdgpayxF0BOcMeK/EpPqHJl
         o8mKJYsXh06uQRskf0yu3D06HKoz9DBnLROTTSs1TNH2+Vys1PuYj/mNgdc3f5oe3BN6
         f9BJnj00RiqUmVYoEkEpg9958dhyQK4abl2Lm3YfE4N0bQR90zA4YgEnJL4lcOjyFU9M
         TV8y0Yv86KuFTLSorLdKAWbPgg+3lSDrM//kxGGuEd0EqQkUmVP8iguq23eLYZahGTvS
         CQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lG0BiHGKtQJYQPseYgImOuh5oBQYI7JsqZj/f9OA+vE=;
        b=Obtt3X5JsJDgJFfovMOVVdPUJMwzdvSPyUcVxNJp5liOkh0yh3EOwClzX/+0KKZfFv
         9WHuJ72wnvVXGaCXcTOm9KWtHkcenvi3pE726ztjl+dCTQ1XECTHyPva77jjUv65vq5v
         BSJMv0jyTpMJGe2NqUIzvyMAEVY29pGesyjL3Ou9C/AVtQv8/rNFyDzXFm6zLEvplIK9
         4ez2LJBYckXF2gLRxZjCjUXe7GNVhLa4I02IJbxjj9IWFT6mYlFUMXkRYYSOBVs0RQNv
         0a/ltwQ0Uzotd7R9aWvOCEULvi5k1c/LR3WZ2241aH8EAhHwHVlbqLG53P8vUE+eh/fH
         xFTA==
X-Gm-Message-State: APjAAAWZquupchUS1nlQ8/5K7u574RAYJHHIQwU6TsK947CVZwX1YyT4
        n7zb0PuA2N4YOImm+iIAsgHwzw==
X-Google-Smtp-Source: APXvYqzo1BULuW1CrUYm6GTWgJq7cZTmwoSWhlDLfCFufnn7CgCC+k8buity1Fq9XHEMYMvQtOKm/Q==
X-Received: by 2002:adf:e60d:: with SMTP id p13mr10866374wrm.298.1570539235767;
        Tue, 08 Oct 2019 05:53:55 -0700 (PDT)
Received: from [64.233.167.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id o18sm5028415wrw.90.2019.10.08.05.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:53:54 -0700 (PDT)
Subject: Re: [PATCH] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, git@xilinx.com,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        linux-pci@vger.kernel.org
References: <20191008124723.GA161444@google.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <a23f5c0c-6f0b-69bb-78d4-553986157dcd@monstr.eu>
Date:   Tue, 8 Oct 2019 14:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008124723.GA161444@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 10. 19 14:47, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2019 at 12:39:22PM +0200, Michal Simek wrote:
>> From: Kuldeep Dave <kuldeep.dave@xilinx.com>
>>
>> Add Microblaze as an arch that supports PCI_MSI_IRQ_DOMAIN.
>> Enabling msi.h generation is done by separate patch.
>>
>> Similar change was done by commit 2a9af0273c1c
>> ("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V")
>>
>> Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
>> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> Arch part was sent here:
>> https://lkml.org/lkml/2019/10/8/277
> 
> Can you please squash this drivers/pci/Kconfig change into the same
> patch as the arch/microblaze patch mentioned above?  That way there's
> no ordering issue between the two patches.  I'd be glad to merge it,
> or you can add my ack and apply it via the Microblaze tree.  Just let
> me know which you prefer so I know whether to do something with this.
> 
> Sorry; I probably suggested the splitting in the first place for
> RISC-V, but I think that was a mistake.

I was splitting them based on RISC-V case to follow this pattern.
Anyway I will send v2 and please pick it via your tree.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

