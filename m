Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3162014C433
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 01:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgA2AuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 19:50:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35204 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgA2AuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:50:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so7559610pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 16:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtNwsIz/W7qDWOcJUjaKUjRqPUfUXvWolVXPNlG9RVA=;
        b=KKASxA8DV59bYBHWLr+QfIA98DhVmF8ENqWpGyZs6PC4FcVE2tsQhCwNoVpqfw85G1
         7Cw1lfplMY0S9jhrGHbkKHbqijvUljIvoF8VIr84Xe1/yYF2WP5KzEMMfuyOruPhYLIM
         +fK6XIhWw3YZ0osJCdhT9z7ECP1tlvwqoVy42afX7WPSNPkjw4rwyS01B3EUVhSPIshg
         JON7Zi93g2SiagUuO4moB86rQWOwj+NpTOJRvAf12BbTa/i1W+fmF2gTI2jZ7i4c98Jt
         9wIUfHHQ348fJeA4hcytg19DWfKl5NpfekYdEb/xcx3Rvr85TgYrOgdndEsmFoPvEAsn
         VHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtNwsIz/W7qDWOcJUjaKUjRqPUfUXvWolVXPNlG9RVA=;
        b=agpb9K+tcdyhUnRj1NpQT8+SykqHd9jekh9r91LG/pGAJ3/9o7cAQllkNZqp2JoWUK
         e4El39KRcqHZVxNIbxAcnt09opHb4Q0JocSUgzEE/kFVXtdcbBijxUqJvi67NvOcK737
         447Mc0ewCjThKsPrccLyYSq4IJi7dO6Qf98xWQKEY2EQ2TaGm2pey2eR1Lm/+c1ZiK52
         Tp3UypRbxtzcZz9nfdT5QwlYxYvEqYcEEGgPyq/AmzlaBf69fjIN9luAquT1lpDIROAx
         n68jV4ZyOP5RyNUtCKSguyY8UJBf2M6OVFEWp8ykzpeBbKd4NyTDbmhW2sd19ziBFqdy
         LUXA==
X-Gm-Message-State: APjAAAU3gNIynZ4eFyNLZjrN9WUtxnjXpb0xwHVMpGNi01PYfyZkeT1o
        xZV7x45BHUj/x7qM2M5iB6U=
X-Google-Smtp-Source: APXvYqyLq2pM76s+frdyhsQcfVDzxyDq8fqVKpN4RKXM8hwRvWFpAAEtQqU5CSpm7aBjHASwQMKrxA==
X-Received: by 2002:a63:d041:: with SMTP id s1mr27779718pgi.363.1580259020135;
        Tue, 28 Jan 2020 16:50:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a21sm259688pgd.12.2020.01.28.16.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 16:50:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
Date:   Tue, 28 Jan 2020 16:50:18 -0800
Message-Id: <20200129005018.10729-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124111700.29910-1-nsaenzjulienne@suse.de>
References: <20200124111700.29910-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020 12:17:00 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> With the introduction of 738987a1d6f1 ("mmc: bcm2835: Use
> dma_request_chan() instead dma_request_slave_channel()") sdhost-bcm2835
> now waits for its DMA channel to be available when defined in the
> device-tree (it would previously default to PIO). Albeit the right
> behaviour, the MMC host is needed for booting. So this makes sure the
> DMA channel shows up in time.
> 
> Fixes: 738987a1d6f1 ("mmc: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to defconfig-arm64/next, thanks!
--
Florian
