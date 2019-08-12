Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27E8A6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfHLTNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 15:13:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46757 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHLTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:13:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id j15so10366039qtl.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 12:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=zjsjue2/i6SYdRgpGrXmaLlmo1Lo60n2tfvsNCu6PhY=;
        b=sILdSMqVbav3FOXO6At3jDQBYtqN5rEi0UG2kfVPAmZmrwtTjGsUJ7xVy3XWXajnzx
         1A15mKo1MSbwFp+Bxu7gMZGRf/pm+YWh7MRr35AylFIFN8LFLb8Grd9z5G2t2pkjuHz5
         uFF1Mr8bAedpN4tJVXLeN/yoCBxK6bob2tQHbS9ezjPzrSzAghacCoNQuyn9KPAZJYJd
         sUz7cZPOlyAW+/3Zfb+7b4CvnGsQKnaJSdBaj+5/XCluKcwZi6lNPRhQxji4NZ/OX7pr
         Mc8eKx/nEGUuXjkC/atA8R0MDh/ZW9g0vg5EsJjWFPkdWNsNMZNGtsnvf+LJwEDaRyR0
         TKeA==
X-Gm-Message-State: APjAAAX2aGa7kblTSuhqg7IZx1Oo8v+qVqIwr7AqHumxtp3lCeS+S0Ca
        9MQhPdG7pCK3lJfTD0FNOeYsRw==
X-Google-Smtp-Source: APXvYqyhQHSaIUfWESNxYtrf1WNBT99uoiJxc5Q3fOGPGD4A3C/qjTBsXQMnZVX4LbNqKd0kbglzzw==
X-Received: by 2002:ac8:e45:: with SMTP id j5mr18467192qti.149.1565637203451;
        Mon, 12 Aug 2019 12:13:23 -0700 (PDT)
Received: from whitewolf.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id b123sm6265077qkf.85.2019.08.12.12.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:13:22 -0700 (PDT)
Message-ID: <c526638ef31f5b8fb7782e1a4f034fcf78088c4a.camel@redhat.com>
Subject: Re: [PATCH] PCI: Use pci_reset_bus() in
 quirk_reset_lenovo_thinkpad_50_nvgpu()
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>, linux-kernel@vger.kernel.org
Date:   Mon, 12 Aug 2019 15:13:20 -0400
In-Reply-To: <20190801220117.14952-1-lyude@redhat.com>
References: <20190801220117.14952-1-lyude@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, is there any update on getting this accepted?

On Thu, 2019-08-01 at 18:01 -0400, Lyude Paul wrote:
> Since quirk_nvidia_hda() was added there's now two nvidia device
> functions on any laptops with nvidia GPUs: the HDA controller, and the
> GPU itself. Unfortunately this has the sideaffect of breaking
> quirk_reset_lenovo_thinkpad_50_nvgpu() since pci_reset_function() was
> using pci_parent_bus_reset() to reset the GPU's respective PCI bus, and
> pci_parent_bus_reset() does not work on busses which have more then a
> single device function present.
> 
> So, fix this by simply calling pci_reset_bus() instead which properly
> resets the GPU bus and all device functions under it, including both the
> GPU and the HDA controller.
> 
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Aaron Plattner <aplattner@nvidia.com>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Maik Freudenberg <hhfeuer@gmx.de>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..44c4ae1abd00 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5256,7 +5256,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct
> pci_dev *pdev)
>  	 */
>  	if (ioread32(map + 0x2240c) & 0x2) {
>  		pci_info(pdev, FW_BUG "GPU left initialized by EFI,
> resetting\n");
> -		ret = pci_reset_function(pdev);
> +		ret = pci_reset_bus(pdev);
>  		if (ret < 0)
>  			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
>  	}

