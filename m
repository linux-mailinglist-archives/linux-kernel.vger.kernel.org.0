Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14335EA11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 20:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfD2S1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 14:27:14 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37202 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfD2S1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:27:14 -0400
Received: by mail-it1-f196.google.com with SMTP id r85so581292itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=in8AOYsLLb0alH5eTmWu841W4ZZMfC64SDKGQjp5SiU=;
        b=iqgadAQryMDX1vOZnWi/PBAx1xjHby7EzSHgED1N4p+GkY8R0dK5FYGF9Mtxcwz8Lc
         yVUwWwEGyfmKyQV+N5GAHeXHpDQioChFujdZ6wIWh1HkGyc53cpqryRC6ISAyl0NA8So
         QELoDlLjayadUA6MkJyyH9El1VLiAPdBtSARVS56ymEgjgPo2ezoaII1NI76gMpqPSFI
         WRCd7s37AlnPUj2oqwhSGi2OOPj30tRnLM0tZt1dszK6DofItElkHGh5EdVYB0zLxGYM
         rZYd0KOwjxFs7abVCM/evPQjPvV5NxxiIcAk/Xjra6HEmOX+STrivYWGK9Pkf/s/VGbw
         EgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=in8AOYsLLb0alH5eTmWu841W4ZZMfC64SDKGQjp5SiU=;
        b=JZifocb2qijT5DbyYkldRWEjDZeQFdMLRtsuPwhaZmxnc6sZc2C3/MBCyrzYLMGdLi
         IA7teEB1eX/kfX8M2sB9jneaML4tYzQlCp+4xCUiL1xY6/WkhBDUppdg3lO6XEslDCnP
         Y6Pom+SHyCGZd3WU9G4JF5brxGEL2lwE528WQPRLxT8jA69TesZEfRoVOrQBoW2dlukG
         TQ2KVQmMKWjo2wG4s4qA71fb0f/aNYN262upB8P8p9aRiqkgAn+pkqChfPe/389vl1yy
         m2J+MM7u/6UXR4BHS2wwK0NxS99vgv5+LA8kXE3CKJc02jkq7uSaVLd/YEfelDjQzsMV
         1Mfw==
X-Gm-Message-State: APjAAAVTXlgS7d0osBT8eikSZf/IgGZlocdlakBzkbqFeltBy6oZsTGh
        wMSdFVySIGxwt+nrvvLcwN+ExQ==
X-Google-Smtp-Source: APXvYqzBTMvLrVgdwvL5SgJOJXwo2rN/WxRwOh8ws7n1g7EW4Qr7++TIo1nem58jJsWh5pIz2AWysg==
X-Received: by 2002:a24:1c05:: with SMTP id c5mr313170itc.87.1556562433486;
        Mon, 29 Apr 2019 11:27:13 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id v7sm8716012iop.8.2019.04.29.11.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:27:12 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:27:10 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: avoid Oops if DMA setup fails
Message-ID: <20190429182710.GA209252@google.com>
References: <20190426164740.211139-1-zwisler@google.com>
 <20190426185246.AD8E5206A3@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426185246.AD8E5206A3@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:52:45PM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.0.9, v4.19.36, v4.14.113, v4.9.170, v4.4.178, v3.18.138.
> 
> v5.0.9: Build OK!
> v4.19.36: Build OK!
> v4.14.113: Build OK!
> v4.9.170: Build OK!
> v4.4.178: Failed to apply! Possible dependencies:
>     2bd5bd15a518 ("ASoC: Intel: add bytct-rt5651 machine driver")
>     2dcffcee23a2 ("ASoC: Intel: Create independent acpi match module")
>     595788e475d0 ("ASoC: Intel: tag byt-rt5640 machine driver as deprecated")
>     95f098014815 ("ASoC: Intel: Move apci find machine routines")
>     a395bdd6b24b ("ASoC: intel: Fix sst-dsp dependency on dw stuff")
>     a92ea59b74e2 ("ASoC: Intel: sst: only select sst-firmware when DW DMAC is built-in")
>     cfffcc66a89a ("ASoC: Intel: Load the atom DPCM driver only")
> 
> v3.18.138: Failed to apply! Possible dependencies:
>     0d2135ecadb0 ("ASoC: Intel: Work around to fix HW D3 potential crash issue")
>     13735d1cecec ("ASoC: intel - kconfig: remove SND_SOC_INTEL_SST prompt")
>     161aa49ef1b9 ("ASoC: Intel: Add new dependency for Haswell machine")
>     2106241a6803 ("ASoC: Intel: create common folder and move common files in")
>     282a331fe25c ("ASoC: Intel: Add new dependency for Broadwell machine")
>     2e4f75919e5a ("ASoC: Intel: Add PM support to HSW/BDW PCM driver")
>     34084a436703 ("ASoC: intel: Remove superfluous backslash in Kconfig")
>     544c55c810a5 ("ASoC: Intel: Delete an unnecessary check before the function call "sst_dma_free"")
>     63ae1fe7739e ("ASoC: Intel: Add dependency on DesignWare DMA controller")
>     7dd6bd8926f3 ("ASoC: intel: kconfig - Move DW_DMAC_CORE dependency to machines")
>     85b88a8dd0c7 ("ASoC: Intel: Store the entry_point read from FW file")
>     9449d39b990d ("ASoC: Intel: add function to load firmware image")
>     a395bdd6b24b ("ASoC: intel: Fix sst-dsp dependency on dw stuff")
>     a92ea59b74e2 ("ASoC: Intel: sst: only select sst-firmware when DW DMAC is built-in")
>     aed3c7b77c85 ("ASoC: Intel: Add PM support to HSW/BDW IPC driver")
>     d96c53a193dd ("ASoC: Intel: Add generic support for DSP wake, sleep and stall")
>     e9600bc166d5 ("ASoC: Intel: Make ADSP memory block allocation more generic")
> 
> 
> How should we proceed with this patch?

After reviews I'll send backport patches for v4.4.X and v3.18.X as necessary.
