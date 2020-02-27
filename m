Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0906717289C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgB0T3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 14:29:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0T3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:29:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so157982wrx.11;
        Thu, 27 Feb 2020 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ts+uSIKuoMAT4GVlY0xYp++rOG/WfuZn269REQF9/WI=;
        b=I0bRD9FLZLEifaJVygPjHYFoM6s4ZauKp9Ur7rpMtb+um53Ml9hWW6QBx0T9PyWyOG
         IrmX+XF0avqqEzPJV+/uk+sCByBtJup1kJeD4lGT+mlD7d2Ve66sOUjYX6OiuAX323u6
         MaMM5Yu2RjvjZJ7DvCyZGgVVCxiZs2RMYzvu/lb80503mtE+kvzZ+gKbkG4xswTaFkec
         LMhRlbaIEU2R7dX2Pw1AYM7pNwyPO7JFSW0whRCY1SVJUye5UYz2hvfQOdUpWnxH9xGO
         Ip/l2oFQW0BIa3tySzEzBnmWwugGaU8NSv4nVaFJT0l/FOHF42xwRXajRxHuA5Pv2FN6
         A3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ts+uSIKuoMAT4GVlY0xYp++rOG/WfuZn269REQF9/WI=;
        b=HOdNVdXIyKOQ3odiObU64S9xuezkU8Svi81NinCpGA/Z9ptNo+kq3ibPvMcNgi135w
         8U9lzWRoY+mMawyLDQRLzt4dcJ3MYfD6sMhH0fKqG+ZsSLMvZwXv3jCIzPAJROaeKP/R
         Bk/CBkZx+mrI2Zh7T2LUZ5tTfWvpK00nHUoQxOWDhtcxzLiS+VZOi4j1n6qCbK2SaX9p
         /Z7F7PAhfDxQ97xgUFvPpZLOCzhrzTzctaihiEaDPnsNLFNEpqQYee4HypbOs5H/SypM
         3aLi+fsbb0BgbptpG29N02vE6Znbd+6856saiMcWNaqk4N/26kE8p7k8YF7+vpzrDYKl
         OBWw==
X-Gm-Message-State: APjAAAXJ9WqNIsSZAc089YBoLgoees+0NbIGsSmU7X/Zm9HsC6/1M6YB
        ss0xqc0iMzsS20w98Ij68iI=
X-Google-Smtp-Source: APXvYqy1BlYk+WSVAjCb5Zo9RSyLM0W4u08H4uBOcKJqmwQRQm5P/RkPigt4t2fNyrvLi+/GS/Toxg==
X-Received: by 2002:a05:6000:1246:: with SMTP id j6mr357729wrx.233.1582831790230;
        Thu, 27 Feb 2020 11:29:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w1sm8878013wmc.11.2020.02.27.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:29:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm2711: Add pcie0 alias
Date:   Thu, 27 Feb 2020 11:29:46 -0800
Message-Id: <20200227192946.17328-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226164601.20150-1-nsaenzjulienne@suse.de>
References: <20200226164601.20150-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 17:46:00 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> Some bcm2711 revisions have different DMA constraints on the their PCIE
> bus. The lower common denominator, being able to access the lower 3GB of
> memory, is the default setting for now. Newer SoC revisions are able to
> access the whole memory space.
> 
> Raspberry Pi 4's firmware is aware of this limitation and will correct
> the PCIE's dma-ranges property if a pcie0 alias is available. So add
> it.
> 
> Fixes: d5c8dc0d4c88 ("ARM: dts: bcm2711: Enable PCIe controller")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
