Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85112BCD4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 07:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL1GEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 01:04:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43082 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1GEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 01:04:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so14627933pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qzbNbOIvsP4gAiPfipecf978/GCQrgDk0y62e+93kPs=;
        b=CoVCyv02ia0+aQ/wPvSFRwHD3U41v0VLim6xCWrXuit2TaajL/q6tXDl48MY1a+o3o
         /ORfY6SrSZYOVOZftJvzu1Dd+NfH2mJkTeCP5L/IeWvijAsUgnNIwy2PdRtj+YxESxsL
         3/4/ruvtYs/r5pTEcGyxbhrLElBMVH0eWO9WjPXAN8WaVXvmS/jL17Wmf9R1EMaUYJIw
         OrfDE7C7Q3u0zYWm1SCC3GKuC0PCGFfCeu4EY4Y81AmYvv2T8I0+vkx0P8S3VcrWFK01
         US+Sr2QqVgNhxRLiXBMrpPGVZZlCE42dGEOEDsDZZbmgn+ifvDqaIHhjveJKnqa22Dc3
         gBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qzbNbOIvsP4gAiPfipecf978/GCQrgDk0y62e+93kPs=;
        b=VtSjXb3YCiNQJXh0+TSR/E1a7lqKrDSRO39ote3S3X54ayPFrK5yYSGGF2HdWdDimJ
         sZ4S6bTfgRX2SdYFeRx5eSQsPJYitIAUQxywMnzeNMA7ORCM3AqVWWlNZe6iStJNcO9y
         s6834BXV/fWNpgNdLFcO3qIOKwBoA/QL/ilQpf/Uu6bFDuAMjMidsm/ZlwsGzDx42PQy
         zidyXn/wCUOv86zhqq0UiO6VOY2qAIGq+nl417bosTpia7h4cTd/YPvNRpklKVvWuSWl
         mC0EOOtUXV1klg69KW1AU+NempqRLkLsEOSFfdtC3VZ9qOcE0VRnI2W3i2PA2keAEneO
         PAYg==
X-Gm-Message-State: APjAAAU+d2KhgzshuJN+QWJkZRFVcr60nKY41BiXsVMmKvWLehRzQ5Dy
        aMrKpw+eZ+eN7TKFEISmTJxp+Q==
X-Google-Smtp-Source: APXvYqy0G09EOEAQ9nRCh+onX0Jm1zj5xoft/moo0rStNvLj7EyOjswLMVxkTv68ovPwt/dXExCmcw==
X-Received: by 2002:a63:4282:: with SMTP id p124mr56853187pga.155.1577513081187;
        Fri, 27 Dec 2019 22:04:41 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b8sm43763115pfr.64.2019.12.27.22.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 22:04:40 -0800 (PST)
Date:   Fri, 27 Dec 2019 22:04:39 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: export flush_icache_all to modules
In-Reply-To: <20191217040704.91995-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.1912272204300.194339@viisi.sifive.com>
References: <20191217040704.91995-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Olof Johansson wrote:

> This is needed by LKDTM (crash dump test module), it calls
> flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
> other architectures, the actual implementation is exported, so follow
> that precedence and export it here too.
> 
> Fixes build of CONFIG_LKDTM that fails with:
> ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Thanks Olof, queued for v5.5-rc.


- Paul
